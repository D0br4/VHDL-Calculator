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

entity convertor is
    Port (
    bin  : in  std_logic_vector(15 downto 0);
    bcd0 : out std_logic_vector(3 downto 0);
    bcd1 : out std_logic_vector(3 downto 0);
    bcd2 : out std_logic_vector(3 downto 0);
    bcd3 : out std_logic_vector(3 downto 0)
    );
end convertor;

architecture Behavioral of convertor is
begin
 process(bin)
    variable value : integer;
    variable d0, d1, d2, d3 : integer;
  begin
    value := to_integer(unsigned(bin));

    d3 := value / 1000;
    value := value mod 1000;
    d2 := value / 100;
    value := value mod 100;
    d1 := value / 10;
    d0 := value mod 10;

    bcd0 <= std_logic_vector(to_unsigned(d0, 4));
    bcd1 <= std_logic_vector(to_unsigned(d1, 4));
    bcd2 <= std_logic_vector(to_unsigned(d2, 4));
    bcd3 <= std_logic_vector(to_unsigned(d3, 4));
  end process;

end Behavioral;
