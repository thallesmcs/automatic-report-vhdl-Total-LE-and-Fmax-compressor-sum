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

entity carry_select_15 is
    port(
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end entity;

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

COMPONENT carry_select_15 is
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

ENTITY compressor_8x2_16b_Carry_Select IS
PORT ( a, b, c, d, e, f, g, h : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0)
	  );
END compressor_8x2_16b_Carry_Select; 

ARCHITECTURE behavior OF compressor_8x2_16b_Carry_Select IS

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

stage16: carry_select_15 port map (carrya(14 downto 0), suma, '0', sum(15 downto 1), Coutab);

stage17: compressor52 port map (coutp0, coutp1, coutp2, coutp3, coutp4, carrya(15), Coutab, coutda2, coutda1, sum(16), carryda);
stage18: fulladder_a port map (carryda, coutda2, coutda1, sum(18), sum(17)); 

END behavior;
