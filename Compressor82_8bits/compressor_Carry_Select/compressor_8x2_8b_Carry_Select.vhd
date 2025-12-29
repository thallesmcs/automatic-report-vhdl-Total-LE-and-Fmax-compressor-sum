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
		  
end circuito;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY halfadder_a IS

PORT (a, b 	       : IN STD_LOGIC;
	  cout, s 		: OUT STD_LOGIC
     );
END halfadder_a;

ARCHITECTURE soma OF halfadder_a IS
BEGIN

s    <= a XOR b ;
cout <= a AND b;

END soma;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fulladder_a IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END fulladder_a;

ARCHITECTURE comportamento OF fulladder_a IS

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

entity carry_select_7 is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of carry_select_7 is

    ---------------------------------------------------
    -- BLOCO 0: Ripple-Carry (bits 0–3)
    ---------------------------------------------------
    signal p0, p1, p2, p3 : std_logic;
    signal g0, g1, g2, g3 : std_logic;
    signal c1, c2, c3, c4 : std_logic;

    ---------------------------------------------------
    -- BLOCO 1: Carry-Select (bits 4–6)
    ---------------------------------------------------
    -- propagação e geração
    signal p4, p5, p6 : std_logic;
    signal g4, g5, g6 : std_logic;

    -- carry = 0
    signal c40, c50, c60 : std_logic;
    signal s40, s50, s60 : std_logic;

    -- carry = 1
    signal c41, c51, c61 : std_logic;
    signal s41, s51, s61 : std_logic;

    -- carry selecionado
    signal carry_sel : std_logic;

begin

    ---------------------------------------------------
    -- Propagate / Generate
    ---------------------------------------------------
    p0 <= A(0) xor B(0);
    p1 <= A(1) xor B(1);
    p2 <= A(2) xor B(2);
    p3 <= A(3) xor B(3);
    p4 <= A(4) xor B(4);
    p5 <= A(5) xor B(5);
    p6 <= A(6) xor B(6);

    g0 <= A(0) and B(0);
    g1 <= A(1) and B(1);
    g2 <= A(2) and B(2);
    g3 <= A(3) and B(3);
    g4 <= A(4) and B(4);
    g5 <= A(5) and B(5);
    g6 <= A(6) and B(6);

    ---------------------------------------------------
    -- BLOCO 0 (0–3): Ripple-Carry
    ---------------------------------------------------
    c1 <= g0 or (p0 and Cin);
    c2 <= g1 or (p1 and c1);
    c3 <= g2 or (p2 and c2);
    c4 <= g3 or (p3 and c3);

    SUM(0) <= p0 xor Cin;
    SUM(1) <= p1 xor c1;
    SUM(2) <= p2 xor c2;
    SUM(3) <= p3 xor c3;

    ---------------------------------------------------
    -- BLOCO 1 (4–6): Carry-Select
    ---------------------------------------------------
    -- Carry = 0
    c40 <= g4;
    s40 <= p4;

    c50 <= g5 or (p5 and c40);
    s50 <= p5 xor c40;

    c60 <= g6 or (p6 and c50);
    s60 <= p6 xor c50;

    -- Carry = 1
    c41 <= g4 or (p4 and '1');
    s41 <= p4 xor '1';

    c51 <= g5 or (p5 and c41);
    s51 <= p5 xor c41;

    c61 <= g6 or (p6 and c51);
    s61 <= p6 xor c51;

    ---------------------------------------------------
    -- MUX de seleção (carry-select)
    ---------------------------------------------------
    carry_sel <= c4;

    SUM(4) <= s40 when carry_sel='0' else s41;
    SUM(5) <= s50 when carry_sel='0' else s51;
    SUM(6) <= s60 when carry_sel='0' else s61;

    Cout <= c60 when carry_sel='0' else c61;

end architecture;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_componentsa IS

COMPONENT Mux21a is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
end COMPONENT;

COMPONENT halfadder_a IS

PORT (a, b 	       : IN STD_LOGIC;
	  cout, s 		: OUT STD_LOGIC
     );
END COMPONENT;

COMPONENT fulladder_a IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT carry_select_7 is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_componentsa;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE work.my_componentsa.all;

ENTITY compressor52 IS
PORT ( 
	   A, B, C, D, E : IN STD_LOGIC;
	   Cin1, Cin2    : IN STD_LOGIC;
	   Cout1, Cout2  : OUT STD_LOGIC;
	   Sum, Carry    : OUT STD_LOGIC 
	 );
END compressor52; 

ARCHITECTURE behavior OF compressor52 IS

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
USE work.my_componentsa.all;

entity compressor82 is

port(A,B,C,D,E,F,G,H,Cin0,Cin1,Cin2,Cin3,Cin4		: 		in std_logic;
		Sum, Carry, Cout0, Cout1, Cout2, Cout3, Cout4:    out std_logic);

end compressor82;

architecture arq5 of compressor82 is

	signal ox1: std_logic_vector(3 downto 0);
	signal ox2: std_logic_vector(3 downto 0);
	signal ox3: std_logic_vector(1 downto 0);
	signal ox4: std_logic;
	signal s8: std_logic_vector(5 downto 0);
	signal s4: std_logic_vector(1 downto 0);

begin

--================================================--	
--================================================--	

ox1(0)<= a xor b;
ox1(1)<= d xor e;
ox1(2)<= g xor h;
ox1(3)<= Cin1 xor Cin2;
ox2(0)<= ox1(0) xor c;
ox2(1)<= ox1(1) xor f;
ox2(2)<= ox1(2) xor Cin0;
ox2(3)<= ox1(3) xor Cin3;
ox3(0)<= ox2(0) xor ox2(1);
ox3(1)<= ox2(2) xor ox2(3);
ox4<= ox3(0) xor ox3(1);
sum<= ox4 xor Cin4; 

--============================================--

M0: Mux21a port map (a, c, ox1(0), s8(1));
M1: Mux21a port map (d, f, ox1(1), s8(2));
M2: Mux21a port map (g, Cin0, ox1(2), s8(3));
M3: Mux21a port map (ox2(0), ox2(2), ox3(0), s8(4));
M4: Mux21a port map (Cin1, Cin3, ox1(3), s8(5));
M5: Mux21a port map (ox2(3), Cin4, ox4 , s8(0));

carry <= s8(0);
cout0<= s8(1);
cout1<= s8(2);
cout2<= s8(3);
cout3<= s8(4);
cout4<= s8(5); 
 
end architecture;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_componentsb IS

COMPONENT RCA7b IS
PORT (
	  A, B: IN STD_LOGIC_VECTOR(6 downto 0);
	  Cout : OUT STD_LOGIC;
	  Sum : OUT STD_LOGIC_VECTOR(6 downto 0)
	  );

END COMPONENT;

COMPONENT compressor52 IS
PORT ( 
	   A, B, C, D, E : IN STD_LOGIC;
	   Cin1, Cin2    : IN STD_LOGIC;
	   Cout1, Cout2  : OUT STD_LOGIC;
	   Sum, Carry    : OUT STD_LOGIC 
	 );
END COMPONENT;

COMPONENT compressor82 is

port(A,B,C,D,E,F,G,H,Cin0,Cin1,Cin2,Cin3,Cin4		: 		in std_logic;
		Sum, Carry, Cout0, Cout1, Cout2, Cout3, Cout4:    out std_logic);

end COMPONENT;

END my_componentsb;

library ieee;
use ieee.std_logic_1164.all;
USE work.my_componentsa.all;
USE work.my_componentsb.all;

ENTITY compressor_8x2_8b_Carry_Select IS
PORT ( a, b, c, d, e, f, g, h : IN  STD_LOGIC_vector(7 downto 0);
	   sum           : OUT STD_LOGIC_vector(10 downto 0)
	  );
END compressor_8x2_8b_Carry_Select; 

ARCHITECTURE behavior OF compressor_8x2_8b_Carry_Select IS

SIGNAL carrya: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL couta0, couta1, couta2, couta3, couta4: STD_LOGIC;
SIGNAL coutb0, coutb1, coutb2, coutb3, coutb4: STD_LOGIC;
SIGNAL coutc0, coutc1, coutc2, coutc3, coutc4: STD_LOGIC;
SIGNAL coutd0, coutd1, coutd2, coutd3, coutd4: STD_LOGIC;
SIGNAL coute0, coute1, coute2, coute3, coute4: STD_LOGIC;
SIGNAL coutf0, coutf1, coutf2, coutf3, coutf4: STD_LOGIC;
SIGNAL coutg0, coutg1, coutg2, coutg3, coutg4: STD_LOGIC;
SIGNAL couth0, couth1, couth2, couth3, couth4: STD_LOGIC;
SIGNAL suma: STD_LOGIC_VECTOR(7 downto 1);
SIGNAL coutda2, coutda1, Coutab, carryda: STD_LOGIC;

BEGIN

stage0: compressor82 port map (a(0), b(0), c(0), d(0), e(0), f(0), g(0), h(0), '0', '0', '0', '0', '0', sum(0), carrya(0), couta0, couta1, couta2, couta3, couta4);
stage1: compressor82 port map (a(1), b(1), c(1), d(1), e(1), f(1), g(1), h(1), couta0, couta1, couta2, couta3, couta4, suma(1), carrya(1), coutb0, coutb1, coutb2, coutb3, coutb4);
stage2: compressor82 port map (a(2), b(2), c(2), d(2), e(2), f(2), g(2), h(2), coutb0, coutb1, coutb2, coutb3, coutb4, suma(2), carrya(2), coutc0, coutc1, coutc2, coutc3, coutc4);
stage3: compressor82 port map (a(3), b(3), c(3), d(3), e(3), f(3), g(3), h(3), coutc0, coutc1, coutc2, coutc3, coutc4, suma(3), carrya(3), coutd0, coutd1, coutd2, coutd3, coutd4);
stage4: compressor82 port map (a(4), b(4), c(4), d(4), e(4), f(4), g(4), h(4), coutd0, coutd1, coutd2, coutd3, coutd4, suma(4), carrya(4), coute0, coute1, coute2, coute3, coute4);
stage5: compressor82 port map (a(5), b(5), c(5), d(5), e(5), f(5), g(5), h(5), coute0, coute1, coute2, coute3, coute4, suma(5), carrya(5), coutf0, coutf1, coutf2, coutf3, coutf4);
stage6: compressor82 port map (a(6), b(6), c(6), d(6), e(6), f(6), g(6), h(6), coutf0, coutf1, coutf2, coutf3, coutf4, suma(6), carrya(6), coutg0, coutg1, coutg2, coutg3, coutg4);
stage7: compressor82 port map (a(7), b(7), c(7), d(7), e(7), f(7), g(7), h(7), coutg0, coutg1, coutg2, coutg3, coutg4, suma(7), carrya(7), couth0, couth1, couth2, couth3, couth4);

stage8: carry_select_7 port map (carrya(6 downto 0), suma, '0', sum(7 downto 1), Coutab);

stage9: compressor52 port map (couth0, couth1, couth2, couth3, couth4, carrya(7), Coutab, coutda2, coutda1, sum(8), carryda);
stage10: fulladder_a port map (carryda, coutda2, coutda1, sum(10), sum(9)); 

END behavior;
