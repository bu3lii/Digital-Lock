library ieee;
use ieee.std_logic_1164.all;

entity input_register is
    port(
        i_clk: in std_logic;
        i_shift: in std_logic;
        i_clearinput: in std_logic;
        i_data: in std_logic_vector(3 downto 0);
        o_data: out std_logic_vector(15 downto 0)
    );
end entity input_register;

architecture rtl of input_register is
    signal reg: std_logic_vector(15 downto 0);
begin

    process(i_clk) is
        begin
            if rising_edge(i_clk) then
                if i_clearinput = '1' then
                    reg <= (others => '0');
                elsif i_shift = '1' then
                    reg <= reg(11 downto 0) & i_data;
                    end if;
            end if;
    end process;

    o_data <= reg;

    

end architecture;