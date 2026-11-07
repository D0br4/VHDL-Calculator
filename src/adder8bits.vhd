----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2025 09:09:05 PM
-- Design Name: 
-- Module Name: adder8bits - Behavioral
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

entity adder8bits is
 Port (
        a     : in  STD_LOGIC_VECTOR(7 downto 0);
        b     : in  STD_LOGIC_VECTOR(7 downto 0);
        cin   : in  STD_LOGIC;
        sum   : out STD_LOGIC_VECTOR(7 downto 0);
        cout  : out STD_LOGIC
    );
end adder8bits;

architecture Behavioral of adder8bits is

component adder
        Port (
            a    : in  STD_LOGIC;
            b    : in  STD_LOGIC;
            cin  : in  STD_LOGIC;
            sum  : out STD_LOGIC;
            cout : out STD_LOGIC
        );
    end component;

    signal carry : STD_LOGIC_VECTOR(8 downto 0);

begin
    carry(0) <= cin;

    FA0: adder port map(a(0), b(0), carry(0), sum(0), carry(1));
    FA1: adder port map(a(1), b(1), carry(1), sum(1), carry(2));
    FA2: adder port map(a(2), b(2), carry(2), sum(2), carry(3));
    FA3: adder port map(a(3), b(3), carry(3), sum(3), carry(4));
    FA4: adder port map(a(4), b(4), carry(4), sum(4), carry(5));
    FA5: adder port map(a(5), b(5), carry(5), sum(5), carry(6));
    FA6: adder port map(a(6), b(6), carry(6), sum(6), carry(7));
    FA7: adder port map(a(7), b(7), carry(7), sum(7), carry(8));

  cout<=carry(8);

end Behavioral;
