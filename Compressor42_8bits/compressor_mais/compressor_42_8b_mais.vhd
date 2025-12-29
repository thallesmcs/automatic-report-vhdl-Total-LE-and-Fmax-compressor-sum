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

ARCHITECTURE RCAcomportamento4m28b OF FULL_ADDER IS

SIGNAL fio1, fio2, fio3: STD_LOGIC;
BEGIN
	fio1 <= A XOR B; 
	S <= fio1 XOR CIN;
	fio2 <= A AND B; 
	fio3 <= fio1 AND CIN; 
	COUT <= fio3 OR fio2; 
END RCAcomportamento4m28b;

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

ENTITY compressor_42_8b_mais IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	  S: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	  );

END compressor_42_8b_mais;

ARCHITECTURE comportamento OF compressor_42_8b_mais IS

SIGNAL sum: STD_LOGIC_VECTOR (8 DOWNTO 1);
SIGNAL carry: STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL cout: STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

comp42_num0: compressor_4entradas PORT MAP(A(0), B(0), C(0), D(0), '0', cout(0), carry(0), S(0));
					
comp42_num1: compressor_4entradas PORT MAP(A(1), B(1), C(1), D(1), cout(0), cout(1), carry(1), sum(1));
			
comp42_num2: compressor_4entradas PORT MAP(A(2), B(2), C(2), D(2), cout(1), cout(2), carry(2), sum(2));
								
comp42_num3: compressor_4entradas PORT MAP(A(3), B(3), C(3), D(3), cout(2), cout(3), carry(3), sum(3));

comp42_num4: compressor_4entradas PORT MAP(A(4), B(4), C(4), D(4), cout(3), cout(4), carry(4), sum(4));

comp42_num5: compressor_4entradas PORT MAP(A(5), B(5), C(5), D(5), cout(4), cout(5), carry(5), sum(5));

comp42_num6: compressor_4entradas PORT MAP(A(6), B(6), C(6), D(6), cout(5), cout(6), carry(6), sum(6));

comp42_num7: compressor_4entradas PORT MAP(A(7), B(7), C(7), D(7), cout(6), cout(7), carry(7), sum(7));
			

--------------------------------------------------------------------------------------------	

sum(8)<=cout(7);

	S(9 downto 1)<= ('0' & carry(7 downto 0)) + ('0' & sum(8 downto 1)); 

END comportamento;

