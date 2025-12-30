LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY mux IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END mux;

ARCHITECTURE comportamento OF mux IS
BEGIN
	
	PROCESS (sel)
	BEGIN
		IF (sel = '0') THEN
			mux_out <= a;
		ELSE
			mux_out <= b;
		END IF;
	END PROCESS;
				
END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all;

PACKAGE my_components1 IS

COMPONENT mux IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;

ENTITY compressor42 IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);
END compressor42;

ARCHITECTURE comportamento OF compressor42 IS

SIGNAL  out_xor1, out_xor2, out_xor3, out_xor4 :  STD_LOGIC;
SIGNAL	out_mux1, out_mux2 : STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	out_xor2 <= C XOR D;

	out_xor3 <= out_xor1 XOR out_xor2;

	out_xor4 <= Cin XOR out_xor3;
				
  s0: mux
	  PORT MAP (a => A,
				b => C,
				mux_out => out_mux1,
				sel => out_xor1
			    );
			
  s1: mux
	  PORT MAP (a => D,
				b => Cin,
				mux_out => out_mux2,
				sel => out_xor3
				);
	
	  Sum <= out_xor4;
	  Carry <= out_mux2;
	  Cout <= out_mux1;
	 	
END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components2 IS

COMPONENT compressor42 IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC
	  );
END COMPONENT;

END my_components2;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.my_components2.all;

ENTITY compressor42_16b_mais IS
PORT ( A, B, C, D :  IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	   S 		  :  OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	 );
END compressor42_16b_mais; 


ARCHITECTURE behavior OF compressor42_16b_mais IS
SIGNAL sum: STD_LOGIC_VECTOR (15 DOWNTO 1);
SIGNAL carry: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL cout: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
						
	S0: compressor42 PORT MAP (A(0),B(0),C(0),D(0),'0',cout(0),carry(0),S(0));
	S1: compressor42 PORT MAP (A(1),B(1),C(1),D(1),cout(0),cout(1),carry(1),sum(1));
	S2: compressor42 PORT MAP (A(2),B(2),C(2),D(2),cout(1),cout(2),carry(2),sum(2));
	S3: compressor42 PORT MAP (A(3),B(3),C(3),D(3),cout(2),cout(3),carry(3),sum(3));
	S4: compressor42 PORT MAP (A(4),B(4),C(4),D(4),cout(3),cout(4),carry(4),sum(4));
	S5: compressor42 PORT MAP (A(5),B(5),C(5),D(5),cout(4),cout(5),carry(5),sum(5));
	S6: compressor42 PORT MAP (A(6),B(6),C(6),D(6),cout(5),cout(6),carry(6),sum(6));
	S7: compressor42 PORT MAP (A(7),B(7),C(7),D(7),cout(6),cout(7),carry(7),sum(7));
	S8: compressor42 PORT MAP (A(8),B(8),C(8),D(8),cout(7),cout(8),carry(8),sum(8));
	S9: compressor42 PORT MAP (A(9),B(9),C(9),D(9),cout(8),cout(9),carry(9),sum(9));
	S10: compressor42 PORT MAP (A(10),B(10),C(10),D(10),cout(9),cout(10),carry(10),sum(10));
	S11: compressor42 PORT MAP (A(11),B(11),C(11),D(11),cout(10),cout(11),carry(11),sum(11));
	S12: compressor42 PORT MAP (A(12),B(12),C(12),D(12),cout(11),cout(12),carry(12),sum(12));
	S13: compressor42 PORT MAP (A(13),B(13),C(13),D(13),cout(12),cout(13),carry(13),sum(13));
	S14: compressor42 PORT MAP (A(14),B(14),C(14),D(14),cout(13),cout(14),carry(14),sum(14));
	S15: compressor42 PORT MAP (A(15),B(15),C(15),D(15),cout(14),cout(15),carry(15),sum(15));
	
	S(17 downto 1)<= ('0' & carry(15 downto 0)) + (cout(15) & sum(15 downto 1)); 	 
			
END behavior;
