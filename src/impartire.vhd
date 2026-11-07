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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider is
    Port (
        a : in  signed(7 downto 0);
        b : in  signed(7 downto 0);
        q : out signed(15 downto 0)
    );
end divider;

architecture Behavioral of divider is
begin
    process(a, b)
        variable dividend    : signed(15 downto 0);
        variable divisor     : signed(15 downto 0);
        variable quotient    : signed(15 downto 0);
        variable remainder   : signed(16 downto 0);
        variable i           : integer;
        variable neg_result  : boolean;
    begin
        if b = 0 then
            q <= (others => '0');
        else
            neg_result := (a(7) xor b(7)) = '1';
            dividend := resize(abs(a), 16);
            divisor  := resize(abs(b), 16);
            quotient := (others => '0');
            remainder := (others => '0');

            for i in 15 downto 0 loop
                remainder := shift_left(remainder, 1);
                remainder(0) := dividend(15);
                dividend := shift_left(dividend, 1);

                remainder := remainder - resize(divisor, 17);
                if remainder(16) = '1' then
                    remainder := remainder + resize(divisor, 17);
                    quotient := shift_left(quotient, 1);
                else
                    quotient := shift_left(quotient, 1);
                    quotient(0) := '1';
                end if;
            end loop;

            if neg_result then
                q <= -quotient;
            else
                q <= quotient;
            end if;
        end if;
    end process;
end Behavioral;