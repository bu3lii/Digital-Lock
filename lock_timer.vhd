library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lock_timer is
    port(
        i_clk: in std_logic;
        i_start_timer: in std_logic;
        o_timer_done: out std_logic
    );
end entity lock_timer;

architecture rtl of lock_timer is
    constant MAX_COUNT: integer := 10000000;
    signal counter: integer := 0;
    signal active: std_logic := '0';
begin
    process(i_clk) is
    begin
        if rising_edge(i_clk) then
            if i_start_timer = '1' then
                active <= '1';
                counter <= 0;
                o_timer_done <= '0';
            elsif active = '1' then
                if counter < MAX_COUNT then
                    counter <= counter + 1;
                    o_timer_done <= '0';
                else
                    o_timer_done <= '1';
                    active <= '0';
                end if;
            end if;
        end if;
    end process;

    

end architecture;