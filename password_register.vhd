library ieee;
use ieee.std_logic_1164.all;

entity password_register is
    port(
        i_clk: in std_logic;
        i_load: in std_logic;
        i_data: in std_logic_vector(15 downto 0);
        o_data: out std_logic_vector(15 downto 0)
    );
end entity password_register;

architecture rtl of password_register is
    signal reg: std_logic_vector(15 downto 0);
begin
    process(i_clk) is
    begin
        if rising_edge(i_clk) then
            if i_load = '1' then
                reg <= i_data;
            end if;
        end if;
    end process;
    o_data <= reg;
end architecture;