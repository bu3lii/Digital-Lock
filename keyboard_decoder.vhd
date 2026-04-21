library ieee;
use ieee.std_logic_1164.all;

entity keyboard_decoder is
    port (
        i_key: std_logic_vector(3 downto 0);
        i_key_pressed: in std_logic;
        o_digit: out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of keyboard_decoder is
begin
    process(i_key_pressed,i_key) is
    begin
        if i_key_pressed = '1' then
            o_digit <= i_key;
        else
            o_digit <= "0000";
        end if;
    end process;

    

end architecture;