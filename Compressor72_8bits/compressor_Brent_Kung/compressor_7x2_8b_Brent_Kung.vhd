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

entity brent_kung_7 is
    port(
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end brent_kung_7;

architecture rtl of brent_kung_7 is
    -- G e P individuais
    signal g0,g1,g2,g3,g4,g5,g6 : std_logic;
    signal p0,p1,p2,p3,p4,p5,p6 : std_logic;

    -- Prefixos 
    signal G01, P01 : std_logic;
    signal G23, P23 : std_logic;
    signal G45, P45 : std_logic;
    signal G03, P03 : std_logic;
    signal G47, P47 : std_logic;
    signal G07, P07 : std_logic;

    -- Carries
    signal c : std_logic_vector(7 downto 0); 
begin

    ------------------------------------------
    -- Propagates e Generates de 1-bit
    ------------------------------------------
    g0 <= A(0) and B(0);
    g1 <= A(1) and B(1);
    g2 <= A(2) and B(2);
    g3 <= A(3) and B(3);
    g4 <= A(4) and B(4);
    g5 <= A(5) and B(5);
    g6 <= A(6) and B(6);

    p0 <= A(0) xor B(0);
    p1 <= A(1) xor B(1);
    p2 <= A(2) xor B(2);
    p3 <= A(3) xor B(3);
    p4 <= A(4) xor B(4);
    p5 <= A(5) xor B(5);
    p6 <= A(6) xor B(6);

    ------------------------------------------
    -- Prefix (construção Brent-Kung )
    ------------------------------------------
    G01 <= g1 or (p1 and g0);
    P01 <= p1 and p0;

    G23 <= g3 or (p3 and g2);
    P23 <= p3 and p2;

    G45 <= g5 or (p5 and g4);
    P45 <= p5 and p4;

    G03 <= G23 or (P23 and G01);
    P03 <= P23 and P01;

    G47 <= g6 or (p6 and G45);
    P47 <= p6 and P45;

    G07 <= G47 or (P47 and G03);
    P07 <= P47 and P03;

    ------------------------------------------
    -- Carries 
    ------------------------------------------
    c(0) <= Cin;

    c(1) <= g0 or (p0 and c(0));

    c(2) <= g1 or (p1 and g0) or (p1 and p0 and c(0));

    c(3) <= g2 or (p2 and g1) or (p2 and p1 and g0) or (p2 and p1 and p0 and c(0));

    c(4) <= g3 or (p3 and g2) or (p3 and p2 and g1) or (p3 and p2 and p1 and g0) or (p3 and p2 and p1 and p0 and c(0));

    c(5) <= g4 or (p4 and g3) or (p4 and p3 and g2) or (p4 and p3 and p2 and g1) or (p4 and p3 and p2 and p1 and g0)
             or (p4 and p3 and p2 and p1 and p0 and c(0));

    c(6) <= g5 or (p5 and g4) or (p5 and p4 and g3) or (p5 and p4 and p3 and g2) or (p5 and p4 and p3 and p2 and g1)
             or (p5 and p4 and p3 and p2 and p1 and g0) or (p5 and p4 and p3 and p2 and p1 and p0 and c(0));

    c(7) <= g6 or (p6 and g5) or (p6 and p5 and g4) or (p6 and p5 and p4 and g3) or (p6 and p5 and p4 and p3 and g2)
             or (p6 and p5 and p4 and p3 and p2 and g1) or (p6 and p5 and p4 and p3 and p2 and p1 and g0)
             or (p6 and p5 and p4 and p3 and p2 and p1 and p0 and c(0));

    ------------------------------------------
    -- Soma final
    ------------------------------------------
    SUM(0) <= p0 xor c(0);
    SUM(1) <= p1 xor c(1);
    SUM(2) <= p2 xor c(2);
    SUM(3) <= p3 xor c(3);
    SUM(4) <= p4 xor c(4);
    SUM(5) <= p5 xor c(5);
    SUM(6) <= p6 xor c(6);

    Cout <= c(7);

end architecture;

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

COMPONENT brent_kung_7 is
    port(
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
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
USE ieee.std_logic_signed.all;
USE work.my_componentsa1.all;
USE work.my_componentsb1.all;

ENTITY compressor_7x2_8b_Brent_Kung IS
PORT ( a, b, c, d, e, f, g : IN  STD_LOGIC_vector(7 downto 0);
	   sum           : OUT STD_LOGIC_vector(10 downto 0)
	  );
END compressor_7x2_8b_Brent_Kung; 

ARCHITECTURE behavior OF compressor_7x2_8b_Brent_Kung IS

SIGNAL couta0, couta1, couta2, couta3, couta4, couta5, couta6, couta7, couta8, couta9, 
couta10, couta11, couta12, couta13, couta14, couta15: STD_LOGIC;
signal COUTa, temp1, temp0: STD_LOGIC;
signal carrya : STD_LOGIC_vector(7 downto 0); 
signal suma : STD_LOGIC_vector(6 downto 0); 
signal saidaparcial	: STD_LOGIC_vector(7 downto 0); 
signal saidaparcial1	: STD_LOGIC_vector(8 downto 1); 
BEGIN

stage_0: compressor_7entradas1a port map (a(0), b(0), c(0), d(0), e(0), f(0), g(0), '0', '0', couta0, couta1, sum(0), carrya(0));
stage_1: compressor_7entradas1a port map (a(1), b(1), c(1), d(1), e(1), f(1), g(1), couta0, '0', couta2, couta3, suma(0), carrya(1));
stage_2: compressor_7entradas1a port map (a(2), b(2), c(2), d(2), e(2), f(2), g(2), couta1, couta2, couta4, couta5, suma(1), carrya(2));
stage_3: compressor_7entradas1a port map (a(3), b(3), c(3), d(3), e(3), f(3), g(3), couta3, couta4, couta6, couta7, suma(2), carrya(3));
stage_4: compressor_7entradas1a port map (a(4), b(4), c(4), d(4), e(4), f(4), g(4), couta5, couta6, couta8, couta9, suma(3), carrya(4));
stage_5: compressor_7entradas1a port map (a(5), b(5), c(5), d(5), e(5), f(5), g(5), couta7, couta8, couta10, couta11, suma(4), carrya(5));
stage_6: compressor_7entradas1a port map (a(6), b(6), c(6), d(6), e(6), f(6), g(6), couta9, couta10, couta12, couta13, suma(5), carrya(6));
stage_7: compressor_7entradas1a port map (a(7), b(7), c(7), d(7), e(7), f(7), g(7), couta11, couta12, couta14, couta15, suma(6), carrya(7));

comp8: brent_kung_7 port map (carrya(6 downto 0), suma, '0', sum(7 downto 1), Couta);

stage_15: compressor_4entradas1 port map (couta13, carrya(7), couta14, '0', Couta, temp1, temp0, sum(8));
stage_16: full_adder_a port map (couta15, temp1, temp0, sum(10), sum(9));

END behavior;  
