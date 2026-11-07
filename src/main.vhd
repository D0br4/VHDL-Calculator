----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2025 08:08:24 PM
-- Design Name: 
-- Module Name: fvf - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pocket_computer is
    Port (
        clk    : in  std_logic;
        op1    : in  std_logic_vector(7 downto 0);
        op2    : in  std_logic_vector(7 downto 0);
        opcode : in  std_logic_vector(1 downto 0); 
        seg    : out std_logic_vector(6 downto 0);
        an     : out std_logic_vector(3 downto 0)
    );
end pocket_computer;

architecture Behavioral of pocket_computer is

    signal a, b : std_logic_vector(7 downto 0);
    signal sum, diff : std_logic_vector(7 downto 0);
    signal mul_signed : signed(15 downto 0);
    signal div_res : signed(15 downto 0);
    signal result : signed(15 downto 0);
    signal result_bcd : std_logic_vector(15 downto 0);
    signal bcd0, bcd1, bcd2, bcd3 : std_logic_vector(3 downto 0);
    signal neg : std_logic;
    signal cout, bout : std_logic;

    component adder8bits is
        Port (
            a     : in  std_logic_vector(7 downto 0);
            b     : in  std_logic_vector(7 downto 0);
            cin   : in  std_logic;
            sum   : out std_logic_vector(7 downto 0);
            cout  : out std_logic
        );
    end component;

    component substractor8bits is
        Port (
            a     : in  std_logic_vector(7 downto 0);
            b     : in  std_logic_vector(7 downto 0);
            bin   : in  std_logic;
            diff  : out std_logic_vector(7 downto 0);
            bout  : out std_logic
        );
    end component;

    component multiplier is
    Port (
        a : in  signed(7 downto 0);
        b : in  signed(7 downto 0);
        p : out signed(15 downto 0)
    );
end component;

    component divider is
        Port (
            a, b : in  signed(7 downto 0);
            q    : out signed(15 downto 0)
        );
    end component;

    component convertor is
        Port (
            bin  : in  std_logic_vector(15 downto 0);
            bcd0 : out std_logic_vector(3 downto 0);
            bcd1 : out std_logic_vector(3 downto 0);
            bcd2 : out std_logic_vector(3 downto 0);
            bcd3 : out std_logic_vector(3 downto 0)
        );
    end component;

    component MUX is
        Port (
            clk   : in std_logic;
            bcd0  : in std_logic_vector(3 downto 0);
            bcd1  : in std_logic_vector(3 downto 0);
            bcd2  : in std_logic_vector(3 downto 0);
            bcd3  : in std_logic_vector(3 downto 0);
            neg   : in std_logic;
            seg   : out std_logic_vector(6 downto 0);
            an    : out std_logic_vector(3 downto 0)
        );
    end component;

begin

    a <= op1;
    b <= op2;

    
    ADDER: adder8bits port map(a => a, b => b, cin => '0', sum => sum, cout => cout);
    SUBTR: substractor8bits port map(a => a, b => b, bin => '0', diff => diff, bout => bout);

    
    MULT: multiplier port map(a => signed(a), b => signed(b), p => mul_signed);
    DIV:  divider   port map(a => signed(a), b => signed(b), q => div_res);

    
    process(opcode, sum, diff, mul_signed, div_res)
    begin
        case opcode is
            when "00" => result <= resize(signed(sum), 16);
            when "01" => result <= resize(signed(diff), 16);
            when "10" => result <= mul_signed;
            when "11" => result <= div_res;
            when others => result <= (others => '0');
        end case;
    end process;

    neg <= '1' when result < 0 else '0';
    result_bcd <= std_logic_vector(abs(result));

    
    CONV: convertor port map(
        bin => result_bcd,
        bcd0 => bcd0,
        bcd1 => bcd1,
        bcd2 => bcd2,
        bcd3 => bcd3
    );

    
    DISPLAY: MUX port map(
        clk => clk,
        bcd0 => bcd0,
        bcd1 => bcd1,
        bcd2 => bcd2,
        bcd3 => bcd3,
        neg => neg,
        seg => seg,
        an => an
    );

end Behavioral;