library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Butuh untuk 'to_unsigned'

entity tb_LED_Blinker is

end tb_LED_Blinker;

architecture Bhv of tb_LED_Blinker is
    component LED_Blinker is  
        port (
            clk : in std_logic;
            en_counter : in std_logic;
            const_b : in std_logic_vector(24 downto 0); -- Input from user so can be adjusted
            led_out : out std_logic
        );
    end component;

    signal clk, en_counter, led_out : std_logic := '0';
    signal const_b : std_logic_vector (24 downto 0) := (others => '0');

    -- Testbench Configuration
    -- Clock Simulator = 100MHz, periode clock = 10ns (5ns high, 5ns low)
    constant clk_period : time := 10 ns;

    -- Toggle time (clock)
    constant test_toggle_value : integer := 10; 
    

    begin
        -- Instantiate UUT
        LEDBLINKER : LED_Blinker port map (
            clk => clk,
            en_counter => en_counter,
            const_b => const_b,
            led_out => led_out
        );
        
        -- Process Clock Generator
        clk_proc : process 
        begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end process clk_proc;
        
        -- Stimulus Process 
        stimulus_proc : process 
        begin
            -- Initialization
            en_counter <= '0'; -- Counter reset
            const_b <= std_logic_vector(to_unsigned(test_toggle_value, 25)); -- Set const_b to 10

            wait for clk_period * 10; -- Wait for 10 cycles to stabilize

            -- Enable counter
            en_counter <= '1';
            wait for clk_period * 100; -- Wait for 100 cycles to observe 10 times LED toggling

            -- Test Pause
            en_counter <= '0'; -- Disable counter
            wait for clk_period * 50; -- Wait for 50 cycles (stop counting)

            -- Re-enable counter
            en_counter <= '1';
            wait for clk_period * 50; -- Wait for another 100 cycles to observe 5 times LED toggling

            -- End simulation
            wait;
        end process stimulus_proc;
end Bhv;