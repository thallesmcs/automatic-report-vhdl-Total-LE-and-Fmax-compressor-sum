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

entity carry_skip_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end carry_skip_15;

architecture rtl of carry_skip_15 is

    -- carries internos 
    signal c0, c1, c2, c3, c4, c5 : std_logic;
    signal c6, c7, c8, c9, c10    : std_logic;
    signal c11, c12, c13, c14, c15 : std_logic;

    -- carries intermediários 
    signal c5_ripple  : std_logic;
    signal c10_ripple : std_logic;

    -- propagate bits
    signal p0, p1, p2, p3, p4 : std_logic;
    signal p5, p6, p7, p8, p9 : std_logic;
    signal p10, p11, p12, p13, p14 : std_logic;

    -- propagate de bloco (para os 3 blocos)
    signal Pblock0, Pblock1, Pblock2 : std_logic;

begin
    
    c0 <= Cin;

    -----------------------------------------------------------
    --  Propagate por bit
    -----------------------------------------------------------
    p0  <= A(0)  xor B(0);
    p1  <= A(1)  xor B(1);
    p2  <= A(2)  xor B(2);
    p3  <= A(3)  xor B(3);
    p4  <= A(4)  xor B(4);

    p5  <= A(5)  xor B(5);
    p6  <= A(6)  xor B(6);
    p7  <= A(7)  xor B(7);
    p8  <= A(8)  xor B(8);
    p9  <= A(9)  xor B(9);

    p10 <= A(10) xor B(10);
    p11 <= A(11) xor B(11);
    p12 <= A(12) xor B(12);
    p13 <= A(13) xor B(13);
    p14 <= A(14) xor B(14);

    -----------------------------------------------------------
    --  Full Adders do bloco 0 
    -----------------------------------------------------------

    c1 <= (A(0) and B(0)) or (p0 and c0);
    SUM(0) <= p0 xor c0;

    c2 <= (A(1) and B(1)) or (p1 and c1);
    SUM(1) <= p1 xor c1;

    c3 <= (A(2) and B(2)) or (p2 and c2);
    SUM(2) <= p2 xor c2;

    c4 <= (A(3) and B(3)) or (p3 and c3);
    SUM(3) <= p3 xor c3;

    c5_ripple <= (A(4) and B(4)) or (p4 and c4);
    SUM(4) <= p4 xor c4;

    Pblock0 <= p0 and p1 and p2 and p3 and p4;

    -- carry final do bloco 0 
    c5 <= (Pblock0 and c0) or ((not Pblock0) and c5_ripple);

    -----------------------------------------------------------
    --  Bloco 1 
    -----------------------------------------------------------

    -- ripple interno do bloco 1 até c10_ripple
    c6 <= (A(5) and B(5)) or (p5 and c5);
    SUM(5) <= p5 xor c5;

    c7 <= (A(6) and B(6)) or (p6 and c6);
    SUM(6) <= p6 xor c6;

    c8 <= (A(7) and B(7)) or (p7 and c7);
    SUM(7) <= p7 xor c7;

    c9 <= (A(8) and B(8)) or (p8 and c8);
    SUM(8) <= p8 xor c8;

    c10_ripple <= (A(9) and B(9)) or (p9 and c9);
    SUM(9) <= p9 xor c9;

    -- propagate bloco 1
    Pblock1 <= p5 and p6 and p7 and p8 and p9;

    -- carry final do bloco 1 
    c10 <= (Pblock1 and c5) or ((not Pblock1) and c10_ripple);

    -----------------------------------------------------------
    --  Bloco 2 
    -----------------------------------------------------------

    c11 <= (A(10) and B(10)) or (p10 and c10);
    SUM(10) <= p10 xor c10;

    c12 <= (A(11) and B(11)) or (p11 and c11);
    SUM(11) <= p11 xor c11;

    c13 <= (A(12) and B(12)) or (p12 and c12);
    SUM(12) <= p12 xor c12;

    c14 <= (A(13) and B(13)) or (p13 and c13);
    SUM(13) <= p13 xor c13;

    c15 <= (A(14) and B(14)) or (p14 and c14);
    SUM(14) <= p14 xor c14;

    -- propagate bloco 2
    Pblock2 <= p10 and p11 and p12 and p13 and p14;

    Cout <= (Pblock2 and c10) or ((not Pblock2) and c15);

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

COMPONENT carry_skip_15 is
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

ENTITY Compressor_52_16b_Carry_Skip IS
PORT ( 
	   a, b, c, d, e : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0) 
	 );
END Compressor_52_16b_Carry_Skip; 

ARCHITECTURE behavior OF Compressor_52_16b_Carry_Skip IS

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

comp16: carry_skip_15 port map (carrys(14 downto 0), sums(15 downto 1), '0', sum(15 downto 1), Couta);
comp17: compressor_4entradas1 port map (cout11(15), cout22(15), carrys(15), Couta, '0', temp1, temp0, sum(16));
comp18: halfadder1a port map (temp1, temp0, sum(18), sum(17)); 

END behavior;