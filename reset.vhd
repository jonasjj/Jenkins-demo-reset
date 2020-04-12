library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset is
  port (
    clk : in std_logic;
    rst_in : in std_logic;
    rst_out : out std_logic
  );
end reset; 

architecture rtl of reset is

  signal shift_reg : std_logic_vector(7 downto 0);

begin

  SHIFT_REG_PROC : process(clk)
  begin
    if rising_edge(clk) then
      shift_reg <= shift_reg(6 downto 0) & not rst_in;
    end if;
  end process;

  RESET_PROC : process(shift_reg)
  begin
    if shift_reg = "11111111" then
      rst_out <= '0';
    else
      rst_out <= '1';
    end if;
  end process;

end architecture;