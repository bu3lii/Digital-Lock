library ieee;
use ieee.std_logic_1164.all;

entity digital_lock is
    port (
        i_clk: in std_logic;
        i_key_input: in std_logic_vector(3 downto 0);
        i_key_pressed: in std_logic;
        i_confirm_btn: in std_logic;
        i_save_btn: in std_logic;
        i_lock_btn: in std_logic;

        o_locked: out std_logic

    );
end entity;

architecture rtl of digital_lock is

    signal slowerclk: std_logic;
    signal shift, clearinput, load, start_timer, locked: std_logic;

    signal pass_match, timer_done: std_logic;

    signal input_data: std_logic_vector(15 downto 0);
    signal stored_pass: std_logic_vector(15 downto 0);
    signal digit: std_logic_vector(3 downto 0);


begin

    clock_divider_inst: entity work.clock_divider
     port map(
        clk_in => i_clk,
        clk_out => slowerclk
    );

    keyboard_decoder_inst: entity work.keyboard_decoder
     port map(
        i_key => i_key_input,
        i_key_pressed => i_key_pressed,
        o_digit => digit
    );

    fsm_controller_inst: entity work.fsm_controller
     port map(
        i_clk => i_clk,
        i_key_pressed => i_key_pressed,
        i_confirm_btn => i_confirm_btn,
        i_save_btn => i_save_btn,
        i_lock_btn => i_lock_btn,
        i_pass_match => pass_match,
        i_timer_done => timer_done,
        o_shift => shift,
        o_clearinput => clearinput,
        o_load => load,
        o_start_timer => start_timer,
        o_locked => locked
    );

    input_register_inst: entity work.input_register
     port map(
        i_clk => i_clk,
        i_shift => shift,
        i_clearinput => clearinput,
        i_data => digit,
        o_data => input_data
    );

    password_register_inst: entity work.password_register
     port map(
        i_clk => slowerclk,
        i_load => load,
        i_data => input_data,
        o_data => stored_pass
    );

    comparator_16bit_inst: entity work.comparator_16bit
     port map(
        i_a => input_data,
        i_b => stored_pass,
        pass_match => pass_match
    );

    lock_timer_inst: entity work.lock_timer
     port map(
        i_clk => i_clk,
        i_start_timer => start_timer,
        o_timer_done => timer_done
    );

    o_locked <= locked;

    

end architecture;