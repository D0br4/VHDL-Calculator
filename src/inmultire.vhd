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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
    Port (
        a : in  signed(7 downto 0);
        b : in  signed(7 downto 0);
        p : out signed(15 downto 0)
    );
end multiplier;

architecture Behavioral of multiplier is
begin
    process(a, b)
        variable multiplicand : signed(15 downto 0);
        variable multiplier   : signed(7 downto 0);
        variable product      : signed(15 downto 0);
        variable i            : integer;
        variable neg_result   : boolean;
    begin
        
        neg_result := (a(7) xor b(7)) = '1';

        multiplicand := resize(abs(a), 16);
        multiplier := abs(b);
        product := (others => '0');

        
        for i in 0 to 7 loop
            if multiplier(i) = '1' then
                product := product + shift_left(multiplicand, i);
            end if;
        end loop;

       
        if neg_result then
            p <= -product;
        else
            p <= product;
        end if;
    end process;
end Behavioral;