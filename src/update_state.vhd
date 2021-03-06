-- Author:  Michael Jørgensen
-- License: Public domain; do with it what you like :-)
-- Project: YM2151 implementation
--
-- Description: This module updates the state information associated with each
-- device.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

use work.ym2151_package.all;

entity update_state is
   port (
      clk_i       : in  std_logic;
      rst_i       : in  std_logic;
      channel_i   : in  channel_t;
      device_i    : in  device_t;
      phase_inc_i : in  std_logic_vector(C_PHASE_WIDTH-1 downto 0);
      delay_i     : in  std_logic_vector(C_DELAY_SIZE-1 downto 0);
      cur_state_i : in  state_t;
      new_state_o : out state_t
   );
end entity update_state;

architecture synthesis of update_state is

   constant C_DELAY_MAX : std_logic_vector(C_DELAY_SIZE-1 downto 0) := (others => '1');
   constant C_ENV_MAX   : std_logic_vector(17 downto 0) := (17 => '0', others => '1');

   signal envelope_sub_s : std_logic_vector(17 downto 0);

   -- Debug
   constant C_DEBUG_MODE               : boolean := false; -- TRUE OR FALSE

   attribute mark_debug                : boolean;
   attribute mark_debug of phase_inc_i : signal is C_DEBUG_MODE;
   attribute mark_debug of cur_state_i : signal is C_DEBUG_MODE;
   attribute mark_debug of new_state_o : signal is C_DEBUG_MODE;

begin

   ----------------------------------------------------
   -- The amount to subtract is obtained by shifting C_SHIFT_AMOUNT.
   ----------------------------------------------------

   envelope_sub_s(17-C_SHIFT_AMOUNT downto 0)  <= cur_state_i.env_cur(17 downto C_SHIFT_AMOUNT);
   envelope_sub_s(17 downto 18-C_SHIFT_AMOUNT) <= (others => '0');


   ----------------------------------------------------
   -- State machine controlling the ADSR envelope.
   ----------------------------------------------------

   p_fsm : process (clk_i)
   begin
      if rising_edge(clk_i) then
         new_state_o <= cur_state_i;

         new_state_o.phase_cur <= cur_state_i.phase_cur + phase_inc_i;

         case cur_state_i.env_state is
            when ATTACK_ST =>
               -- In this state the envelope should increase linearly to maximum.
               if cur_state_i.env_cnt = 0 then
                  new_state_o.env_cnt <= delay_i;  -- Reset counter
                  new_state_o.env_cur <= cur_state_i.env_cur + C_ATTACK_INCREMENT;
               elsif cur_state_i.env_cnt /= C_DELAY_MAX then
                  new_state_o.env_cnt <= cur_state_i.env_cnt - 1;
               end if;

               if cur_state_i.env_cur >= C_ENV_MAX - C_ATTACK_INCREMENT or delay_i = 0 then
                  new_state_o.env_state <= DECAY_ST;
                  new_state_o.env_cur   <= C_ENV_MAX;
                  new_state_o.env_cnt   <= (others => '0');
               end if;

               if device_i.key_onoff = '0' then
                  new_state_o.env_state <= RELEASE_ST;
               end if;

            when DECAY_ST =>
               -- In this state the envelope should decrease exponentially, until
               -- it reaches the value decay_level.
               if cur_state_i.env_cnt = 0 then
                  new_state_o.env_cnt <= delay_i;   -- Reset counter
                  new_state_o.env_cur <= cur_state_i.env_cur - envelope_sub_s;
               elsif cur_state_i.env_cnt /= C_DELAY_MAX then
                  new_state_o.env_cnt <= cur_state_i.env_cnt - 1;
               end if;

               if cur_state_i.env_cur <= ("0" & (not device_i.decay_level) & X"000" & "0") + envelope_sub_s then
                  new_state_o.env_state <= SUSTAIN_ST;
                  new_state_o.env_cur   <= "0" & (not device_i.decay_level) & X"000" & "0";
                  new_state_o.env_cnt   <= (others => '0');
               end if;

               if device_i.key_onoff = '0' then
                  new_state_o.env_state <= RELEASE_ST;
               end if;

            when SUSTAIN_ST =>
               -- In this state the envelope should decrease exponentially, until
               -- it reaches the minimum value, or until Key OFF event.
               if cur_state_i.env_cnt = 0 then
                  new_state_o.env_cnt <= delay_i;   -- Reset counter
                  new_state_o.env_cur <= cur_state_i.env_cur - envelope_sub_s;
               elsif cur_state_i.env_cnt /= C_DELAY_MAX then
                  new_state_o.env_cnt <= cur_state_i.env_cnt - 1;
               end if;

               if device_i.key_onoff = '0' then
                  new_state_o.env_state <= RELEASE_ST;
               end if;

            when RELEASE_ST =>
               -- In this state the envelope should decrease exponentially, until
               -- it reaches the minimum value, or until Key ON event.
               new_state_o.env_cur <= (others => '0');

               if device_i.key_onoff = '1' then
                  new_state_o.env_state <= ATTACK_ST;
                  new_state_o.env_cnt   <= (others => '0');
               end if;
         end case;

         if rst_i = '1' then
            new_state_o.phase_cur <= (others => '0');
            new_state_o.env_state <= RELEASE_ST;
            new_state_o.env_cnt   <= (others => '0');
            new_state_o.env_cur   <= (others => '0');
         end if;
      end if;
   end process p_fsm;

end architecture synthesis;

