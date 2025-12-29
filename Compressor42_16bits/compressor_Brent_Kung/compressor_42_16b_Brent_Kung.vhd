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

---------------------------------------------------------
-- Bloco PG: calcula propagate e generate elementares
---------------------------------------------------------
entity pg is
    port(
        a, b : in  std_logic;
        p    : out std_logic;
        g    : out std_logic
    );
end pg;

architecture rtl of pg is
begin
    p <= a xor b;
    g <= a and b;
end rtl;

---------------------------------------------------------
-- Bloco PREFIX: (G,P) ? (G,P) -> combinação Brent-Kung
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity prefix is
    port(
        gL, pL : in  std_logic; -- left
        gR, pR : in  std_logic; -- right
        gO, pO : out std_logic  -- output
    );
end prefix;

architecture rtl of prefix is
begin
    gO <= gL or (pL and gR);
    pO <= pL and pR;
end rtl;

---------------------------------------------------------
-- Full Adder final (usa propagate + carry)
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity sum_bit is
    port(
        p : in  std_logic;
        c : in  std_logic;
        s : out std_logic
    );
end sum_bit;

architecture rtl of sum_bit is
begin
    s <= p xor c;
end rtl;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT pg is
    port(
        a, b : in  std_logic;
        p    : out std_logic;
        g    : out std_logic
    );
end COMPONENT;

COMPONENT prefix is
    port(
        gL, pL : in  std_logic; -- left
        gR, pR : in  std_logic; -- right
        gO, pO : out std_logic  -- output
    );
end COMPONENT;

COMPONENT sum_bit is
    port(
        p : in  std_logic;
        c : in  std_logic;
        s : out std_logic
    );
end COMPONENT;

END my_components;

---------------------------------------------------------
-- Brent-Kung 16-bit adder
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_components.all;

entity bk_adder16 is
    port(
        A  : in  std_logic_vector(15 downto 0);
        B  : in  std_logic_vector(15 downto 0);
        Cin: in  std_logic;
        S  : out std_logic_vector(15 downto 0);
        Cout: out std_logic
    );
end bk_adder16;

architecture structural of bk_adder16 is

    -- PG level 0
    signal p : std_logic_vector(15 downto 0);
    signal g : std_logic_vector(15 downto 0);

    -- Prefix levels
    -- Level 1
    signal G1_1, P1_1 : std_logic;
    signal G1_3, P1_3 : std_logic;
    signal G1_5, P1_5 : std_logic;
    signal G1_7, P1_7 : std_logic;
    signal G1_9, P1_9 : std_logic;
    signal G1_11, P1_11 : std_logic;
    signal G1_13, P1_13 : std_logic;
    signal G1_15, P1_15 : std_logic;

    -- Level 2
    signal G2_3, P2_3 : std_logic;
    signal G2_7, P2_7 : std_logic;
    signal G2_11, P2_11 : std_logic;
    signal G2_15, P2_15 : std_logic;

    -- Level 3
    signal G3_7, P3_7 : std_logic;
    signal G3_15, P3_15 : std_logic;

    -- Level 4
    signal G4_15, P4_15 : std_logic;

    -- Carries
    signal C : std_logic_vector(16 downto 0);

begin
    -----------------------------------------------------
    -- CARRY IN
    -----------------------------------------------------
    C(0) <= Cin;

    -----------------------------------------------------
    -- PG nodes
    -----------------------------------------------------
    pg0: pg port map(A(0), B(0), p(0), g(0));
    pg1: pg port map(A(1), B(1), p(1), g(1));
    pg2: pg port map(A(2), B(2), p(2), g(2));
    pg3: pg port map(A(3), B(3), p(3), g(3));
    pg4: pg port map(A(4), B(4), p(4), g(4));
    pg5: pg port map(A(5), B(5), p(5), g(5));
    pg6: pg port map(A(6), B(6), p(6), g(6));
    pg7: pg port map(A(7), B(7), p(7), g(7));
    pg8: pg port map(A(8), B(8), p(8), g(8));
    pg9: pg port map(A(9), B(9), p(9), g(9));
    pg10: pg port map(A(10), B(10), p(10), g(10));
    pg11: pg port map(A(11), B(11), p(11), g(11));
    pg12: pg port map(A(12), B(12), p(12), g(12));
    pg13: pg port map(A(13), B(13), p(13), g(13));
    pg14: pg port map(A(14), B(14), p(14), g(14));
    pg15: pg port map(A(15), B(15), p(15), g(15));

    -----------------------------------------------------
    -- LEVEL 1 
    -----------------------------------------------------
    pref1_1:  prefix port map(g(1), p(1), g(0), p(0), G1_1,  P1_1);
    pref1_3:  prefix port map(g(3), p(3), g(2), p(2), G1_3,  P1_3);
    pref1_5:  prefix port map(g(5), p(5), g(4), p(4), G1_5,  P1_5);
    pref1_7:  prefix port map(g(7), p(7), g(6), p(6), G1_7,  P1_7);
    pref1_9:  prefix port map(g(9), p(9), g(8), p(8), G1_9,  P1_9);
    pref1_11: prefix port map(g(11),p(11),g(10),p(10),G1_11,P1_11);
    pref1_13: prefix port map(g(13),p(13),g(12),p(12),G1_13,P1_13);
    pref1_15: prefix port map(g(15),p(15),g(14),p(14),G1_15,P1_15);

    -----------------------------------------------------
    -- LEVEL 2 
    -----------------------------------------------------
    pref2_3:  prefix port map(G1_3, P1_3, G1_1, P1_1, G2_3,  P2_3);
    pref2_7:  prefix port map(G1_7, P1_7, G1_5, P1_5, G2_7,  P2_7);
    pref2_11: prefix port map(G1_11,P1_11,G1_9,P1_9,G2_11,P2_11);
    pref2_15: prefix port map(G1_15,P1_15,G1_13,P1_13,G2_15,P2_15);
    
    -----------------------------------------------------
    -- LEVEL 3 
    -----------------------------------------------------
    pref3_7:  prefix port map(G2_7, P2_7, G2_3, P2_3, G3_7,  P3_7);
    pref3_15: prefix port map(G2_15,P2_15,G2_11,P2_11,G3_15,P3_15);

    -----------------------------------------------------
    -- LEVEL 4
    -----------------------------------------------------
    pref4_15: prefix port map(G3_15, P3_15, G3_7, P3_7, G4_15, P4_15);

    -----------------------------------------------------
    -- Carry-out de cada bit
    -----------------------------------------------------
    C(1)  <= g(0)  or (p(0)  and C(0));
    C(2)  <= G1_1  or (P1_1  and C(0));
    C(3)  <= g(2)  or (p(2)  and C(2));
    C(4)  <= G2_3  or (P2_3  and C(0));

    C(5)  <= g(4)  or (p(4)  and C(4));
    C(6)  <= G1_5  or (P1_5  and C(4));
    C(7)  <= g(6)  or (p(6)  and C(6));
    C(8)  <= G3_7  or (P3_7  and C(0));

    C(9)  <= g(8)  or (p(8)  and C(8));
    C(10) <= G1_9  or (P1_9  and C(8));
    C(11) <= g(10) or (p(10) and C(10));
    C(12) <= G2_11 or (P2_11 and C(8));

    C(13) <= g(12) or (p(12) and C(12));
    C(14) <= G1_13 or (P1_13 and C(12));
    C(15) <= g(14) or (p(14) and C(14));
    C(16) <= G4_15 or (P4_15 and C(0));  -- Cout

    -----------------------------------------------------
    -- SUM final
    -----------------------------------------------------
    sum0: sum_bit port map(p(0),  C(0),  S(0));
    sum1: sum_bit port map(p(1),  C(1),  S(1));
    sum2: sum_bit port map(p(2),  C(2),  S(2));
    sum3: sum_bit port map(p(3),  C(3),  S(3));
    sum4: sum_bit port map(p(4),  C(4),  S(4));
    sum5: sum_bit port map(p(5),  C(5),  S(5));
    sum6: sum_bit port map(p(6),  C(6),  S(6));
    sum7: sum_bit port map(p(7),  C(7),  S(7));
    sum8: sum_bit port map(p(8),  C(8),  S(8));
    sum9: sum_bit port map(p(9),  C(9),  S(9));
    sum10: sum_bit port map(p(10), C(10), S(10));
    sum11: sum_bit port map(p(11), C(11), S(11));
    sum12: sum_bit port map(p(12), C(12), S(12));
    sum13: sum_bit port map(p(13), C(13), S(13));
    sum14: sum_bit port map(p(14), C(14), S(14));
    sum15: sum_bit port map(p(15), C(15), S(15));

    Cout <= C(16);

end structural;

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

COMPONENT bk_adder16 is
	port(
	A : in std_logic_vector(15 downto 0);
	B : in std_logic_vector(15 downto 0);
	Cin : in std_logic;
	S: out std_logic_vector(15 downto 0);
	Cout: out std_logic
	);
END COMPONENT;

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

ENTITY compressor_42_16b_Brent_Kung IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_Brent_Kung;

ARCHITECTURE comportamento OF compressor_42_16b_Brent_Kung IS

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
	
var0: bk_adder16 PORT MAP(carry, (cout(15) & sumb), '0', SOMA(16 downto 1), SOMA(17));

END comportamento;
