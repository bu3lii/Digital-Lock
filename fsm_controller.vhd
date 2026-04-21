library ieee;
use ieee.std_logic_1164.all;

entity fsm_controller is
    port(
        i_clk: in std_logic;
        i_key_pressed: in std_logic;
        i_confirm_btn: in std_logic;
        i_save_btn: in std_logic;
        i_lock_btn: in std_logic;
        i_pass_match: in std_logic;
        i_timer_done: in std_logic;

        o_shift: out std_logic;
        o_clearinput: out std_logic;
        o_load: out std_logic;
        o_start_timer: out std_logic;
        o_locked: out std_logic
    );
end entity fsm_controller;

architecture rtl of fsm_controller is
    type state is (S0_LOCKED,S1_READ_KEY,S2_SHIFT_INPUT,S3_VERIFY,S4_UNLOCKED,S5_HALT,S6_WAIT_ACTION,S7_SAVE_PASSWORD);

    signal curr_state, next_state: state;
begin

    process(i_clk) is
    begin
        if rising_edge(i_clk) then
            curr_state <= next_state;
        end if;
    end process;

    process(curr_state,i_key_pressed,i_confirm_btn,i_save_btn,i_lock_btn,i_pass_match,i_timer_done) is
    begin
        case curr_state is
            when S0_LOCKED =>
                if i_key_pressed = '1' then
                    next_state <= S1_READ_KEY;
                else
                    next_state <= S0_LOCKED;
                end if;
            
            when S1_READ_KEY =>
                next_state <= S2_SHIFT_INPUT;

            when S2_SHIFT_INPUT =>
                if i_confirm_btn = '1' then
                    next_state <= S3_VERIFY;
                else
                    next_state <= S1_READ_KEY;
                end if;
            
            when S3_VERIFY =>
                if i_pass_match = '1' then
                    next_state <= S4_UNLOCKED;
                else
                    next_state <= S5_HALT;
                end if;
            
            when S4_UNLOCKED =>
                if i_lock_btn = '1' then
                    next_state <= S0_LOCKED;
                else
                    next_state <= S6_WAIT_ACTION;
                end if;
            
            when S5_HALT =>
                if i_timer_done = '1' then
                    next_state <= S0_LOCKED;
                else
                    next_state <= S5_HALT;
                end if;
            
            when S6_WAIT_ACTION =>
                if i_save_btn = '1' then
                    next_state <= S7_SAVE_PASSWORD;
                else
                    next_state <= S6_WAIT_ACTION;
                end if;
            
            when S7_SAVE_PASSWORD =>
                next_state <= S0_LOCKED;

            when others =>
                next_state <= S0_LOCKED;
        end case;
    end process;
            
    -- TODO: add output logic

    

end architecture;