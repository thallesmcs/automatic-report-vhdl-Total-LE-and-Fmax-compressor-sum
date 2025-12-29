library ieee;
use ieee.std_logic_1164.all;

Entity Mux21a is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
end Mux21a;
Architecture circuito of Mux21a is

begin 

 with sel select 
	y <= a when '0',
		  b when others;
		  
end architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY halfadder1a IS

PORT (
	a, b 	       : IN STD_LOGIC;
	cout, s 		: OUT STD_LOGIC
  );
END halfadder1a;

ARCHITECTURE soma OF halfadder1a IS
BEGIN

s    <= a XOR b ;
cout <= a AND b;

END ARCHITECTURE;

library ieee;
use ieee.std_logic_1164.all;

entity ladner_fischer_7 is
    port(
        A   : in  std_logic_vector(6 downto 0);
        B   : in  std_logic_vector(6 downto 0);
        Cin : in  std_logic;
        SUM : out std_logic_vector(6 downto 0);
        Cout: out std_logic
    );
end ladner_fischer_7;


architecture rtl of ladner_fischer_7 is

    --------------------------------------------------------------------
    -- sinais básicos
    --------------------------------------------------------------------
    signal p0, g0 : std_logic_vector(6 downto 0);

    --------------------------------------------------------------------
    -- Nível 1 (distância 1)
    --------------------------------------------------------------------
    signal g1_1, p1_1 : std_logic;
    signal g2_1, p2_1 : std_logic;
    signal g3_1, p3_1 : std_logic;
    signal g4_1, p4_1 : std_logic;
    signal g5_1, p5_1 : std_logic;
    signal g6_1, p6_1 : std_logic;

    --------------------------------------------------------------------
    -- Nível 2 (distância 2)
    --------------------------------------------------------------------
    signal g2_2, p2_2 : std_logic;
    signal g3_2, p3_2 : std_logic;
    signal g4_2, p4_2 : std_logic;
    signal g5_2, p5_2 : std_logic;
    signal g6_2, p6_2 : std_logic;

    --------------------------------------------------------------------
    -- Nível 3 (distância 4)
    --------------------------------------------------------------------
    signal g4_3, p4_3 : std_logic;
    signal g5_3, p5_3 : std_logic;
    signal g6_3, p6_3 : std_logic;

    --------------------------------------------------------------------
    -- carries
    --------------------------------------------------------------------
    signal c1, c2, c3, c4, c5, c6, c7 : std_logic;

begin

    --------------------------------------------------------------------
    -- Nível 0: propagate e generate básicos
    --------------------------------------------------------------------
    p0 <= A xor B;
    g0 <= A and B;

    --------------------------------------------------------------------
    -- Nível 1: distância 1
    --------------------------------------------------------------------
    g1_1 <= g0(1) or (p0(1) and g0(0));
    p1_1 <= p0(1) and p0(0);

    g2_1 <= g0(2) or (p0(2) and g0(1));
    p2_1 <= p0(2) and p0(1);

    g3_1 <= g0(3) or (p0(3) and g0(2));
    p3_1 <= p0(3) and p0(2);

    g4_1 <= g0(4) or (p0(4) and g0(3));
    p4_1 <= p0(4) and p0(3);

    g5_1 <= g0(5) or (p0(5) and g0(4));
    p5_1 <= p0(5) and p0(4);

    g6_1 <= g0(6) or (p0(6) and g0(5));
    p6_1 <= p0(6) and p0(5);

    --------------------------------------------------------------------
    -- Nível 2: distância 2
    --------------------------------------------------------------------
    g2_2 <= g2_1 or (p2_1 and g1_1);
    p2_2 <= p2_1 and p1_1;

    g3_2 <= g3_1 or (p3_1 and g2_1);
    p3_2 <= p3_1 and p2_1;

    g4_2 <= g4_1 or (p4_1 and g3_1);
    p4_2 <= p4_1 and p3_1;

    g5_2 <= g5_1 or (p5_1 and g4_1);
    p5_2 <= p5_1 and p4_1;

    g6_2 <= g6_1 or (p6_1 and g5_1);
    p6_2 <= p6_1 and p5_1;

    --------------------------------------------------------------------
    -- Nível 3: distância 4
    --------------------------------------------------------------------
    g4_3 <= g4_2 or (p4_2 and g3_2);
    p4_3 <= p4_2 and p3_2;

    g5_3 <= g5_2 or (p5_2 and g4_2);
    p5_3 <= p5_2 and p4_2;

    g6_3 <= g6_2 or (p6_2 and g5_2);
    p6_3 <= p6_2 and p5_2;

    --------------------------------------------------------------------
    -- Carries finais
    --------------------------------------------------------------------
    c1 <= g0(0) or (p0(0) and Cin);
    c2 <= g1_1 or (p1_1 and Cin);
    c3 <= g2_2 or (p2_2 and Cin);
    c4 <= g3_2 or (p3_2 and Cin);
    c5 <= g4_3 or (p4_3 and Cin);
    c6 <= g5_3 or (p5_3 and Cin);
    c7 <= g6_3 or (p6_3 and Cin);

    --------------------------------------------------------------------
    -- Somadores finais
    --------------------------------------------------------------------
    SUM(0) <= p0(0) xor Cin;
    SUM(1) <= p0(1) xor c1;
    SUM(2) <= p0(2) xor c2;
    SUM(3) <= p0(3) xor c3;
    SUM(4) <= p0(4) xor c4;
    SUM(5) <= p0(5) xor c5;
    SUM(6) <= p0(6) xor c6;

    Cout <= c7;

end rtl;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components1a IS

COMPONENT Mux21a is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
end COMPONENT;

COMPONENT halfadder1a IS

PORT (
	a, b 	       : IN STD_LOGIC;
	cout, s 		: OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT ladner_fischer_7 is
    port(
        A   : in  std_logic_vector(6 downto 0);
        B   : in  std_logic_vector(6 downto 0);
        Cin : in  std_logic;
        SUM : out std_logic_vector(6 downto 0);
        Cout: out std_logic
    );
end COMPONENT;

END my_components1a;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE work.my_components1a.all;

ENTITY compressor_4entradas1 IS
PORT (
	  A, B, C, D, Cin  : IN STD_LOGIC;
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
	
MUX0: Mux21a
	  PORT MAP (a => A,
				b => C,
				sel => out_xor1,
				y => out_mux1	);
			
MUX1: Mux21a
	  PORT MAP (a => D,
				b => Cin,
				sel => out_xor3,
				y => out_mux2	);
				
	
	  Sum   <= out_xor4;
	  Carry <= out_mux2;
	  Cout  <= out_mux1;
	 	
END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE work.my_components1a.all;

ENTITY compressor_5entradas1 IS
PORT ( 
	   A, B, C, D, E : IN STD_LOGIC;
	   Cin1, Cin2    : IN STD_LOGIC;
	   Cout1, Cout2  : OUT STD_LOGIC;
	   Sum, Carry    : OUT STD_LOGIC 
	 );
END compressor_5entradas1; 

ARCHITECTURE behavior OF compressor_5entradas1 IS

SIGNAL out_xor_a, out_xor_b, out_xor_c, out_xor_d, out_xor_e: STD_LOGIC;


BEGIN

out_xor_a <= A xor B;
out_xor_b <= C xor D;

out_xor_c <= out_xor_a xor out_xor_b;

out_xor_d <= E xor Cin1;

out_xor_e <= out_xor_c xor out_xor_d;

Sum <= Cin2 xor out_xor_e;


mux1: Mux21a
	PORT MAP ( a => E, 
			   b => Cin2,
			   y => Carry,
			   sel => out_xor_e);
	 
mux2: Mux21a
	PORT MAP ( a => A, 
			   b => C,
			   y => Cout1,
			   sel => out_xor_a);
			   
mux3: Mux21a
	PORT MAP ( a => D, 
			   b => Cin1,
			   y => Cout2,
			   sel => out_xor_c);

END architecture;

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

PACKAGE my_components1b IS

COMPONENT compressor_4entradas1 IS
PORT (
	  A, B, C, D, Cin  : IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

COMPONENT compressor_5entradas1 IS
PORT ( 
	   A, B, C, D, E : IN STD_LOGIC;
	   Cin1, Cin2    : IN STD_LOGIC;
	   Cout1, Cout2  : OUT STD_LOGIC;
	   Sum, Carry    : OUT STD_LOGIC 
	 );
END COMPONENT; 

END my_components1b;

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE work.my_components1a.all;
USE work.my_components1b.all;

ENTITY Compressor_52_8b_Ladner_Fischer IS
PORT ( 
	   a, b, c, d, e : IN  STD_LOGIC_vector(7 downto 0);
	   sum           : OUT STD_LOGIC_vector(10 downto 0) 
	 );
END Compressor_52_8b_Ladner_Fischer; 

ARCHITECTURE behavior OF Compressor_52_8b_Ladner_Fischer IS

signal COUTa, temp1, temp0: STD_LOGIC;
signal carrys : STD_LOGIC_vector(7 downto 0); 
signal cout11, cout22 : STD_LOGIC_vector(7 downto 0); 
signal sums : STD_LOGIC_vector(7 downto 1); 

begin

comp0 : compressor_5entradas1 port map (a(0) , b(0) , c(0) , d(0) , e(0) , '0'      , '0'        , cout11(0) , cout22(0) , sum (0) , carrys(0) );
comp1 : compressor_5entradas1 port map (a(1) , b(1) , c(1) , d(1) , e(1) , cout11(0) , cout22(0) , cout11(1) , cout22(1) , sums(1) , carrys(1) );
comp2 : compressor_5entradas1 port map (a(2) , b(2) , c(2) , d(2) , e(2) , cout11(1) , cout22(1) , cout11(2) , cout22(2) , sums(2) , carrys(2) );
comp3 : compressor_5entradas1 port map (a(3) , b(3) , c(3) , d(3) , e(3) , cout11(2) , cout22(2) , cout11(3) , cout22(3) , sums(3) , carrys(3) );
comp4 : compressor_5entradas1 port map (a(4) , b(4) , c(4) , d(4) , e(4) , cout11(3) , cout22(3) , cout11(4) , cout22(4) , sums(4) , carrys(4) );
comp5 : compressor_5entradas1 port map (a(5) , b(5) , c(5) , d(5) , e(5) , cout11(4) , cout22(4) , cout11(5) , cout22(5) , sums(5) , carrys(5) );
comp6 : compressor_5entradas1 port map (a(6) , b(6) , c(6) , d(6) , e(6) , cout11(5) , cout22(5) , cout11(6) , cout22(6) , sums(6) , carrys(6) );
comp7 : compressor_5entradas1 port map (a(7) , b(7) , c(7) , d(7) , e(7) , cout11(6) , cout22(6) , cout11(7) , cout22(7) , sums(7) , carrys(7) );

comp8: ladner_fischer_7 port map (carrys(6 downto 0), sums(7 downto 1), '0', sum(7 downto 1), Couta);
comp15: compressor_4entradas1 port map (cout11(7), cout22(7), carrys(7), COUTa, '0', temp1, temp0, sum(8));
comp16: halfadder1a port map (temp1, temp0, sum(10), sum(9)); 

END behavior;