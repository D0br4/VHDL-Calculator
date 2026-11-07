----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2025 09:16:25 PM
-- Design Name: 
-- Module Name: substractor - Behavioral
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


entity subtractor_1bit is
    Port (
        a     : in  STD_LOGIC;
        b     : in  STD_LOGIC;
        bin   : in  STD_LOGIC;
        diff  : out STD_LOGIC;
        bout  : out STD_LOGIC
    );
end subtractor_1bit;

architecture Behavioral of subtractor_1bit is
begin
    diff <= a XOR b XOR bin;
    bout <= ((NOT a) AND b) OR ((NOT (a XOR b)) AND bin);
end Behavioral;
