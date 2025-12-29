LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY mux IS
	PORT (a, b: IN STD_LOGIC;
		   sel: IN STD_LOGIC;
		   mux_out: OUT STD_LOGIC
		  );
END mux;

ARCHITECTURE comportamento OF mux IS
BEGIN
	
	PROCESS (sel,a,b)
	BEGIN
		IF (sel = '0') THEN
			mux_out <= a;
		ELSE
			mux_out <= b;
		END IF;
	END PROCESS;

END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components1 IS

COMPONENT mux IS
	PORT (a, b: IN STD_LOGIC;
		   sel: IN STD_LOGIC;
		   mux_out: OUT STD_LOGIC
		  );
END COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;

ENTITY compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END compressor32;

ARCHITECTURE comportamento OF compressor32 IS

SIGNAL  out_xor1:  STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	Sum <= out_xor1 XOR C;
	
s0: mux
	  PORT MAP   (a => A,
				     b => C,
				     sel => out_xor1,
				     mux_out => Carry	);

END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components2 IS

COMPONENT compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

END my_components2;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE work.my_components1.all;
USE work.my_components2.all;

ENTITY compressor32_8b_v1 IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	   );
END compressor32_8b_v1;

ARCHITECTURE comportamento OF compressor32_8b_v1 IS

SIGNAL carry: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL sum: STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    
-- Compressores 3:2 (CSA)
estagio0: compressor32 PORT MAP(A(0),B(0),C(0),carry(0),sum(0));
estagio1: compressor32 PORT MAP(A(1),B(1),C(1),carry(1),sum(1));
estagio2: compressor32 PORT MAP(A(2),B(2),C(2),carry(2),sum(2));
estagio3: compressor32 PORT MAP(A(3),B(3),C(3),carry(3),sum(3));
estagio4: compressor32 PORT MAP(A(4),B(4),C(4),carry(4),sum(4));
estagio5: compressor32 PORT MAP(A(5),B(5),C(5),carry(5),sum(5));
estagio6: compressor32 PORT MAP(A(6),B(6),C(6),carry(6),sum(6));
estagio7: compressor32 PORT MAP(A(7),B(7),C(7),carry(7),sum(7));

--sum(16) <= '0';

-- Soma dos Resultados Parciais
-- Somador da biblioteca, '+'.

S(0) <= sum(0);

S(9 downto 1) <= ('0' & carry) + ( "00" & sum(7 downto 1));

END comportamento;

					

