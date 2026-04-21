library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_16bit is
    port(
        i_a: in std_logic_vector(15 downto 0);
        i_b: in std_logic_vector(15 downto 0);

        pass_match: out std_logic
    );
 end entity comparator_16bit;

 architecture rtl of comparator_16bit is
 begin
    pass_match <= '1' when i_a = i_b else '0';
 end architecture rtl;