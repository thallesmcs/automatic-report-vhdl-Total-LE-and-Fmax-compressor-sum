--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--============================================================
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

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

library ieee;
use ieee.std_logic_1164.all;

entity sklansky_16 is
    port (
        A    : in  std_logic_vector(15 downto 0);
        B    : in  std_logic_vector(15 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(15 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of sklansky_16 is
    -- bitwise generate and propagate
    signal g0, p0 : std_logic_vector(15 downto 0);

    -- prefix levels: level0 = g0/p0 (initial), level1..level4 are intermediate,
    -- final prefixes after 4 levels will be G4/P4
    signal G1, P1 : std_logic_vector(15 downto 0);
    signal G2, P2 : std_logic_vector(15 downto 0);
    signal G3, P3 : std_logic_vector(15 downto 0);
    signal G4, P4 : std_logic_vector(15 downto 0);

    -- carries
    signal c : std_logic_vector(16 downto 0);
begin
    -- basic generate / propagate
    g0 <= A and B;
    p0 <= A xor B;

    -- Level 0 -> Level1 (stride = 1)
    -- for i >= 1: G1(i) = G0(i) or (P0(i) and G0(i-1))
    -- else copy
    G1(0) <= g0(0);
    P1(0) <= p0(0);

    G1(1) <= g0(1) or (p0(1) and g0(0));
    P1(1) <= p0(1) and p0(0);

    G1(2) <= g0(2) or (p0(2) and g0(1));
    P1(2) <= p0(2) and p0(1);

    G1(3) <= g0(3) or (p0(3) and g0(2));
    P1(3) <= p0(3) and p0(2);

    G1(4) <= g0(4) or (p0(4) and g0(3));
    P1(4) <= p0(4) and p0(3);

    G1(5) <= g0(5) or (p0(5) and g0(4));
    P1(5) <= p0(5) and p0(4);

    G1(6) <= g0(6) or (p0(6) and g0(5));
    P1(6) <= p0(6) and p0(5);

    G1(7) <= g0(7) or (p0(7) and g0(6));
    P1(7) <= p0(7) and p0(6);

    G1(8) <= g0(8) or (p0(8) and g0(7));
    P1(8) <= p0(8) and p0(7);

    G1(9) <= g0(9) or (p0(9) and g0(8));
    P1(9) <= p0(9) and p0(8);

    G1(10) <= g0(10) or (p0(10) and g0(9));
    P1(10) <= p0(10) and p0(9);

    G1(11) <= g0(11) or (p0(11) and g0(10));
    P1(11) <= p0(11) and p0(10);

    G1(12) <= g0(12) or (p0(12) and g0(11));
    P1(12) <= p0(12) and p0(11);

    G1(13) <= g0(13) or (p0(13) and g0(12));
    P1(13) <= p0(13) and p0(12);

    G1(14) <= g0(14) or (p0(14) and g0(13));
    P1(14) <= p0(14) and p0(13);

    G1(15) <= g0(15) or (p0(15) and g0(14));
    P1(15) <= p0(15) and p0(14);

    -- Level1 -> Level2 (stride = 2)
    -- for i >= 2: G2(i) = G1(i) or (P1(i) and G1(i-2))
    G2(0) <= G1(0);
    P2(0) <= P1(0);

    G2(1) <= G1(1);
    P2(1) <= P1(1);

    G2(2) <= G1(2) or (P1(2) and G1(0));
    P2(2) <= P1(2) and P1(0);

    G2(3) <= G1(3) or (P1(3) and G1(1));
    P2(3) <= P1(3) and P1(1);

    G2(4) <= G1(4) or (P1(4) and G1(2));
    P2(4) <= P1(4) and P1(2);

    G2(5) <= G1(5) or (P1(5) and G1(3));
    P2(5) <= P1(5) and P1(3);

    G2(6) <= G1(6) or (P1(6) and G1(4));
    P2(6) <= P1(6) and P1(4);

    G2(7) <= G1(7) or (P1(7) and G1(5));
    P2(7) <= P1(7) and P1(5);

    G2(8) <= G1(8) or (P1(8) and G1(6));
    P2(8) <= P1(8) and P1(6);

    G2(9) <= G1(9) or (P1(9) and G1(7));
    P2(9) <= P1(9) and P1(7);

    G2(10) <= G1(10) or (P1(10) and G1(8));
    P2(10) <= P1(10) and P1(8);

    G2(11) <= G1(11) or (P1(11) and G1(9));
    P2(11) <= P1(11) and P1(9);

    G2(12) <= G1(12) or (P1(12) and G1(10));
    P2(12) <= P1(12) and P1(10);

    G2(13) <= G1(13) or (P1(13) and G1(11));
    P2(13) <= P1(13) and P1(11);

    G2(14) <= G1(14) or (P1(14) and G1(12));
    P2(14) <= P1(14) and P1(12);

    G2(15) <= G1(15) or (P1(15) and G1(13));
    P2(15) <= P1(15) and P1(13);

    -- Level2 -> Level3 (stride = 4)
    G3(0) <= G2(0);
    P3(0) <= P2(0);

    G3(1) <= G2(1);
    P3(1) <= P2(1);

    G3(2) <= G2(2);
    P3(2) <= P2(2);

    G3(3) <= G2(3);

    P3(3) <= P2(3);

    G3(4) <= G2(4) or (P2(4) and G2(0));
    P3(4) <= P2(4) and P2(0);

    G3(5) <= G2(5) or (P2(5) and G2(1));
    P3(5) <= P2(5) and P2(1);

    G3(6) <= G2(6) or (P2(6) and G2(2));
    P3(6) <= P2(6) and P2(2);

    G3(7) <= G2(7) or (P2(7) and G2(3));
    P3(7) <= P2(7) and P2(3);

    G3(8) <= G2(8) or (P2(8) and G2(4));
    P3(8) <= P2(8) and P2(4);

    G3(9) <= G2(9) or (P2(9) and G2(5));
    P3(9) <= P2(9) and P2(5);

    G3(10) <= G2(10) or (P2(10) and G2(6));
    P3(10) <= P2(10) and P2(6);

    G3(11) <= G2(11) or (P2(11) and G2(7));
    P3(11) <= P2(11) and P2(7);

    G3(12) <= G2(12) or (P2(12) and G2(8));
    P3(12) <= P2(12) and P2(8);

    G3(13) <= G2(13) or (P2(13) and G2(9));
    P3(13) <= P2(13) and P2(9);

    G3(14) <= G2(14) or (P2(14) and G2(10));
    P3(14) <= P2(14) and P2(10);

    G3(15) <= G2(15) or (P2(15) and G2(11));
    P3(15) <= P2(15) and P2(11);

    -- Level3 -> Level4 (stride = 8)
    G4(0)  <= G3(0);
    P4(0)  <= P3(0);

    G4(1)  <= G3(1);
    P4(1)  <= P3(1);

    G4(2)  <= G3(2);
    P4(2)  <= P3(2);

    G4(3)  <= G3(3);
    P4(3)  <= P3(3);

    G4(4)  <= G3(4);
    P4(4)  <= P3(4);

    G4(5)  <= G3(5);
    P4(5)  <= P3(5);

    G4(6)  <= G3(6);
    P4(6)  <= P3(6);

    G4(7)  <= G3(7);
    P4(7)  <= P3(7);

    G4(8)  <= G3(8)  or (P3(8)  and G3(0));
    P4(8)  <= P3(8)  and P3(0);

    G4(9)  <= G3(9)  or (P3(9)  and G3(1));
    P4(9)  <= P3(9)  and P3(1);

    G4(10) <= G3(10) or (P3(10) and G3(2));
    P4(10) <= P3(10) and P3(2);

    G4(11) <= G3(11) or (P3(11) and G3(3));
    P4(11) <= P3(11) and P3(3);

    G4(12) <= G3(12) or (P3(12) and G3(4));
    P4(12) <= P3(12) and P3(4);

    G4(13) <= G3(13) or (P3(13) and G3(5));
    P4(13) <= P3(13) and P3(5);

    G4(14) <= G3(14) or (P3(14) and G3(6));
    P4(14) <= P3(14) and P3(6);

    G4(15) <= G3(15) or (P3(15) and G3(7));
    P4(15) <= P3(15) and P3(7);

    -- carries: c(0) = Cin; c(i+1) = G4(i) or (P4(i) and Cin)
    c(0) <= Cin;

    c(1)  <= G4(0)  or (P4(0)  and Cin);
    c(2)  <= G4(1)  or (P4(1)  and Cin);
    c(3)  <= G4(2)  or (P4(2)  and Cin);
    c(4)  <= G4(3)  or (P4(3)  and Cin);
    c(5)  <= G4(4)  or (P4(4)  and Cin);
    c(6)  <= G4(5)  or (P4(5)  and Cin);
    c(7)  <= G4(6)  or (P4(6)  and Cin);
    c(8)  <= G4(7)  or (P4(7)  and Cin);
    c(9)  <= G4(8)  or (P4(8)  and Cin);
    c(10) <= G4(9)  or (P4(9)  and Cin);
    c(11) <= G4(10) or (P4(10) and Cin);
    c(12) <= G4(11) or (P4(11) and Cin);
    c(13) <= G4(12) or (P4(12) and Cin);
    c(14) <= G4(13) or (P4(13) and Cin);
    c(15) <= G4(14) or (P4(14) and Cin);
    c(16) <= G4(15) or (P4(15) and Cin);

    -- sum bits
    SUM(0)  <= p0(0) xor c(0);
    SUM(1)  <= p0(1) xor c(1);
    SUM(2)  <= p0(2) xor c(2);
    SUM(3)  <= p0(3) xor c(3);
    SUM(4)  <= p0(4) xor c(4);
    SUM(5)  <= p0(5) xor c(5);
    SUM(6)  <= p0(6) xor c(6);
    SUM(7)  <= p0(7) xor c(7);
    SUM(8)  <= p0(8) xor c(8);
    SUM(9)  <= p0(9) xor c(9);
    SUM(10) <= p0(10) xor c(10);
    SUM(11) <= p0(11) xor c(11);
    SUM(12) <= p0(12) xor c(12);
    SUM(13) <= p0(13) xor c(13);
    SUM(14) <= p0(14) xor c(14);
    SUM(15) <= p0(15) xor c(15);

    Cout <= c(16);

end architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT sklansky_16 is
    port (
        A    : in  std_logic_vector(15 downto 0);
        B    : in  std_logic_vector(15 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(15 downto 0);
        Cout : out std_logic
    );
end  COMPONENT;

end my_components;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

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

PACKAGE my_components1 IS

COMPONENT compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

END my_components1;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY compressor_42_16b_Sklansky IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_Sklansky;

ARCHITECTURE comportamento OF compressor_42_16b_Sklansky IS

SIGNAL cout, carry: STD_LOGIC_VECTOR (15 downto 0); 
SIGNAL sumb: STD_LOGIC_VECTOR (15 downto 1);
SIGNAL COUTa: STD_LOGIC;

BEGIN

comp42_num0: compressor_4entradas PORT MAP(A(0), B(0), C(0), D(0), '0', cout(0), carry(0), SOMA(0));
					
comp42_num1: compressor_4entradas PORT MAP(A(1), B(1), C(1), D(1), cout(0), cout(1), carry(1), sumb(1));
			
comp42_num2: compressor_4entradas PORT MAP(A(2), B(2), C(2), D(2), cout(1), cout(2), carry(2), sumb(2));
								
comp42_num3: compressor_4entradas PORT MAP(A(3), B(3), C(3), D(3), cout(2), cout(3), carry(3), sumb(3));

comp42_num4: compressor_4entradas PORT MAP(A(4), B(4), C(4), D(4), cout(3), cout(4), carry(4), sumb(4));

comp42_num5: compressor_4entradas PORT MAP(A(5), B(5), C(5), D(5), cout(4), cout(5), carry(5), sumb(5));

comp42_num6: compressor_4entradas PORT MAP(A(6), B(6), C(6), D(6), cout(5), cout(6), carry(6), sumb(6));

comp42_num7: compressor_4entradas PORT MAP(A(7), B(7), C(7), D(7), cout(6), cout(7), carry(7), sumb(7));

comp42_num8: compressor_4entradas PORT MAP(A(8), B(8), C(8), D(8), cout(7), cout(8), carry(8), sumb(8));

comp42_num9: compressor_4entradas PORT MAP(A(9), B(9), C(9), D(9), cout(8), cout(9), carry(9), sumb(9));

comp42_num10: compressor_4entradas PORT MAP(A(10), B(10), C(10), D(10), cout(9), cout(10), carry(10), sumb(10));

comp42_num11: compressor_4entradas PORT MAP(A(11), B(11), C(11), D(11), cout(10), cout(11), carry(11), sumb(11));

comp42_num12: compressor_4entradas PORT MAP(A(12), B(12), C(12), D(12), cout(11), cout(12), carry(12), sumb(12));

comp42_num13: compressor_4entradas PORT MAP(A(13), B(13), C(13), D(13), cout(12), cout(13), carry(13), sumb(13));

comp42_num14: compressor_4entradas PORT MAP(A(14), B(14), C(14), D(14), cout(13), cout(14), carry(14), sumb(14));

comp42_num15: compressor_4entradas PORT MAP(A(15), B(15), C(15), D(15), cout(14), cout(15), carry(15), sumb(15));
	
var0: sklansky_16 PORT MAP(carry, (cout(15) & sumb), '0', SOMA(16 downto 1), SOMA(17));

END comportamento;
