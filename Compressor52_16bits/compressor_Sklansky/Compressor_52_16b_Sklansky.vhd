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

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fulladder1a IS

PORT (
	cin, a, b 	       : IN STD_LOGIC;
	cout, s 		: OUT STD_LOGIC
  );
END fulladder1a;

ARCHITECTURE soma OF fulladder1a IS

SIGNAL fio1, fio2, fio3: STD_LOGIC;
BEGIN
	fio1 <= A XOR B; 
	s <= fio1 XOR CIN;
	fio2 <= A AND B; 
	fio3 <= fio1 AND CIN; 
	cout <= fio3 OR fio2; 
END soma;

library ieee;
use ieee.std_logic_1164.all;

entity sklansky_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end sklansky_15;

architecture rtl of sklansky_15 is

    -- sinais de propagate e generate iniciais
    signal P  : std_logic_vector(14 downto 0);
    signal G  : std_logic_vector(14 downto 0);

    -- prefixos intermediários
    signal G1, P1 : std_logic_vector(14 downto 0);
    signal G2, P2 : std_logic_vector(14 downto 0);
    signal G3, P3 : std_logic_vector(14 downto 0);
    signal G4, P4 : std_logic_vector(14 downto 0);

    -- carries
    signal C : std_logic_vector(15 downto 0);

begin

    ------------------------------------------------------------------------
    -- Propagate e Generate básicos
    ------------------------------------------------------------------------
    P <= A xor B;
    G <= A and B;

    C(0) <= Cin;

    ------------------------------------------------------------------------
    -- NÍVEL 1 (distância 1)
    ------------------------------------------------------------------------
    G1(0) <= G(0);
    P1(0) <= P(0);

    G1(1) <= G(1) or (P(1) and G(0));
    P1(1) <= P(1) and P(0);

    G1(2) <= G(2) or (P(2) and G(1));
    P1(2) <= P(2) and P(1);

    G1(3) <= G(3) or (P(3) and G(2));
    P1(3) <= P(3) and P(2);

    G1(4) <= G(4) or (P(4) and G(3));
    P1(4) <= P(4) and P(3);

    G1(5) <= G(5) or (P(5) and G(4));
    P1(5) <= P(5) and P(4);

    G1(6) <= G(6) or (P(6) and G(5));
    P1(6) <= P(6) and P(5);

    G1(7) <= G(7) or (P(7) and G(6));
    P1(7) <= P(7) and P(6);

    G1(8) <= G(8) or (P(8) and G(7));
    P1(8) <= P(8) and P(7);

    G1(9) <= G(9) or (P(9) and G(8));
    P1(9) <= P(9) and P(8);

    G1(10) <= G(10) or (P(10) and G(9));
    P1(10) <= P(10) and P(9);

    G1(11) <= G(11) or (P(11) and G(10));
    P1(11) <= P(11) and P(10);

    G1(12) <= G(12) or (P(12) and G(11));
    P1(12) <= P(12) and P(11);

    G1(13) <= G(13) or (P(13) and G(12));
    P1(13) <= P(13) and P(12);

    G1(14) <= G(14) or (P(14) and G(13));
    P1(14) <= P(14) and P(13);

    ------------------------------------------------------------------------
    -- NÍVEL 2 (distância 2)
    ------------------------------------------------------------------------
    G2(0) <= G1(0);
    P2(0) <= P1(0);

    G2(1) <= G1(1);
    P2(1) <= P1(1);

    G2(2) <= G1(2) or (P1(2) and G1(0));
    P2(2) <= P1(2) and P1(0);

    G2(3) <= G1(3) or (P1(3) and G1(1));
    P2(3) <= P1(3) and P1(1);

    G2(4) <= G1(4) or (P1(4) and G1(2));
    P2(4) <= P1(4) and P1(2);

    G2(5) <= G1(5) or (P1(5) and G1(3));
    P2(5) <= P1(5) and P1(3);

    G2(6) <= G1(6) or (P1(6) and G1(4));
    P2(6) <= P1(6) and P1(4);

    G2(7) <= G1(7) or (P1(7) and G1(5));
    P2(7) <= P1(7) and P1(5);

    G2(8) <= G1(8) or (P1(8) and G1(6));
    P2(8) <= P1(8) and P1(6);

    G2(9) <= G1(9) or (P1(9) and G1(7));
    P2(9) <= P1(9) and P1(7);

    G2(10) <= G1(10) or (P1(10) and G1(8));
    P2(10) <= P1(10) and P1(8);

    G2(11) <= G1(11) or (P1(11) and G1(9));
    P2(11) <= P1(11) and P1(9);

    G2(12) <= G1(12) or (P1(12) and G1(10));
    P2(12) <= P1(12) and P1(10);

    G2(13) <= G1(13) or (P1(13) and G1(11));
    P2(13) <= P1(13) and P1(11);

    G2(14) <= G1(14) or (P1(14) and G1(12));
    P2(14) <= P1(14) and P1(12);

    ------------------------------------------------------------------------
    -- NÍVEL 3 (distância 4)
    ------------------------------------------------------------------------
    G3(0) <= G2(0);
    P3(0) <= P2(0);

    G3(1) <= G2(1);
    P3(1) <= P2(1);

    G3(2) <= G2(2);
    P3(2) <= P2(2);

    G3(3) <= G2(3);
    P3(3) <= P2(3);

    G3(4) <= G2(4) or (P2(4) and G2(0));
    P3(4) <= P2(4) and P2(0);

    G3(5) <= G2(5) or (P2(5) and G2(1));
    P3(5) <= P2(5) and P2(1);

    G3(6) <= G2(6) or (P2(6) and G2(2));
    P3(6) <= P2(6) and P2(2);

    G3(7) <= G2(7) or (P2(7) and G2(3));
    P3(7) <= P2(7) and P2(3);

    G3(8) <= G2(8) or (P2(8) and G2(4));
    P3(8) <= P2(8) and P2(4);

    G3(9) <= G2(9) or (P2(9) and G2(5));
    P3(9) <= P2(9) and P2(5);

    G3(10) <= G2(10) or (P2(10) and G2(6));
    P3(10) <= P2(10) and P2(6);

    G3(11) <= G2(11) or (P2(11) and G2(7));
    P3(11) <= P2(11) and P2(7);

    G3(12) <= G2(12) or (P2(12) and G2(8));
    P3(12) <= P2(12) and P2(8);

    G3(13) <= G2(13) or (P2(13) and G2(9));
    P3(13) <= P2(13) and P2(9);

    G3(14) <= G2(14) or (P2(14) and G2(10));
    P3(14) <= P2(14) and P2(10);

    ------------------------------------------------------------------------
    -- NÍVEL 4 (distância 8)
    ------------------------------------------------------------------------
    G4(0) <= G3(0);
    P4(0) <= P3(0);

    G4(1) <= G3(1);
    P4(1) <= P3(1);

    G4(2) <= G3(2);
    P4(2) <= P3(2);

    G4(3) <= G3(3);
    P4(3) <= P3(3);

    G4(4) <= G3(4);
    P4(4) <= P3(4);

    G4(5) <= G3(5);
    P4(5) <= P3(5);

    G4(6) <= G3(6);
    P4(6) <= P3(6);

    G4(7) <= G3(7);
    P4(7) <= P3(7);

    G4(8) <= G3(8) or (P3(8) and G3(0));
    P4(8) <= P3(8) and P3(0);

    G4(9) <= G3(9) or (P3(9) and G3(1));
    P4(9) <= P3(9) and P3(1);

    G4(10) <= G3(10) or (P3(10) and G3(2));
    P4(10) <= P3(10) and P3(2);

    G4(11) <= G3(11) or (P3(11) and G3(3));
    P4(11) <= P3(11) and P3(3);

    G4(12) <= G3(12) or (P3(12) and G3(4));
    P4(12) <= P3(12) and P3(4);

    G4(13) <= G3(13) or (P3(13) and G3(5));
    P4(13) <= P3(13) and P3(5);

    G4(14) <= G3(14) or (P3(14) and G3(6));
    P4(14) <= P3(14) and P3(6);

    ------------------------------------------------------------------------
    -- Cálculo dos carries
    ------------------------------------------------------------------------
    C(1)  <= G4(0)  or (P4(0)  and C(0));
    C(2)  <= G4(1)  or (P4(1)  and C(0));
    C(3)  <= G4(2)  or (P4(2)  and C(0));
    C(4)  <= G4(3)  or (P4(3)  and C(0));
    C(5)  <= G4(4)  or (P4(4)  and C(0));
    C(6)  <= G4(5)  or (P4(5)  and C(0));
    C(7)  <= G4(6)  or (P4(6)  and C(0));
    C(8)  <= G4(7)  or (P4(7)  and C(0));
    C(9)  <= G4(8)  or (P4(8)  and C(0));
    C(10) <= G4(9)  or (P4(9)  and C(0));
    C(11) <= G4(10) or (P4(10) and C(0));
    C(12) <= G4(11) or (P4(11) and C(0));
    C(13) <= G4(12) or (P4(12) and C(0));
    C(14) <= G4(13) or (P4(13) and C(0));
    C(15) <= G4(14) or (P4(14) and C(0));

    ------------------------------------------------------------------------
    -- Cálculo das somas
    ------------------------------------------------------------------------
    SUM(0)  <= P(0)  xor C(0);
    SUM(1)  <= P(1)  xor C(1);
    SUM(2)  <= P(2)  xor C(2);
    SUM(3)  <= P(3)  xor C(3);
    SUM(4)  <= P(4)  xor C(4);
    SUM(5)  <= P(5)  xor C(5);
    SUM(6)  <= P(6)  xor C(6);
    SUM(7)  <= P(7)  xor C(7);
    SUM(8)  <= P(8)  xor C(8);
    SUM(9)  <= P(9)  xor C(9);
    SUM(10) <= P(10) xor C(10);
    SUM(11) <= P(11) xor C(11);
    SUM(12) <= P(12) xor C(12);
    SUM(13) <= P(13) xor C(13);
    SUM(14) <= P(14) xor C(14);

    Cout <= C(15);

end rtl;

library ieee;
use ieee.std_logic_1164.all;

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

COMPONENT fulladder1a IS

PORT (
	cin, a, b 	       : IN STD_LOGIC;
	cout, s 		: OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT sklansky_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
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

ENTITY Compressor_52_16b_Sklansky IS
PORT ( 
	   a, b, c, d, e : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0) 
	 );
END Compressor_52_16b_Sklansky; 

ARCHITECTURE behavior OF Compressor_52_16b_Sklansky IS

signal COUTa, temp1, temp0: STD_LOGIC;
signal carrys : STD_LOGIC_vector(15 downto 0); 
signal cout11, cout22 : STD_LOGIC_vector(15 downto 0); 
signal sums : STD_LOGIC_vector(15 downto 1); 

begin

comp0 : compressor_5entradas1 port map (a(0) , b(0) , c(0) , d(0) , e(0) , '0'      , '0'        , cout11(0) , cout22(0) , sum (0) , carrys(0) );
comp1 : compressor_5entradas1 port map (a(1) , b(1) , c(1) , d(1) , e(1) , cout11(0) , cout22(0) , cout11(1) , cout22(1) , sums(1) , carrys(1) );
comp2 : compressor_5entradas1 port map (a(2) , b(2) , c(2) , d(2) , e(2) , cout11(1) , cout22(1) , cout11(2) , cout22(2) , sums(2) , carrys(2) );
comp3 : compressor_5entradas1 port map (a(3) , b(3) , c(3) , d(3) , e(3) , cout11(2) , cout22(2) , cout11(3) , cout22(3) , sums(3) , carrys(3) );
comp4 : compressor_5entradas1 port map (a(4) , b(4) , c(4) , d(4) , e(4) , cout11(3) , cout22(3) , cout11(4) , cout22(4) , sums(4) , carrys(4) );
comp5 : compressor_5entradas1 port map (a(5) , b(5) , c(5) , d(5) , e(5) , cout11(4) , cout22(4) , cout11(5) , cout22(5) , sums(5) , carrys(5) );
comp6 : compressor_5entradas1 port map (a(6) , b(6) , c(6) , d(6) , e(6) , cout11(5) , cout22(5) , cout11(6) , cout22(6) , sums(6) , carrys(6) );
comp7 : compressor_5entradas1 port map (a(7) , b(7) , c(7) , d(7) , e(7) , cout11(6) , cout22(6) , cout11(7) , cout22(7) , sums(7) , carrys(7) );
comp8 : compressor_5entradas1 port map (a(8) , b(8) , c(8) , d(8) , e(8) , cout11(7) , cout22(7) , cout11(8) , cout22(8) , sums(8) , carrys(8) );
comp9 : compressor_5entradas1 port map (a(9) , b(9) , c(9) , d(9) , e(9) , cout11(8) , cout22(8) , cout11(9) , cout22(9) , sums(9) , carrys(9) );
comp10 : compressor_5entradas1 port map (a(10) , b(10) , c(10) , d(10) , e(10) , cout11(9) , cout22(9) , cout11(10) , cout22(10) , sums(10) , carrys(10) );
comp11 : compressor_5entradas1 port map (a(11) , b(11) , c(11) , d(11) , e(11) , cout11(10) , cout22(10) , cout11(11) , cout22(11) , sums(11) , carrys(11) );
comp12 : compressor_5entradas1 port map (a(12) , b(12) , c(12) , d(12) , e(12) , cout11(11) , cout22(11) , cout11(12) , cout22(12) , sums(12) , carrys(12) );
comp13 : compressor_5entradas1 port map (a(13) , b(13) , c(13) , d(13) , e(13) , cout11(12) , cout22(12) , cout11(13) , cout22(13) , sums(13) , carrys(13) );
comp14 : compressor_5entradas1 port map (a(14) , b(14) , c(14) , d(14) , e(14) , cout11(13) , cout22(13) , cout11(14) , cout22(14) , sums(14) , carrys(14) );
comp15 : compressor_5entradas1 port map (a(15) , b(15) , c(15) , d(15) , e(15) , cout11(14) , cout22(14) , cout11(15) , cout22(15) , sums(15) , carrys(15) );

comp16: sklansky_15 port map (carrys(14 downto 0), sums(15 downto 1), '0', sum(15 downto 1), Couta);
comp17: compressor_4entradas1 port map (cout11(15), cout22(15), carrys(15), Couta, '0', temp1, temp0, sum(16));
comp18: halfadder1a port map (temp1, temp0, sum(18), sum(17)); 

END behavior;