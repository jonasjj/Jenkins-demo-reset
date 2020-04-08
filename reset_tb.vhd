library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.sim.all;

entity reset_tb is
end reset_tb; 

architecture sim of reset_tb is

  signal clk : std_logic := '1';
  signal rst_in : std_logic := '0';
  signal rst_out : std_logic;

begin

  clk <= not clk after sim_clk_period / 2;

  DUT : entity seg7.reset(rtl)
  port map (
    clk => clk,
    rst_in => rst_in,
    rst_out => rst_out
  );

  SEQUENCER_PROC : process
  begin
    wait for sim_clk_period * 2;

    report "Check reset at power-on";

    assert rst_out = '1'
      report "rst_out ON at power-on"
      severity failure;
    
    wait for 10 * sim_clk_period;
    assert rst_out = '0'
      report "rst_out OFF after some time"
      severity failure;
    
    report "Check reset ON after rst_in = '1'";

    rst_in <= '1';
    wait for 2 * sim_clk_period;
    assert rst_out = '1'
      report "rst_out ON when rst_in = '1'"
      severity failure;

    report "Check reset OFF after rst_in = '0'";
    
    rst_in <= '0';
    wait for 10 * sim_clk_period;
    assert rst_out = '0'
      report "rst_out OFF some time after rst_in = '0'"
      severity failure;

    print_ok_and_finish;
  end process;

end architecture;