library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider is
    port(
        clk_in: in std_logic;
        clk_out: out std_logic
    );
end entity clock_divider;

architecture rtl of clock_divider is
    constant DIVISOR : integer := 50000000;
    signal counter: integer := 0;
    signal clk_reg: std_logic := '0';

begin

    process(clk_in) is
    begin
        if rising_edge(clk_in) then
            if counter = DIVISOR/2 then
                clk_reg <= not clk_reg;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;

end architecture;