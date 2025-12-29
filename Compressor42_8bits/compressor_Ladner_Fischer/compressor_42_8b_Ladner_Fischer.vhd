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

entity ladner_fischer_8 is
    port(
        A    : in  std_logic_vector(7 downto 0);
        B    : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end ladner_fischer_8;

architecture rtl of ladner_fischer_8 is

    -- Stage 0: generate/propagate
    signal G0, P0 : std_logic_vector(7 downto 0);

    -- Stage 1: 
    signal G1, P1 : std_logic_vector(7 downto 0);

    -- Stage 2: 
    signal G2, P2 : std_logic_vector(7 downto 0);

    -- Stage 3: 
    signal G3, P3 : std_logic_vector(7 downto 0);

    -- Carries: C(i) is carry into bit i
    signal C : std_logic_vector(8 downto 0);

begin

    C(0) <= Cin;

    --------------------------------------------------------------------
    -- Stage 0 : bitwise G and P
    --------------------------------------------------------------------
    G0(0) <= A(0) and B(0);
    P0(0) <= A(0) xor B(0);

    G0(1) <= A(1) and B(1);
    P0(1) <= A(1) xor B(1);

    G0(2) <= A(2) and B(2);
    P0(2) <= A(2) xor B(2);

    G0(3) <= A(3) and B(3);
    P0(3) <= A(3) xor B(3);

    G0(4) <= A(4) and B(4);
    P0(4) <= A(4) xor B(4);

    G0(5) <= A(5) and B(5);
    P0(5) <= A(5) xor B(5);

    G0(6) <= A(6) and B(6);
    P0(6) <= A(6) xor B(6);

    G0(7) <= A(7) and B(7);
    P0(7) <= A(7) xor B(7);


    --------------------------------------------------------------------
    -- Stage 1 Ladner–Fischer partial-tree structure:
    -- Bits updated: 1,3,5,7
    --------------------------------------------------------------------
    -- Copy through the others
    G1(0) <= G0(0);    P1(0) <= P0(0);

    G1(1) <= G0(1) or (P0(1) and G0(0));
    P1(1) <= P0(1) and P0(0);

    G1(2) <= G0(2);    P1(2) <= P0(2);

    G1(3) <= G0(3) or (P0(3) and G0(2));
    P1(3) <= P0(3) and P0(2);

    G1(4) <= G0(4);    P1(4) <= P0(4);

    G1(5) <= G0(5) or (P0(5) and G0(4));
    P1(5) <= P0(5) and P0(4);

    G1(6) <= G0(6);    P1(6) <= P0(6);

    G1(7) <= G0(7) or (P0(7) and G0(6));
    P1(7) <= P0(7) and P0(6);


    --------------------------------------------------------------------
    -- Stage 2 (apply at bits 2–3, 6–7)
    --
    -- LF pattern:
    -- update 2,3 using 0..1
    -- update 6,7 using 4..5
    --------------------------------------------------------------------
    -- bits 0..1 unchanged
    G2(0) <= G1(0);    P2(0) <= P1(0);
    G2(1) <= G1(1);    P2(1) <= P1(1);

    -- bits 2–3
    G2(2) <= G1(2) or (P1(2) and G1(0));
    P2(2) <= P1(2) and P1(0);

    G2(3) <= G1(3) or (P1(3) and G1(1));
    P2(3) <= P1(3) and P1(1);

    -- bits 4–5 unchanged
    G2(4) <= G1(4);    P2(4) <= P1(4);
    G2(5) <= G1(5);    P2(5) <= P1(5);

    -- bits 6–7
    G2(6) <= G1(6) or (P1(6) and G1(4));
    P2(6) <= P1(6) and P1(4);

    G2(7) <= G1(7) or (P1(7) and G1(5));
    P2(7) <= P1(7) and P1(5);


    --------------------------------------------------------------------
    -- Stage 3 – update only bits 4..7
    --
    -- Bits 4–5 use prefix from 0
    -- Bits 6–7 use prefix from 2
    --------------------------------------------------------------------
    -- bits 0..3 unchanged
    G3(0) <= G2(0);    P3(0) <= P2(0);
    G3(1) <= G2(1);    P3(1) <= P2(1);
    G3(2) <= G2(2);    P3(2) <= P2(2);
    G3(3) <= G2(3);    P3(3) <= P2(3);

    -- bits 4–5 from bit 0
    G3(4) <= G2(4) or (P2(4) and G2(0));
    P3(4) <= P2(4) and P2(0);

    G3(5) <= G2(5) or (P2(5) and G2(1));
    P3(5) <= P2(5) and P2(1);

    -- bits 6–7 from bit 2
    G3(6) <= G2(6) or (P2(6) and G2(2));
    P3(6) <= P2(6) and P2(2);

    G3(7) <= G2(7) or (P2(7) and G2(3));
    P3(7) <= P2(7) and P2(3);


    --------------------------------------------------------------------
    -- Final carries
    -- C(i) = G3(i-1) OR (P3(i-1) AND Cin)
    --------------------------------------------------------------------
    C(1) <= G3(0) or (P3(0) and Cin);
    C(2) <= G3(1) or (P3(1) and Cin);
    C(3) <= G3(2) or (P3(2) and Cin);
    C(4) <= G3(3) or (P3(3) and Cin);
    C(5) <= G3(4) or (P3(4) and Cin);
    C(6) <= G3(5) or (P3(5) and Cin);
    C(7) <= G3(6) or (P3(6) and Cin);
    C(8) <= G3(7) or (P3(7) and Cin);

    --------------------------------------------------------------------
    -- SUM
    --------------------------------------------------------------------
    SUM(0) <= P0(0) xor C(0);
    SUM(1) <= P0(1) xor C(1);
    SUM(2) <= P0(2) xor C(2);
    SUM(3) <= P0(3) xor C(3);
    SUM(4) <= P0(4) xor C(4);
    SUM(5) <= P0(5) xor C(5);
    SUM(6) <= P0(6) xor C(6);
    SUM(7) <= P0(7) xor C(7);

    Cout <= C(8);

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

COMPONENT ladner_fischer_8 is
    port(
        A    : in  std_logic_vector(7 downto 0);
        B    : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_components;

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

ENTITY compressor_42_8b_Ladner_Fischer IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	  );

END compressor_42_8b_Ladner_Fischer;

ARCHITECTURE comportamento OF compressor_42_8b_Ladner_Fischer IS

SIGNAL cout, carry: STD_LOGIC_VECTOR (7 downto 0); 
SIGNAL sum: STD_LOGIC_VECTOR (7 downto 1);
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
			

--------------------------------------------------------------------------------------------	

var0: ladner_fischer_8 PORT MAP(carry, (cout(7) & sum), '0', SOMA(8 downto 1), SOMA(9));

END comportamento;
