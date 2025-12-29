LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CLA16b_Adder IS
PORT ( a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       cin: IN STD_LOGIC;
       s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
       cout: OUT STD_LOGIC);
END CLA16b_Adder;

ARCHITECTURE CLA_Adder OF CLA16b_Adder IS
SIGNAL c: STD_LOGIC_VECTOR (16 DOWNTO 0);
SIGNAL p: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL g: STD_LOGIC_VECTOR (15 DOWNTO 0);

 BEGIN
 
 ---- PGU: ---------------------------------
p <= a XOR b;
g <= a AND b;
s <= p XOR c(15 downto 0);

 ---- CLAU: --------------------------------

c(0) <= cin;

c(1) <= (cin AND p(0)) OR g(0);

c(2) <= (cin AND p(0) AND p(1)) OR  (g(0) AND p(1)) OR  g(1);

c(3) <= (cin AND p(0) AND p(1) AND p(2)) OR (g(0) AND p(1) AND p(2)) OR (g(1) AND p(2)) OR g(2);

c(4) <= (cin AND p(0) AND p(1) AND p(2) AND p(3)) OR (g(0) AND p(1) AND p(2) AND p(3)) OR (g(1) AND p(2) AND p(3)) OR
        (g(2) AND p(3)) OR g(3);

c(5) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4)) OR (g(0) AND p(1) AND p(2) AND p(3) AND p(4)) OR 
        (g(1) AND p(2) AND p(3) AND p(4)) OR (g(2) AND p(3) AND p(4)) OR (g(3) and p(4)) OR g(4);

c(6) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5)) OR (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5)) 
         OR (g(1) AND p(2) AND p(3) AND p(4) AND p(5)) OR (g(2) AND p(3) AND p(4) AND p(5)) 
         OR (g(3) AND p(4) AND p(5)) OR (g(4) and p(5)) OR g(5);

c(7) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR (g(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(4) AND p(5) AND p(6)) OR (g(5) AND p(6)) OR g(6);

c(8) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR (g(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(5) AND p(6) AND p(7)) OR (g(6) AND p(7)) OR g(7);

c(9) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(5) AND p(6) AND p(7) AND p(8)) OR (g(6) AND p(7) AND p(8)) OR (g(7) AND p(8)) OR g(8);

c(10) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR (g(6) AND p(7) AND p(8) AND p(9)) OR (g(7) AND p(8) AND p(9)) OR (g(8) AND p(9)) OR g(9);

c(11) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR (g(7) AND p(8) AND p(9) AND p(10)) OR (g(8) AND p(9) AND p(10)) OR (g(9) AND p(10)) OR g(10);

c(12) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(8) AND p(9) AND p(10) AND p(11)) OR (g(9) AND p(10) AND p(11)) OR (g(11) and P(11)) or  g(11);

c(13) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(9) AND p(10) AND p(11) AND p(12)) OR (g(10) AND p(11) AND p(12)) OR (g(11) AND p(12)) OR g(12);

c(14) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(10) AND p(11) AND p(12) AND p(13)) OR (g(11) AND p(12) AND p(13)) OR (g(12) AND p(13)) OR g(13);

c(15) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(11) AND p(12) AND p(13) AND p(14)) OR (g(12) AND p(13) AND p(14)) OR (g(13) AND p(14)) OR g(14);

c(16) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(12) AND p(13) AND p(14) AND p(15)) OR (g(13) AND p(14) AND p(15)) OR (g(14) AND p(15)) OR g(15);

cout <= c(16);

END CLA_Adder;

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

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components1 IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT CLA16b_Adder IS
PORT ( a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       cin: IN STD_LOGIC;
       s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
       cout: OUT STD_LOGIC);
END COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;

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

PACKAGE my_components2 IS

COMPONENT compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

END my_components2;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_components1.all;
USE work.my_components2.all;

ENTITY compressor_42_16b_CLA IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_CLA;

ARCHITECTURE comportamento OF compressor_42_16b_CLA IS

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
			
var0: CLA16b_Adder PORT MAP(carry, (cout(15) & sum), '0', SOMA(16 downto 1), SOMA(17));

END comportamento;
