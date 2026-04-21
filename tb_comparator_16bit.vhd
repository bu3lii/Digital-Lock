library ieee;
use ieee.std_logic_1164.all;

entity tb_comparator_16bit is
end entity tb_comparator_16bit;

architecture sim of tb_comparator_16bit is
    signal s_a,s_b: std_logic_vector(15 downto 0);
    signal pass_match: std_logic := '0';
begin
    dut: entity work.comparator_16bit
     port map(
        i_a => s_a,
        i_b => s_b,
        pass_match => pass_match
    );

    stim_proc: process is
    begin
        -- Test 1: match
        s_a <= x"1234";
        s_b <= x"1234";
        wait for 10 ns;

        -- Test 2: non match
        s_a <= x"1234";
        s_b <= x"5678";
        wait for 10 ns;

        wait;
    end process stim_proc;
end architecture;