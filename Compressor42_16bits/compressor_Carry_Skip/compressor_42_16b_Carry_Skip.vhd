--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--============================================================
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END mux_1bit;

ARCHITECTURE comportamento OF mux_1bit IS
BEGIN
	
	WITH sel SELECT
	   
	   mux_out <=	a WHEN '0',
					b WHEN others;
					
END comportamento;

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
    port(
        A, B, Cin : in  std_logic;
        Sum       : out std_logic;
        Cout      : out std_logic
    );
end entity;

architecture rtl of full_adder is
begin
    Sum  <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;

PACKAGE my_componentsa IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT full_adder is
    port(
        A, B, Cin : in  std_logic;
        Sum       : out std_logic;
        Cout      : out std_logic
    );

end COMPONENT;

END my_componentsa;

library IEEE;
use IEEE.std_logic_1164.all;
USE work.my_componentsa.all;

entity ripple4 is
    port(
        A, B   : in  std_logic_vector(3 downto 0);
        Cin    : in  std_logic;
        Sum    : out std_logic_vector(3 downto 0);
        Cout   : out std_logic;
        Pgroup : out std_logic      -- propagate group
    );
end entity;

architecture rtl of ripple4 is
    signal c : std_logic_vector(4 downto 1);
    signal p : std_logic_vector(3 downto 0);
begin
    FA0: full_adder port map(A(0), B(0), Cin,  Sum(0), c(1));
    FA1: full_adder port map(A(1), B(1), c(1), Sum(1), c(2));
    FA2: full_adder port map(A(2), B(2), c(2), Sum(2), c(3));
    FA3: full_adder port map(A(3), B(3), c(3), Sum(3), c(4));

    Cout <= c(4);

    -- propagate bits
    p(0) <= A(0) xor B(0);
    p(1) <= A(1) xor B(1);
    p(2) <= A(2) xor B(2);
    p(3) <= A(3) xor B(3);

    -- grupo propaga se todos propagam
    Pgroup <= p(0) and p(1) and p(2) and p(3);
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;

PACKAGE my_componentsb IS

COMPONENT ripple4 is
    port(
        A, B   : in  std_logic_vector(3 downto 0);
        Cin    : in  std_logic;
        Sum    : out std_logic_vector(3 downto 0);
        Cout   : out std_logic;
        Pgroup : out std_logic      -- propagate group
    );
end COMPONENT;

END my_componentsb;

library IEEE;
use IEEE.std_logic_1164.all;
USE work.my_componentsb.all;

entity carry_skip_16bit is
    port(
        A, B : in  std_logic_vector(15 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(15 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of carry_skip_16bit is

    -- carries entre blocos
    signal c4,  c8,  c12 : std_logic;

    -- propagação dos blocos
    signal p0, p1, p2, p3 : std_logic;

    -- carries saltados
    signal skip4, skip8, skip12 : std_logic;

begin

    --------------------------------------------------------------------
    -- Bloco 0   (bits 3..0)
    --------------------------------------------------------------------
    B0: ripple4 port map(A(3 downto 0), B(3 downto 0), Cin, Sum(3 downto 0), c4, p0);

    skip4 <= Cin when p0 = '1' else c4;


    --------------------------------------------------------------------
    -- Bloco 1   (bits 7..4)
    --------------------------------------------------------------------
    B1: ripple4 port map(A(7 downto 4), B(7 downto 4), skip4, Sum(7 downto 4), c8, p1);

    skip8 <= skip4 when p1 = '1' else c8;


    --------------------------------------------------------------------
    -- Bloco 2   (bits 11..8)
    --------------------------------------------------------------------
    B2: ripple4 port map(A(11 downto 8), B(11 downto 8), skip8, Sum(11 downto 8), c12, p2);

    skip12 <= skip8 when p2 = '1' else c12;


    --------------------------------------------------------------------
    -- Bloco 3   (bits 15..12)
    --------------------------------------------------------------------
    B3: ripple4 port map(A(15 downto 12), B(15 downto 12), skip12, Sum(15 downto 12), Cout, p3);

end rtl;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsa.all;

ENTITY compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END compressor_4entradas;

ARCHITECTURE comportamento OF compressor_4entradas IS

SIGNAL  out_xor1, out_xor2, out_xor3, out_xor4 :  STD_LOGIC;
SIGNAL	out_mux1, out_mux2 : STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	out_xor2 <= C XOR D;

	out_xor3 <= out_xor1 XOR out_xor2;

	out_xor4 <= Cin XOR out_xor3;
				
    s0: mux_1bit PORT MAP (A, C, out_mux1, out_xor1);
			
    s1: mux_1bit PORT MAP (D, Cin, out_mux2, out_xor3);
	
    Sum <= out_xor4;
	Carry <= out_mux2;
	Cout <= out_mux1;
	 	
END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_componentsc IS

COMPONENT compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

COMPONENT carry_skip_16bit is
    port(
        A, B : in  std_logic_vector(15 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(15 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_componentsc;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_componentsc.all;

ENTITY compressor_42_16b_Carry_Skip IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_Carry_Skip;

ARCHITECTURE comportamento OF compressor_42_16b_Carry_Skip IS

SIGNAL cout, carry: STD_LOGIC_VECTOR (15 downto 0); 
SIGNAL sum: STD_LOGIC_VECTOR (15 downto 1);
SIGNAL COUTa: STD_LOGIC;

BEGIN

comp42_num0: compressor_4entradas PORT MAP(A(0), B(0), C(0), D(0), '0', cout(0), carry(0), SOMA(0));
					
comp42_num1: compressor_4entradas PORT MAP(A(1), B(1), C(1), D(1), cout(0), cout(1), carry(1), sum(1));
			
comp42_num2: compressor_4entradas PORT MAP(A(2), B(2), C(2), D(2), cout(1), cout(2), carry(2), sum(2));
								
comp42_num3: compressor_4entradas PORT MAP(A(3), B(3), C(3), D(3), cout(2), cout(3), carry(3), sum(3));

comp42_num4: compressor_4entradas PORT MAP(A(4), B(4), C(4), D(4), cout(3), cout(4), carry(4), sum(4));

comp42_num5: compressor_4entradas PORT MAP(A(5), B(5), C(5), D(5), cout(4), cout(5), carry(5), sum(5));

comp42_num6: compressor_4entradas PORT MAP(A(6), B(6), C(6), D(6), cout(5), cout(6), carry(6), sum(6));

comp42_num7: compressor_4entradas PORT MAP(A(7), B(7), C(7), D(7), cout(6), cout(7), carry(7), sum(7));

comp42_num8: compressor_4entradas PORT MAP(A(8), B(8), C(8), D(8), cout(7), cout(8), carry(8), sum(8));

comp42_num9: compressor_4entradas PORT MAP(A(9), B(9), C(9), D(9), cout(8), cout(9), carry(9), sum(9));

comp42_num10: compressor_4entradas PORT MAP(A(10), B(10), C(10), D(10), cout(9), cout(10), carry(10), sum(10));

comp42_num11: compressor_4entradas PORT MAP(A(11), B(11), C(11), D(11), cout(10), cout(11), carry(11), sum(11));

comp42_num12: compressor_4entradas PORT MAP(A(12), B(12), C(12), D(12), cout(11), cout(12), carry(12), sum(12));

comp42_num13: compressor_4entradas PORT MAP(A(13), B(13), C(13), D(13), cout(12), cout(13), carry(13), sum(13));

comp42_num14: compressor_4entradas PORT MAP(A(14), B(14), C(14), D(14), cout(13), cout(14), carry(14), sum(14));

comp42_num15: compressor_4entradas PORT MAP(A(15), B(15), C(15), D(15), cout(14), cout(15), carry(15), sum(15));
			
var0: carry_skip_16bit PORT MAP(carry, (cout(15) & sum), '0', SOMA(16 downto 1), SOMA(17));

END comportamento;
