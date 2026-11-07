----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2025 09:21:05 PM
-- Design Name: 
-- Module Name: ssd7seg - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd7seg is
  Port (
    digit : in  STD_LOGIC_VECTOR(3 downto 0);  
    seg   : out STD_LOGIC_VECTOR(6 downto 0)  
  );
end ssd7seg;

architecture Behavioral of ssd7seg is
begin
  process(digit)
  begin
    case digit is
      when "0000" => seg <= "1000000"; 
when "0001" => seg <= "1111001"; 
when "0010" => seg <= "0100100"; 
when "0011" => seg <= "0110000"; 
when "0100" => seg <= "0011001"; 
when "0101" => seg <= "0010010"; 
when "0110" => seg <= "0000010"; 
when "0111" => seg <= "1111000"; 
when "1000" => seg <= "0000000"; 
when "1001" => seg <= "0010000"; 
when "1010" => seg <= "0111111"; -- minus 
when others => seg <= "0001110";

    end case;
  end process;
end Behavioral;