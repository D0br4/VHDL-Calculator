----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2025 09:19:08 PM
-- Design Name: 
-- Module Name: substractor8bits - Behavioral
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

entity substractor8bits is
 Port (
        a     : in  STD_LOGIC_VECTOR(7 downto 0);
        b     : in  STD_LOGIC_VECTOR(7 downto 0);
        bin   : in  STD_LOGIC;
        diff  : out STD_LOGIC_VECTOR(7 downto 0);
        bout  : out STD_LOGIC
    );
end substractor8bits;

architecture Behavioral of substractor8bits is
component subtractor_1bit
        Port (
            a    : in  STD_LOGIC;
            b    : in  STD_LOGIC;
            bin  : in  STD_LOGIC;
            diff : out STD_LOGIC;
            bout : out STD_LOGIC
        );
    end component;

    signal borrow : STD_LOGIC_VECTOR(8 downto 0);

begin
    borrow(0) <= bin;

    S0: subtractor_1bit port map(a(0), b(0), borrow(0), diff(0), borrow(1));
    S1: subtractor_1bit port map(a(1), b(1), borrow(1), diff(1), borrow(2));
    S2: subtractor_1bit port map(a(2), b(2), borrow(2), diff(2), borrow(3));
    S3: subtractor_1bit port map(a(3), b(3), borrow(3), diff(3), borrow(4));
    S4: subtractor_1bit port map(a(4), b(4), borrow(4), diff(4), borrow(5));
    S5: subtractor_1bit port map(a(5), b(5), borrow(5), diff(5), borrow(6));
    S6: subtractor_1bit port map(a(6), b(6), borrow(6), diff(6), borrow(7));
    S7: subtractor_1bit port map(a(7), b(7), borrow(7), diff(7), borrow(8));

    bout <= borrow(8);



end Behavioral;
