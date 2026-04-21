library ieee;
use ieee.std_logic_1164.all;

entity digital_lock is
    port (
        i_clk: in std_logic        
    );
end entity;

architecture rtl of digital_lock is
    signal shift, clearinput, load, start_timer, locked: std_logic;

    signal pass_match, timer_done: std_logic;

    signal input_data: std_logic_vector(15 downto 0);
    signal stored_pass: std_logic_vector(15 downto 0);
    signal digit: std_logic_vector(3 downto 0);

    
begin

    

end architecture;