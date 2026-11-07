----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 01:05:53 PM
-- Design Name: 
-- Module Name: convertor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
  Port (
    clk   : in  std_logic;
    bcd0  : in  std_logic_vector(3 downto 0);
    bcd1  : in  std_logic_vector(3 downto 0);
    bcd2  : in  std_logic_vector(3 downto 0);
    bcd3  : in  std_logic_vector(3 downto 0);
    neg   : in  std_logic;  
    seg   : out std_logic_vector(6 downto 0);
    an    : out std_logic_vector(3 downto 0)
  );
end MUX;

architecture Behavioral of MUX is
  signal digit : std_logic_vector(3 downto 0);
  signal counter : unsigned(15 downto 0) := (others => '0');
  signal sel : unsigned(1 downto 0);

  component ssd7seg
    Port (
      digit : in  std_logic_vector(3 downto 0);
      seg   : out std_logic_vector(6 downto 0)
    );
  end component;

begin

  process(clk)
  begin
    if rising_edge(clk) then
      counter <= counter + 1;
      sel <= counter(15 downto 14); 
    end if;
  end process;

  process(sel, bcd0, bcd1, bcd2, bcd3, neg)
  begin
    case sel is
      when "00" =>
        digit <= bcd0;
        an <= "1110";
      when "01" =>
        digit <= bcd1;
        an <= "1101";
      when "10" =>
        digit <= bcd2;
        an <= "1011";
      when others =>
        an <= "0111";
        if neg = '1' then
          digit <= "1010"; --minus
        else
          digit <= bcd3;
        end if;
    end case;
end process;
  DISP: ssd7seg
    port map(digit => digit, seg => seg);

end Behavioral;
