library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LED_Blinker is  
    port (
        clk : in std_logic;
        en_counter : in std_logic;
        const_b : in std_logic_vector(24 downto 0); -- Input from user so can be adjusted
        led_out : out std_logic
    );
end LED_Blinker;

architecture Bhv of LED_Blinker is
    signal reg_counter : unsigned(24 downto 0) := (others => '0'); -- Register for counter
    signal reg_led : std_logic := '0'; -- Register for LED
    signal tick_pulse : std_logic; -- Tick pulse signal
begin
    -- Counter Block Process
    counter_proc : process (clk)
        variable const_b_unsigned : unsigned(24 downto 0);
    begin
        if rising_edge(clk) then
            const_b_unsigned := unsigned(const_b);
            if en_counter = '1' then
                -- Cek apakah counter sudah = const_b
                if reg_counter = (const_b_unsigned - 1) then
                    reg_counter <= (others => '0');
                else
                    reg_counter <= reg_counter + 1;
                end if;
            end if;
        end if;
    end process counter_proc;

    -- Pulse Generator Block Logic
    tick_pulse <= '1' when reg_counter = (unsigned(const_b) - 1) and en_counter = '1' else '0';

    -- LED Toggler Block Process
    led_toggle_proc : process(clk)
    begin
        if rising_edge(clk) then
            if tick_pulse = '1' then
                reg_led <= not reg_led;
            end if;
        end if;
    end process led_toggle_proc;

    -- Assign reg_led to led_out (active low)
    led_out <= not reg_led;
end Bhv;