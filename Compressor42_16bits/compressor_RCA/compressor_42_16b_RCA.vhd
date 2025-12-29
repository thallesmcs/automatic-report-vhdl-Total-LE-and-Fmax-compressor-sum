library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HALF_ADDER is
port (A, B: in std_logic;
      Cout: out std_logic;
      S: out std_logic
      );
end HALF_ADDER;

architecture Behavioral of HALF_ADDER is

begin

S <= A XOR B;
Cout <= A AND B;

end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FULL_ADDER IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END FULL_ADDER;

ARCHITECTURE comportamento OF FULL_ADDER IS

SIGNAL fio1, fio2, fio3: STD_LOGIC;
BEGIN
	fio1 <= A XOR B; 
	S <= fio1 XOR CIN;
	fio2 <= A AND B; 
	fio3 <= fio1 AND CIN; 
	COUT <= fio3 OR fio2; 
END comportamento;

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

COMPONENT HALF_ADDER is
port (A, B: in std_logic;
      Cout: out std_logic;
      S: out std_logic
      );
END COMPONENT;

COMPONENT FULL_ADDER IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
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

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.my_components1.all;

ENTITY RCA16b IS
PORT (
	  A, B: IN STD_LOGIC_VECTOR(15 downto 0);
	  Cout : OUT STD_LOGIC;
	  Sum : OUT STD_LOGIC_VECTOR(15 downto 0)
	  );

END RCA16b;

ARCHITECTURE comportamento OF RCA16b IS

SIGNAL Couta, Coutb, Coutc, Coutd, Coute, Coutf, Coutg, Couth, Couti, Coutj, Coutk, Coutl, Coutm, Coutn, Couto:  STD_LOGIC;

BEGIN

stage_0: HALF_ADDER port map (A(0), B(0), Couta, Sum(0));
stage_1: FULL_ADDER port map (Couta, A(1), B(1), Coutb, Sum(1));
stage_2: FULL_ADDER port map (Coutb, A(2), B(2), Coutc, Sum(2));
stage_3: FULL_ADDER port map (Coutc, A(3), B(3), Coutd, Sum(3));
stage_4: FULL_ADDER port map (Coutd, A(4), B(4), Coute, Sum(4));
stage_5: FULL_ADDER port map (Coute, A(5), B(5), Coutf, Sum(5));
stage_6: FULL_ADDER port map (Coutf, A(6), B(6), Coutg, Sum(6));
stage_7: FULL_ADDER port map (Coutg, A(7), B(7), Couth, Sum(7));
stage_8: FULL_ADDER port map (Couth, A(8), B(8), Couti, Sum(8));
stage_9: FULL_ADDER port map (Couti, A(9), B(9), Coutj, Sum(9));
stage_10: FULL_ADDER port map (Coutj, A(10), B(10), Coutk, Sum(10));
stage_11: FULL_ADDER port map (Coutk, A(11), B(11), Coutl, Sum(11));
stage_12: FULL_ADDER port map (Coutl, A(12), B(12), Coutm, Sum(12));
stage_13: FULL_ADDER port map (Coutm, A(13), B(13), Coutn, Sum(13));
stage_14: FULL_ADDER port map (Coutn, A(14), B(14), Couto, Sum(14));
stage_15: FULL_ADDER port map (Couto, A(15), B(15), Cout, Sum(15));
  
END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components2 IS

COMPONENT RCA16b IS
PORT (
	  A, B: IN STD_LOGIC_VECTOR(15 downto 0);
	  Cout : OUT STD_LOGIC;
	  Sum : OUT STD_LOGIC_VECTOR(15 downto 0)
	  );
END COMPONENT;

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

ENTITY compressor_42_16b_RCA IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_RCA;

ARCHITECTURE comportamento OF compressor_42_16b_RCA IS

SIGNAL cout, carry: STD_LOGIC_VECTOR (15 downto 0); 
SIGNAL sum: STD_LOGIC_VECTOR (15 downto 1);
SIGNAL Couta: STD_LOGIC;

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
			
comp42_num16: RCA16b port map (carry(15 downto 0), cout(15) & sum(15 downto 1), SOMA(17), SOMA(16 downto 1));

END comportamento;

