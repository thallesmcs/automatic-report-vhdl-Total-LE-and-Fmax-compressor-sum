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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kogge_stone_16 is
    port(
        A   : in  std_logic_vector(15 downto 0);
        B   : in  std_logic_vector(15 downto 0);
        Cin : in  std_logic;
        S   : out std_logic_vector(15 downto 0);
        Cout: out std_logic
    );
end entity;

architecture RTL of kogge_stone_16 is

    -- P e G iniciais
    signal P0, G0 : std_logic_vector(15 downto 0);

    -- Nível 1 (distância 1)
    signal P1, G1 : std_logic_vector(15 downto 0);

    -- Nível 2 (distância 2)
    signal P2, G2 : std_logic_vector(15 downto 0);

    -- Nível 3 (distância 4)
    signal P3, G3 : std_logic_vector(15 downto 0);

    -- Nível 4 (distância 8)
    signal P4, G4 : std_logic_vector(15 downto 0);

    signal C : std_logic_vector(16 downto 0);

begin

--------------------------------------------------------------------
-- 0) P0 e G0 iniciais
--------------------------------------------------------------------
    P0 <= A xor B;
    G0 <= A and B;

    C(0) <= Cin;

--------------------------------------------------------------------
-- 1) Nível 1 - distância = 1
--    (G1[i] = G0[i] or (P0[i] and G0[i-1]))
--    (P1[i] = P0[i] and P0[i-1])
--------------------------------------------------------------------

    G1(0) <= G0(0);
    P1(0) <= P0(0);

    G1(1) <= G0(1) or (P0(1) and G0(0));
    P1(1) <= P0(1) and P0(0);

    G1(2) <= G0(2) or (P0(2) and G0(1));
    P1(2) <= P0(2) and P0(1);

    G1(3) <= G0(3) or (P0(3) and G0(2));
    P1(3) <= P0(3) and P0(2);

    G1(4) <= G0(4) or (P0(4) and G0(3));
    P1(4) <= P0(4) and P0(3);

    G1(5) <= G0(5) or (P0(5) and G0(4));
    P1(5) <= P0(5) and P0(4);

    G1(6) <= G0(6) or (P0(6) and G0(5));
    P1(6) <= P0(6) and P0(5);

    G1(7) <= G0(7) or (P0(7) and G0(6));
    P1(7) <= P0(7) and P0(6);

    G1(8) <= G0(8) or (P0(8) and G0(7));
    P1(8) <= P0(8) and P0(7);

    G1(9) <= G0(9) or (P0(9) and G0(8));
    P1(9) <= P0(9) and P0(8);

    G1(10) <= G0(10) or (P0(10) and G0(9));
    P1(10) <= P0(10) and P0(9);

    G1(11) <= G0(11) or (P0(11) and G0(10));
    P1(11) <= P0(11) and P0(10);

    G1(12) <= G0(12) or (P0(12) and G0(11));
    P1(12) <= P0(12) and P0(11);

    G1(13) <= G0(13) or (P0(13) and G0(12));
    P1(13) <= P0(13) and P0(12);

    G1(14) <= G0(14) or (P0(14) and G0(13));
    P1(14) <= P0(14) and P0(13);

    G1(15) <= G0(15) or (P0(15) and G0(14));
    P1(15) <= P0(15) and P0(14);

--------------------------------------------------------------------
-- 2) Nível 2 - distância = 2
--------------------------------------------------------------------

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

--------------------------------------------------------------------
-- 3) Nível 3 - distância = 4
--------------------------------------------------------------------

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

--------------------------------------------------------------------
-- 4) Nível 4 - distância = 8
--------------------------------------------------------------------

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

    G4(8)  <= G3(8) or (P3(8) and G3(0));
    P4(8)  <= P3(8) and P3(0);

    G4(9)  <= G3(9) or (P3(9) and G3(1));
    P4(9)  <= P3(9) and P3(1);

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

--------------------------------------------------------------------
-- 5) Calculando os carries finais
--------------------------------------------------------------------
    C(1)  <= G0(0)  or (P0(0)  and C(0));
    C(2)  <= G1(1)  or (P1(1)  and C(0));
    C(3)  <= G2(2)  or (P2(2)  and C(0));
    C(4)  <= G3(3)  or (P3(3)  and C(0));
    C(5)  <= G4(4)  or (P4(4)  and C(0));
    C(6)  <= G4(5)  or (P4(5)  and C(0));
    C(7)  <= G4(6)  or (P4(6)  and C(0));
    C(8)  <= G4(7)  or (P4(7)  and C(0));
    C(9)  <= G4(8)  or (P4(8)  and C(0));
    C(10) <= G4(9)  or (P4(9)  and C(0));
    C(11) <= G4(10) or (P4(10) and C(0));
    C(12) <= G4(11) or (P4(11) and C(0));
    C(13) <= G4(12) or (P4(12) and C(0));
    C(14) <= G4(13) or (P4(13) and C(0));
    C(15) <= G4(14) or (P4(14) and C(0));
    C(16) <= G4(15) or (P4(15) and C(0));

--------------------------------------------------------------------
-- 6) Soma final
--------------------------------------------------------------------
    S(0)  <= P0(0)  xor C(0);
    S(1)  <= P0(1)  xor C(1);
    S(2)  <= P0(2)  xor C(2);
    S(3)  <= P0(3)  xor C(3);
    S(4)  <= P0(4)  xor C(4);
    S(5)  <= P0(5)  xor C(5);
    S(6)  <= P0(6)  xor C(6);
    S(7)  <= P0(7)  xor C(7);
    S(8)  <= P0(8)  xor C(8);
    S(9)  <= P0(9)  xor C(9);
    S(10) <= P0(10) xor C(10);
    S(11) <= P0(11) xor C(11);
    S(12) <= P0(12) xor C(12);
    S(13) <= P0(13) xor C(13);
    S(14) <= P0(14) xor C(14);
    S(15) <= P0(15) xor C(15);

    Cout <= C(16);

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

COMPONENT kogge_stone_16 is
    port(
        A   : in  std_logic_vector(15 downto 0);
        B   : in  std_logic_vector(15 downto 0);
        Cin : in  std_logic;
        S   : out std_logic_vector(15 downto 0);
        Cout: out std_logic
    );
end COMPONENT;

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

ENTITY compressor_42_16b_Kogge_Stone IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_Kogge_Stone;

ARCHITECTURE comportamento OF compressor_42_16b_Kogge_Stone IS

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
	
var0: kogge_stone_16 PORT MAP(carry, (cout(15) & sumb), '0', SOMA(16 downto 1), SOMA(17));

END comportamento;
