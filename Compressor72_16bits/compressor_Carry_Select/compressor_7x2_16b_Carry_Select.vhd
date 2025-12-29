library ieee;
use ieee.std_logic_1164.all;

Entity Mux21ab is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
end Mux21ab;
Architecture circuito of Mux21ab is

begin 

 with sel select 
	y <= a when '0',
		  b when others;
		  
end circuito;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY half_adder_a IS

PORT (a, b 	       : IN STD_LOGIC;
	  cout, s 		: OUT STD_LOGIC
     );
END half_adder_a;

ARCHITECTURE soma OF half_adder_a IS
BEGIN

s    <= a XOR b ;
cout <= a AND b;

END soma;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder_a IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END full_adder_a;

ARCHITECTURE comportamento OF full_adder_a IS

SIGNAL fio1, fio2, fio3: STD_LOGIC;

BEGIN
	fio1 <= A XOR B; 
	S <= fio1 XOR CIN;
	fio2 <= A AND B; 
	fio3 <= fio1 AND CIN; 
	COUT <= fio3 OR fio2; 

END comportamento;

library ieee;
use ieee.std_logic_1164.all;

entity cgen is
   port(
      in1, in2, in3  : in  std_logic;
      CGEN           : out std_logic
   );
end cgen;

architecture arq of cgen is
begin

   CGEN <= ((in2 or in3) and in1) or (in2 and in3);

end arq;

library ieee;
use ieee.std_logic_1164.all;

entity carry_select_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end carry_select_15;

architecture rtl of carry_select_15 is

    ------------------------------------------------------------------
    -- Sinais do bloco 0 (3 bits ripple)
    ------------------------------------------------------------------
    signal c0, c1, c2, c3 : std_logic;

    ------------------------------------------------------------------
    -- Bloco 1
    ------------------------------------------------------------------
    signal c10_0, c11_0, c12_0, c13_0 : std_logic; -- carries para Cin=0
    signal c10_1, c11_1, c12_1, c13_1 : std_logic; -- carries para Cin=1

    signal sum3_0, sum4_0, sum5_0, sum6_0 : std_logic;
    signal sum3_1, sum4_1, sum5_1, sum6_1 : std_logic;
    signal c7 : std_logic;

    ------------------------------------------------------------------
    -- Bloco 2
    ------------------------------------------------------------------
    signal c20_0, c21_0, c22_0, c23_0 : std_logic;
    signal c20_1, c21_1, c22_1, c23_1 : std_logic;

    signal sum7_0, sum8_0, sum9_0, sum10_0 : std_logic;
    signal sum7_1, sum8_1, sum9_1, sum10_1 : std_logic;
    signal c11 : std_logic;

    ------------------------------------------------------------------
    -- Bloco 3
    ------------------------------------------------------------------
    signal c30_0, c31_0, c32_0, c33_0 : std_logic;
    signal c30_1, c31_1, c32_1, c33_1 : std_logic;

    signal sum11_0, sum12_0, sum13_0, sum14_0 : std_logic;
    signal sum11_1, sum12_1, sum13_1, sum14_1 : std_logic;

begin

    ----------------------------------------------------------------------
    -- BLOCO 0
    ----------------------------------------------------------------------
    c0 <= Cin;

    c1 <= (A(0) and B(0)) or ((A(0) xor B(0)) and c0);
    SUM(0) <= A(0) xor B(0) xor c0;

    c2 <= (A(1) and B(1)) or ((A(1) xor B(1)) and c1);
    SUM(1) <= A(1) xor B(1) xor c1;

    c3 <= (A(2) and B(2)) or ((A(2) xor B(2)) and c2);
    SUM(2) <= A(2) xor B(2) xor c2;

    ----------------------------------------------------------------------
    -- BLOCO 1
    ----------------------------------------------------------------------

    -- carry = 0 ----------------------------------------------------------
    c10_0 <= (A(3) and B(3));
    sum3_0 <= A(3) xor B(3);

    c11_0 <= (A(4) and B(4)) or ((A(4) xor B(4)) and c10_0);
    sum4_0 <= A(4) xor B(4) xor c10_0;

    c12_0 <= (A(5) and B(5)) or ((A(5) xor B(5)) and c11_0);
    sum5_0 <= A(5) xor B(5) xor c11_0;

    c13_0 <= (A(6) and B(6)) or ((A(6) xor B(6)) and c12_0);
    sum6_0 <= A(6) xor B(6) xor c12_0;

    -- carry = 1 ----------------------------------------------------------
    c10_1 <= (A(3) and B(3)) or (A(3) xor B(3));
    sum3_1 <= not(A(3) xor B(3));

    c11_1 <= (A(4) and B(4)) or ((A(4) xor B(4)) and c10_1);
    sum4_1 <= A(4) xor B(4) xor c10_1;

    c12_1 <= (A(5) and B(5)) or ((A(5) xor B(5)) and c11_1);
    sum5_1 <= A(5) xor B(5) xor c11_1;

    c13_1 <= (A(6) and B(6)) or ((A(6) xor B(6)) and c12_1);
    sum6_1 <= A(6) xor B(6) xor c12_1;

    -- multiplexador de carry e soma
    SUM(3) <= sum3_0 when c3 = '0' else sum3_1;
    SUM(4) <= sum4_0 when c3 = '0' else sum4_1;
    SUM(5) <= sum5_0 when c3 = '0' else sum5_1;
    SUM(6) <= sum6_0 when c3 = '0' else sum6_1;

    c7 <= c13_0 when c3 = '0' else c13_1;

    ----------------------------------------------------------------------
    -- BLOCO 2 
    ----------------------------------------------------------------------

    -- carry = 0
    c20_0 <= (A(7) and B(7));
    sum7_0 <= A(7) xor B(7);

    c21_0 <= (A(8) and B(8)) or ((A(8) xor B(8)) and c20_0);
    sum8_0 <= A(8) xor B(8) xor c20_0;

    c22_0 <= (A(9) and B(9)) or ((A(9) xor B(9)) and c21_0);
    sum9_0 <= A(9) xor B(9) xor c21_0;

    c23_0 <= (A(10) and B(10)) or ((A(10) xor B(10)) and c22_0);
    sum10_0 <= A(10) xor B(10) xor c22_0;

    -- carry = 1
    c20_1 <= (A(7) and B(7)) or (A(7) xor B(7));
    sum7_1 <= not(A(7) xor B(7));

    c21_1 <= (A(8) and B(8)) or ((A(8) xor B(8)) and c20_1);
    sum8_1 <= A(8) xor B(8) xor c20_1;

    c22_1 <= (A(9) and B(9)) or ((A(9) xor B(9)) and c21_1);
    sum9_1 <= A(9) xor B(9) xor c21_1;

    c23_1 <= (A(10) and B(10)) or ((A(10) xor B(10)) and c22_1);
    sum10_1 <= A(10) xor B(10) xor c22_1;

    -- multiplexador
    SUM(7)  <= sum7_0  when c7 = '0' else sum7_1;
    SUM(8)  <= sum8_0  when c7 = '0' else sum8_1;
    SUM(9)  <= sum9_0  when c7 = '0' else sum9_1;
    SUM(10) <= sum10_0 when c7 = '0' else sum10_1;

    c11 <= c23_0 when c7 = '0' else c23_1;

    ----------------------------------------------------------------------
    -- BLOCO 3
    ----------------------------------------------------------------------

    -- carry = 0
    c30_0 <= (A(11) and B(11));
    sum11_0 <= A(11) xor B(11);

    c31_0 <= (A(12) and B(12)) or ((A(12) xor B(12)) and c30_0);
    sum12_0 <= A(12) xor B(12) xor c30_0;

    c32_0 <= (A(13) and B(13)) or ((A(13) xor B(13)) and c31_0);
    sum13_0 <= A(13) xor B(13) xor c31_0;

    c33_0 <= (A(14) and B(14)) or ((A(14) xor B(14)) and c32_0);
    sum14_0 <= A(14) xor B(14) xor c32_0;

    -- carry = 1
    c30_1 <= (A(11) and B(11)) or (A(11) xor B(11));
    sum11_1 <= not(A(11) xor B(11));

    c31_1 <= (A(12) and B(12)) or ((A(12) xor B(12)) and c30_1);
    sum12_1 <= A(12) xor B(12) xor c30_1;

    c32_1 <= (A(13) and B(13)) or ((A(13) xor B(13)) and c31_1);
    sum13_1 <= A(13) xor B(13) xor c31_1;

    c33_1 <= (A(14) and B(14)) or ((A(14) xor B(14)) and c32_1);
    sum14_1 <= A(14) xor B(14) xor c32_1;

    -- multiplexador
    SUM(11) <= sum11_0 when c11 = '0' else sum11_1;
    SUM(12) <= sum12_0 when c11 = '0' else sum12_1;
    SUM(13) <= sum13_0 when c11 = '0' else sum13_1;
    SUM(14) <= sum14_0 when c11 = '0' else sum14_1;

    Cout <= c33_0 when c11 = '0' else c33_1;

end rtl;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

PACKAGE my_componentsa1 IS

COMPONENT Mux21ab is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
END COMPONENT;

COMPONENT half_adder_a IS

PORT (a, b 	       : IN STD_LOGIC;
	  cout, s 		: OUT STD_LOGIC
     );
END COMPONENT;

COMPONENT full_adder_a IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cgen is
   port(
      in1, in2, in3  : in  std_logic;
      CGEN           : out std_logic
   );
end COMPONENT;

COMPONENT carry_select_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_componentsa1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsa1.all;

ENTITY compressor_4entradas1 IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END compressor_4entradas1;

ARCHITECTURE comportamento OF compressor_4entradas1 IS

SIGNAL  out_xor1, out_xor2, out_xor3, out_xor4 :  STD_LOGIC;
SIGNAL	out_mux1, out_mux2 : STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	out_xor2 <= C XOR D;

	out_xor3 <= out_xor1 XOR out_xor2;

	out_xor4 <= Cin XOR out_xor3;
				
    s0: Mux21ab PORT MAP (A, C, out_xor1, out_mux1);
			
    s1: Mux21ab PORT MAP (D, Cin, out_xor3, out_mux2);
	
    Sum <= out_xor4;
	Carry <= out_mux2;
	Cout <= out_mux1;
	 	
END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsa1.all;

Entity compressor_7entradas1a is 
	port( 
		a, b, c, d, e, f, g, cin1, cin2: in std_logic;
		cout1, cout2, sum, carry: out std_logic	
		);
end compressor_7entradas1a;

Architecture circuito of compressor_7entradas1a is

 ---- SINAIS ----
   signal c1, c2, c3 : std_logic;
   signal s1, s2, s3, s4, s5 : std_logic;
begin


   cgen1: cgen port map(in1 => b, in2 => c, in3 => d, CGEN => c1);
   cgen2: cgen port map(in1 => e, in2 => f, in3 => g, CGEN => c2);
   cgen3: cgen port map(in1 => a, in2 => s1, in3 => s2, CGEN => c3);

   s1 <= (b xor c) xor d;
   s2 <= (e xor f) xor g;
   s3 <= c1 xor c2;
   s4 <= a xor (s1 xor s2);
   s5 <= s4 xor cin2;

   sum <= s5 xor cin1;
	
   carry <= s4   when s5 = '0' else
            cin1 when s5 = '1';

   cout1 <= s3 xor c3;

   cout2 <= c1 when s3 = '0' else
            c3 when s3 = '1';

END circuito;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_componentsb1 IS

COMPONENT RCA15b IS
PORT (
	  A, B: IN STD_LOGIC_VECTOR(14 downto 0);
	  Cout : OUT STD_LOGIC;
	  Sum : OUT STD_LOGIC_VECTOR(14 downto 0)
	  );

END COMPONENT;

COMPONENT compressor_4entradas1 IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

COMPONENT compressor_7entradas1a IS
port (A, B, C, D, E, F, G, cin1, cin2: in std_logic;
		cout1, cout2, sum, carry: out std_logic	
		);
end COMPONENT;

END my_componentsb1;

library ieee;
use ieee.std_logic_1164.all;
USE work.my_componentsa1.all;
USE work.my_componentsb1.all;

ENTITY compressor_7x2_16b_Carry_Select IS
PORT ( a, b, c, d, e, f, g : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0)
	  );
END compressor_7x2_16b_Carry_Select; 

ARCHITECTURE behavior OF compressor_7x2_16b_Carry_Select IS

SIGNAL suma: STD_LOGIC_VECTOR(14 downto 0);
SIGNAL carrya: STD_LOGIC_VECTOR(15 DOWNTO 0); 
SIGNAL Coutab, temp1, temp0: STD_LOGIC;
SIGNAL couta0, couta1, couta2, couta3, couta4, couta5, couta6, couta7, couta8, couta9, 
couta10, couta11, couta12, couta13, couta14, couta15, couta16, couta17, couta18, couta19, 
couta20, couta21, couta22, couta23, couta24, couta25, couta26, couta27, couta28,
couta29, couta30, couta31: STD_LOGIC;

BEGIN

stage_0: compressor_7entradas1a port map (a(0), b(0), c(0), d(0), e(0), f(0), g(0), '0', '0', couta0, couta1, sum(0), carrya(0));
stage_1: compressor_7entradas1a port map (a(1), b(1), c(1), d(1), e(1), f(1), g(1), couta0, '0', couta2, couta3, suma(0), carrya(1));
stage_2: compressor_7entradas1a port map (a(2), b(2), c(2), d(2), e(2), f(2), g(2), couta1, couta2, couta4, couta5, suma(1), carrya(2));
stage_3: compressor_7entradas1a port map (a(3), b(3), c(3), d(3), e(3), f(3), g(3), couta3, couta4, couta6, couta7, suma(2), carrya(3));
stage_4: compressor_7entradas1a port map (a(4), b(4), c(4), d(4), e(4), f(4), g(4), couta5, couta6, couta8, couta9, suma(3), carrya(4));
stage_5: compressor_7entradas1a port map (a(5), b(5), c(5), d(5), e(5), f(5), g(5), couta7, couta8, couta10, couta11, suma(4), carrya(5));
stage_6: compressor_7entradas1a port map (a(6), b(6), c(6), d(6), e(6), f(6), g(6), couta9, couta10, couta12, couta13, suma(5), carrya(6));
stage_7: compressor_7entradas1a port map (a(7), b(7), c(7), d(7), e(7), f(7), g(7), couta11, couta12, couta14, couta15, suma(6), carrya(7));
stage_8: compressor_7entradas1a port map (a(8), b(8), c(8), d(8), e(8), f(8), g(8), couta13, couta14, couta16, couta17, suma(7), carrya(8));
stage_9: compressor_7entradas1a port map (a(9), b(9), c(9), d(9), e(9), f(9), g(9), couta15, couta16, couta18, couta19, suma(8), carrya(9));
stage_10: compressor_7entradas1a port map (a(10), b(10), c(10), d(10), e(10), f(10), g(10), couta17, couta18, couta20, couta21, suma(9), carrya(10));
stage_11: compressor_7entradas1a port map (a(11), b(11), c(11), d(11), e(11), f(11), g(11), couta19, couta20, couta22, couta23, suma(10), carrya(11));
stage_12: compressor_7entradas1a port map (a(12), b(12), c(12), d(12), e(12), f(12), g(12), couta21, couta22, couta24, couta25, suma(11), carrya(12));
stage_13: compressor_7entradas1a port map (a(13), b(13), c(13), d(13), e(13), f(13), g(13), couta23, couta24, couta26, couta27, suma(12), carrya(13));
stage_14: compressor_7entradas1a port map (a(14), b(14), c(14), d(14), e(14), f(14), g(14), couta25, couta26, couta28, couta29, suma(13), carrya(14));
stage_15: compressor_7entradas1a port map (a(15), b(15), c(15), d(15), e(15), f(15), g(15), couta27, couta28, couta30, couta31, suma(14), carrya(15));

stage_16: carry_select_15 port map (carrya(14 downto 0), suma, '0', sum(15 downto 1), Coutab);

stage_17: compressor_4entradas1 port map (couta29, carrya(15), couta30, '0', Coutab, temp1, temp0, sum(16));
stage_18: full_adder_a port map (couta31, temp1, temp0, sum(18), sum(17));

END behavior;  
