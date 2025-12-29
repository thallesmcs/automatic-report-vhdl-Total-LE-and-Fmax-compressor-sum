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

entity kogge_stone_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end kogge_stone_15;

architecture rtl of kogge_stone_15 is

    -- Propagate (P) e Generate (G) iniciais
    signal P0 : std_logic_vector(14 downto 0);
    signal G0 : std_logic_vector(14 downto 0);

    -- Nível 1
    signal P1 : std_logic_vector(14 downto 0);
    signal G1 : std_logic_vector(14 downto 0);

    -- Nível 2
    signal P2 : std_logic_vector(14 downto 0);
    signal G2 : std_logic_vector(14 downto 0);

    -- Nível 3
    signal P3 : std_logic_vector(14 downto 0);
    signal G3 : std_logic_vector(14 downto 0);

    -- Nível 4
    signal P4 : std_logic_vector(14 downto 0);
    signal G4 : std_logic_vector(14 downto 0);

    signal C  : std_logic_vector(15 downto 0);

begin

    -------------------------------------------------------------------------
    -- GERAÇÃO DE PROPAGAÇÃO E GERAÇÃO INICIAL
    -------------------------------------------------------------------------
    P0 <= A xor B;
    G0 <= A and B;

    C(0) <= Cin;

    -------------------------------------------------------------------------
    -- NÍVEL 1 (distância = 1)
    -------------------------------------------------------------------------
    P1(0) <= P0(0);
    G1(0) <= G0(0);

    P1(1) <= P0(1) and P0(0);
    G1(1) <= G0(1) or (P0(1) and G0(0));

    P1(2)  <= P0(2)  and P0(1);
    G1(2)  <= G0(2)  or (P0(2)  and G0(1));

    P1(3)  <= P0(3)  and P0(2);
    G1(3)  <= G0(3)  or (P0(3)  and G0(2));

    P1(4)  <= P0(4)  and P0(3);
    G1(4)  <= G0(4)  or (P0(4)  and G0(3));

    P1(5)  <= P0(5)  and P0(4);
    G1(5)  <= G0(5)  or (P0(5)  and G0(4));

    P1(6)  <= P0(6)  and P0(5);
    G1(6)  <= G0(6)  or (P0(6)  and G0(5));

    P1(7)  <= P0(7)  and P0(6);
    G1(7)  <= G0(7)  or (P0(7)  and G0(6));

    P1(8)  <= P0(8)  and P0(7);
    G1(8)  <= G0(8)  or (P0(8)  and G0(7));

    P1(9)  <= P0(9)  and P0(8);
    G1(9)  <= G0(9)  or (P0(9)  and G0(8));

    P1(10) <= P0(10) and P0(9);
    G1(10) <= G0(10) or (P0(10) and G0(9));

    P1(11) <= P0(11) and P0(10);
    G1(11) <= G0(11) or (P0(11) and G0(10));

    P1(12) <= P0(12) and P0(11);
    G1(12) <= G0(12) or (P0(12) and G0(11));

    P1(13) <= P0(13) and P0(12);
    G1(13) <= G0(13) or (P0(13) and G0(12));

    P1(14) <= P0(14) and P0(13);
    G1(14) <= G0(14) or (P0(14) and G0(13));


    -------------------------------------------------------------------------
    -- NÍVEL 2 (distância = 2)
    -------------------------------------------------------------------------
    P2(0) <= P1(0);
    G2(0) <= G1(0);

    P2(1) <= P1(1);
    G2(1) <= G1(1);

    P2(2)  <= P1(2)  and P1(0);
    G2(2)  <= G1(2)  or (P1(2)  and G1(0));

    P2(3)  <= P1(3)  and P1(1);
    G2(3)  <= G1(3)  or (P1(3)  and G1(1));

    P2(4)  <= P1(4)  and P1(2);
    G2(4)  <= G1(4)  or (P1(4)  and G1(2));

    P2(5)  <= P1(5)  and P1(3);
    G2(5)  <= G1(5)  or (P1(5)  and G1(3));

    P2(6)  <= P1(6)  and P1(4);
    G2(6)  <= G1(6)  or (P1(6)  and G1(4));

    P2(7)  <= P1(7)  and P1(5);
    G2(7)  <= G1(7)  or (P1(7)  and G1(5));

    P2(8)  <= P1(8)  and P1(6);
    G2(8)  <= G1(8)  or (P1(8)  and G1(6));

    P2(9)  <= P1(9)  and P1(7);
    G2(9)  <= G1(9)  or (P1(9)  and G1(7));

    P2(10) <= P1(10) and P1(8);
    G2(10) <= G1(10) or (P1(10) and G1(8));

    P2(11) <= P1(11) and P1(9);
    G2(11) <= G1(11) or (P1(11) and G1(9));

    P2(12) <= P1(12) and P1(10);
    G2(12) <= G1(12) or (P1(12) and G1(10));

    P2(13) <= P1(13) and P1(11);
    G2(13) <= G1(13) or (P1(13) and G1(11));

    P2(14) <= P1(14) and P1(12);
    G2(14) <= G1(14) or (P1(14) and G1(12));


    -------------------------------------------------------------------------
    -- NÍVEL 3 (distância = 4)
    -------------------------------------------------------------------------
    P3(0) <= P2(0);  G3(0) <= G2(0);
    P3(1) <= P2(1);  G3(1) <= G2(1);
    P3(2) <= P2(2);  G3(2) <= G2(2);
    P3(3) <= P2(3);  G3(3) <= G2(3);

    P3(4)  <= P2(4)  and P2(0);
    G3(4)  <= G2(4)  or (P2(4)  and G2(0));

    P3(5)  <= P2(5)  and P2(1);
    G3(5)  <= G2(5)  or (P2(5)  and G2(1));

    P3(6)  <= P2(6)  and P2(2);
    G3(6)  <= G2(6)  or (P2(6)  and G2(2));

    P3(7)  <= P2(7)  and P2(3);
    G3(7)  <= G2(7)  or (P2(7)  and G2(3));

    P3(8)  <= P2(8)  and P2(4);
    G3(8)  <= G2(8)  or (P2(8)  and G2(4));

    P3(9)  <= P2(9)  and P2(5);
    G3(9)  <= G2(9)  or (P2(9)  and G2(5));

    P3(10) <= P2(10) and P2(6);
    G3(10) <= G2(10) or (P2(10) and G2(6));

    P3(11) <= P2(11) and P2(7);
    G3(11) <= G2(11) or (P2(11) and G2(7));

    P3(12) <= P2(12) and P2(8);
    G3(12) <= G2(12) or (P2(12) and G2(8));

    P3(13) <= P2(13) and P2(9);
    G3(13) <= G2(13) or (P2(13) and G2(9));

    P3(14) <= P2(14) and P2(10);
    G3(14) <= G2(14) or (P2(14) and G2(10));


    -------------------------------------------------------------------------
    -- NÍVEL 4 (distância = 8)
    -------------------------------------------------------------------------
    P4(0) <= P3(0);  G4(0) <= G3(0);
    P4(1) <= P3(1);  G4(1) <= G3(1);
    P4(2) <= P3(2);  G4(2) <= G3(2);
    P4(3) <= P3(3);  G4(3) <= G3(3);
    P4(4) <= P3(4);  G4(4) <= G3(4);
    P4(5) <= P3(5);  G4(5) <= G3(5);
    P4(6) <= P3(6);  G4(6) <= G3(6);
    P4(7) <= P3(7);  G4(7) <= G3(7);

    P4(8)  <= P3(8)  and P3(0);
    G4(8)  <= G3(8)  or (P3(8)  and G3(0));

    P4(9)  <= P3(9)  and P3(1);
    G4(9)  <= G3(9)  or (P3(9)  and G3(1));

    P4(10) <= P3(10) and P3(2);
    G4(10) <= G3(10) or (P3(10) and G3(2));

    P4(11) <= P3(11) and P3(3);
    G4(11) <= G3(11) or (P3(11) and G3(3));

    P4(12) <= P3(12) and P3(4);
    G4(12) <= G3(12) or (P3(12) and G3(4));

    P4(13) <= P3(13) and P3(5);
    G4(13) <= G3(13) or (P3(13) and G3(5));

    P4(14) <= P3(14) and P3(6);
    G4(14) <= G3(14) or (P3(14) and G3(6));


    -------------------------------------------------------------------------
    -- CÁLCULO FINAL DOS CARRIES
    -------------------------------------------------------------------------
    C(1)  <= G4(0) or (P4(0) and C(0));
    C(2)  <= G4(1) or (P4(1) and C(0));
    C(3)  <= G4(2) or (P4(2) and C(0));
    C(4)  <= G4(3) or (P4(3) and C(0));
    C(5)  <= G4(4) or (P4(4) and C(0));
    C(6)  <= G4(5) or (P4(5) and C(0));
    C(7)  <= G4(6) or (P4(6) and C(0));
    C(8)  <= G4(7) or (P4(7) and C(0));
    C(9)  <= G4(8) or (P4(8) and C(0));
    C(10) <= G4(9) or (P4(9) and C(0));
    C(11) <= G4(10) or (P4(10) and C(0));
    C(12) <= G4(11) or (P4(11) and C(0));
    C(13) <= G4(12) or (P4(12) and C(0));
    C(14) <= G4(13) or (P4(13) and C(0));
    C(15) <= G4(14) or (P4(14) and C(0));

    -------------------------------------------------------------------------
    -- SOMA FINAL
    -------------------------------------------------------------------------
    SUM(0)  <= P0(0) xor C(0);
    SUM(1)  <= P0(1) xor C(1);
    SUM(2)  <= P0(2) xor C(2);
    SUM(3)  <= P0(3) xor C(3);
    SUM(4)  <= P0(4) xor C(4);
    SUM(5)  <= P0(5) xor C(5);
    SUM(6)  <= P0(6) xor C(6);
    SUM(7)  <= P0(7) xor C(7);
    SUM(8)  <= P0(8) xor C(8);
    SUM(9)  <= P0(9) xor C(9);
    SUM(10) <= P0(10) xor C(10);
    SUM(11) <= P0(11) xor C(11);
    SUM(12) <= P0(12) xor C(12);
    SUM(13) <= P0(13) xor C(13);
    SUM(14) <= P0(14) xor C(14);

    Cout <= C(15);

end RTL;

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

COMPONENT kogge_stone_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
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

ENTITY compressor_8x2_16b_Kogge_Stone IS
PORT ( a, b, c, d, e, f, g, h : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0)
	  );
END compressor_8x2_16b_Kogge_Stone; 

ARCHITECTURE behavior OF compressor_8x2_16b_Kogge_Stone IS

SIGNAL carrya: STD_LOGIC_VECTOR(15 downto 0);
SIGNAL suma: STD_LOGIC_VECTOR(15 downto 1);
SIGNAL couta0, couta1, couta2, couta3, couta4: STD_LOGIC;
SIGNAL coutb0, coutb1, coutb2, coutb3, coutb4: STD_LOGIC;
SIGNAL coutc0, coutc1, coutc2, coutc3, coutc4: STD_LOGIC;
SIGNAL coutd0, coutd1, coutd2, coutd3, coutd4: STD_LOGIC;
SIGNAL coute0, coute1, coute2, coute3, coute4: STD_LOGIC;
SIGNAL coutf0, coutf1, coutf2, coutf3, coutf4: STD_LOGIC;
SIGNAL coutg0, coutg1, coutg2, coutg3, coutg4: STD_LOGIC;
SIGNAL couth0, couth1, couth2, couth3, couth4: STD_LOGIC;
SIGNAL couti0, couti1, couti2, couti3, couti4: STD_LOGIC;
SIGNAL coutj0, coutj1, coutj2, coutj3, coutj4: STD_LOGIC;
SIGNAL coutk0, coutk1, coutk2, coutk3, coutk4: STD_LOGIC;
SIGNAL coutl0, coutl1, coutl2, coutl3, coutl4: STD_LOGIC;
SIGNAL coutm0, coutm1, coutm2, coutm3, coutm4: STD_LOGIC;
SIGNAL coutn0, coutn1, coutn2, coutn3, coutn4: STD_LOGIC;
SIGNAL couto0, couto1, couto2, couto3, couto4: STD_LOGIC;
SIGNAL coutp0, coutp1, coutp2, coutp3, coutp4: STD_LOGIC;
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
stage8: compressor82 port map (a(8), b(8), c(8), d(8), e(8), f(8), g(8), h(8), couth0, couth1, couth2, couth3, couth4, suma(8), carrya(8), couti0, couti1, couti2, couti3, couti4);
stage9: compressor82 port map (a(9), b(9), c(9), d(9), e(9), f(9), g(9), h(9), couti0, couti1, couti2, couti3, couti4, suma(9), carrya(9), coutj0, coutj1, coutj2, coutj3, coutj4);
stage10: compressor82 port map (a(10), b(10), c(10), d(10), e(10), f(10), g(10), h(10), coutj0, coutj1, coutj2, coutj3, coutj4, suma(10), carrya(10), coutk0, coutk1, coutk2, coutk3, coutk4);
stage11: compressor82 port map (a(11), b(11), c(11), d(11), e(11), f(11), g(11), h(11), coutk0, coutk1, coutk2, coutk3, coutk4, suma(11), carrya(11), coutl0, coutl1, coutl2, coutl3, coutl4);
stage12: compressor82 port map (a(12), b(12), c(12), d(12), e(12), f(12), g(12), h(12), coutl0, coutl1, coutl2, coutl3, coutl4, suma(12), carrya(12), coutm0, coutm1, coutm2, coutm3, coutm4);
stage13: compressor82 port map (a(13), b(13), c(13), d(13), e(13), f(13), g(13), h(13), coutm0, coutm1, coutm2, coutm3, coutm4, suma(13), carrya(13), coutn0, coutn1, coutn2, coutn3, coutn4);
stage14: compressor82 port map (a(14), b(14), c(14), d(14), e(14), f(14), g(14), h(14), coutn0, coutn1, coutn2, coutn3, coutn4, suma(14), carrya(14), couto0, couto1, couto2, couto3, couto4);
stage15: compressor82 port map (a(15), b(15), c(15), d(15), e(15), f(15), g(15), h(15), couto0, couto1, couto2, couto3, couto4, suma(15), carrya(15), coutp0, coutp1, coutp2, coutp3, coutp4);

stage16: kogge_stone_15 port map (carrya(14 downto 0), suma, '0', sum(15 downto 1), Coutab);

stage17: compressor52 port map (coutp0, coutp1, coutp2, coutp3, coutp4, carrya(15), Coutab, coutda2, coutda1, sum(16), carryda);
stage18: fulladder_a port map (carryda, coutda2, coutda1, sum(18), sum(17)); 

END behavior;
