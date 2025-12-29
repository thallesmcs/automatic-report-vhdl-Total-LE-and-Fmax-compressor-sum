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
use ieee.numeric_std.all;

entity brent_kung_15 is
    port (
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of brent_kung_15 is

    -- propagate and generate
    signal p0  : std_logic; signal g0  : std_logic;
    signal p1  : std_logic; signal g1  : std_logic;
    signal p2  : std_logic; signal g2  : std_logic;
    signal p3  : std_logic; signal g3  : std_logic;
    signal p4  : std_logic; signal g4  : std_logic;
    signal p5  : std_logic; signal g5  : std_logic;
    signal p6  : std_logic; signal g6  : std_logic;
    signal p7  : std_logic; signal g7  : std_logic;
    signal p8  : std_logic; signal g8  : std_logic;
    signal p9  : std_logic; signal g9  : std_logic;
    signal p10 : std_logic; signal g10 : std_logic;
    signal p11 : std_logic; signal g11 : std_logic;
    signal p12 : std_logic; signal g12 : std_logic;
    signal p13 : std_logic; signal g13 : std_logic;
    signal p14 : std_logic; signal g14 : std_logic;

    -- Level 1 (distance 1) 
    signal P_l1_0  : std_logic; signal G_l1_0  : std_logic;
    signal P_l1_1  : std_logic; signal G_l1_1  : std_logic;
    signal P_l1_2  : std_logic; signal G_l1_2  : std_logic;
    signal P_l1_3  : std_logic; signal G_l1_3  : std_logic;
    signal P_l1_4  : std_logic; signal G_l1_4  : std_logic;
    signal P_l1_5  : std_logic; signal G_l1_5  : std_logic;
    signal P_l1_6  : std_logic; signal G_l1_6  : std_logic;
    signal P_l1_7  : std_logic; signal G_l1_7  : std_logic;
    signal P_l1_8  : std_logic; signal G_l1_8  : std_logic;
    signal P_l1_9  : std_logic; signal G_l1_9  : std_logic;
    signal P_l1_10 : std_logic; signal G_l1_10 : std_logic;
    signal P_l1_11 : std_logic; signal G_l1_11 : std_logic;
    signal P_l1_12 : std_logic; signal G_l1_12 : std_logic;
    signal P_l1_13 : std_logic; signal G_l1_13 : std_logic;
    signal P_l1_14 : std_logic; signal G_l1_14 : std_logic;

    -- Level 2 (distance 2) 
    signal P_l2_0  : std_logic; signal G_l2_0  : std_logic;
    signal P_l2_1  : std_logic; signal G_l2_1  : std_logic;
    signal P_l2_2  : std_logic; signal G_l2_2  : std_logic;
    signal P_l2_3  : std_logic; signal G_l2_3  : std_logic;
    signal P_l2_4  : std_logic; signal G_l2_4  : std_logic;
    signal P_l2_5  : std_logic; signal G_l2_5  : std_logic;
    signal P_l2_6  : std_logic; signal G_l2_6  : std_logic;
    signal P_l2_7  : std_logic; signal G_l2_7  : std_logic;
    signal P_l2_8  : std_logic; signal G_l2_8  : std_logic;
    signal P_l2_9  : std_logic; signal G_l2_9  : std_logic;
    signal P_l2_10 : std_logic; signal G_l2_10 : std_logic;
    signal P_l2_11 : std_logic; signal G_l2_11 : std_logic;
    signal P_l2_12 : std_logic; signal G_l2_12 : std_logic;
    signal P_l2_13 : std_logic; signal G_l2_13 : std_logic;
    signal P_l2_14 : std_logic; signal G_l2_14 : std_logic;

    -- Level 3 (distance 4) 
    signal P_l3_0  : std_logic; signal G_l3_0  : std_logic;
    signal P_l3_1  : std_logic; signal G_l3_1  : std_logic;
    signal P_l3_2  : std_logic; signal G_l3_2  : std_logic;
    signal P_l3_3  : std_logic; signal G_l3_3  : std_logic;
    signal P_l3_4  : std_logic; signal G_l3_4  : std_logic;
    signal P_l3_5  : std_logic; signal G_l3_5  : std_logic;
    signal P_l3_6  : std_logic; signal G_l3_6  : std_logic;
    signal P_l3_7  : std_logic; signal G_l3_7  : std_logic;
    signal P_l3_8  : std_logic; signal G_l3_8  : std_logic;
    signal P_l3_9  : std_logic; signal G_l3_9  : std_logic;
    signal P_l3_10 : std_logic; signal G_l3_10 : std_logic;
    signal P_l3_11 : std_logic; signal G_l3_11 : std_logic;
    signal P_l3_12 : std_logic; signal G_l3_12 : std_logic;
    signal P_l3_13 : std_logic; signal G_l3_13 : std_logic;
    signal P_l3_14 : std_logic; signal G_l3_14 : std_logic;

    signal P_pref_0  : std_logic; signal G_pref_0  : std_logic;
    signal P_pref_1  : std_logic; signal G_pref_1  : std_logic;
    signal P_pref_2  : std_logic; signal G_pref_2  : std_logic;
    signal P_pref_3  : std_logic; signal G_pref_3  : std_logic;
    signal P_pref_4  : std_logic; signal G_pref_4  : std_logic;
    signal P_pref_5  : std_logic; signal G_pref_5  : std_logic;
    signal P_pref_6  : std_logic; signal G_pref_6  : std_logic;
    signal P_pref_7  : std_logic; signal G_pref_7  : std_logic;
    signal P_pref_8  : std_logic; signal G_pref_8  : std_logic;
    signal P_pref_9  : std_logic; signal G_pref_9  : std_logic;
    signal P_pref_10 : std_logic; signal G_pref_10 : std_logic;
    signal P_pref_11 : std_logic; signal G_pref_11 : std_logic;
    signal P_pref_12 : std_logic; signal G_pref_12 : std_logic;
    signal P_pref_13 : std_logic; signal G_pref_13 : std_logic;
    signal P_pref_14 : std_logic; signal G_pref_14 : std_logic;

    -- carries C0..C15 (C0 = Cin)
    signal C0  : std_logic;
    signal C1  : std_logic;
    signal C2  : std_logic;
    signal C3  : std_logic;
    signal C4  : std_logic;
    signal C5  : std_logic;
    signal C6  : std_logic;
    signal C7  : std_logic;
    signal C8  : std_logic;
    signal C9  : std_logic;
    signal C10 : std_logic;
    signal C11 : std_logic;
    signal C12 : std_logic;
    signal C13 : std_logic;
    signal C14 : std_logic;
    signal C15 : std_logic;

begin

    p0  <= A(0) xor B(0);  g0  <= A(0) and B(0);
    p1  <= A(1) xor B(1);  g1  <= A(1) and B(1);
    p2  <= A(2) xor B(2);  g2  <= A(2) and B(2);
    p3  <= A(3) xor B(3);  g3  <= A(3) and B(3);
    p4  <= A(4) xor B(4);  g4  <= A(4) and B(4);
    p5  <= A(5) xor B(5);  g5  <= A(5) and B(5);
    p6  <= A(6) xor B(6);  g6  <= A(6) and B(6);
    p7  <= A(7) xor B(7);  g7  <= A(7) and B(7);
    p8  <= A(8) xor B(8);  g8  <= A(8) and B(8);
    p9  <= A(9) xor B(9);  g9  <= A(9) and B(9);
    p10 <= A(10) xor B(10); g10 <= A(10) and B(10);
    p11 <= A(11) xor B(11); g11 <= A(11) and B(11);
    p12 <= A(12) xor B(12); g12 <= A(12) and B(12);
    p13 <= A(13) xor B(13); g13 <= A(13) and B(13);
    p14 <= A(14) xor B(14); g14 <= A(14) and B(14);

    -- Level 1 (distance = 1) 
    G_l1_0  <= g0;        P_l1_0  <= p0;

    G_l1_1  <= g1 or (p1 and g0);
    P_l1_1  <= p1 and p0;

    G_l1_2  <= g2;        P_l1_2  <= p2;

    G_l1_3  <= g3 or (p3 and g2);
    P_l1_3  <= p3 and p2;

    G_l1_4  <= g4;        P_l1_4  <= p4;
    
    G_l1_5  <= g5 or (p5 and g4);
    P_l1_5  <= p5 and p4;
    
    G_l1_6  <= g6;        P_l1_6  <= p6;
    
    G_l1_7  <= g7 or (p7 and g6);
    P_l1_7  <= p7 and p6;
    
    G_l1_8  <= g8;        P_l1_8  <= p8;
    
    G_l1_9  <= g9 or (p9 and g8);
    P_l1_9  <= p9 and p8;
    
    G_l1_10 <= g10;       P_l1_10 <= p10;
    
    G_l1_11 <= g11 or (p11 and g10);
    P_l1_11 <= p11 and p10;
    
    G_l1_12 <= g12;       P_l1_12 <= p12;
    
    G_l1_13 <= g13 or (p13 and g12);
    P_l1_13 <= p13 and p12;
    
    G_l1_14 <= g14;       P_l1_14 <= p14;

    -- Level 2 (distance = 2)
    G_l2_0  <= G_l1_0;    P_l2_0  <= P_l1_0;
    G_l2_1  <= G_l1_1;    P_l2_1  <= P_l1_1;
    G_l2_2  <= G_l1_2;    P_l2_2  <= P_l1_2;

    G_l2_3  <= G_l1_3 or (P_l1_3 and G_l1_1);
    P_l2_3  <= P_l1_3 and P_l1_1;

    G_l2_4  <= G_l1_4;    P_l2_4  <= P_l1_4;
    G_l2_5  <= G_l1_5;    P_l2_5  <= P_l1_5;
    G_l2_6  <= G_l1_6;    P_l2_6  <= P_l1_6;

    G_l2_7  <= G_l1_7 or (P_l1_7 and G_l1_5);
    P_l2_7  <= P_l1_7 and P_l1_5;

    G_l2_8  <= G_l1_8;    P_l2_8  <= P_l1_8;
    G_l2_9  <= G_l1_9;    P_l2_9  <= P_l1_9;
    G_l2_10 <= G_l1_10;   P_l2_10 <= P_l1_10;

    G_l2_11 <= G_l1_11 or (P_l1_11 and G_l1_9);
    P_l2_11 <= P_l1_11 and P_l1_9;

    G_l2_12 <= G_l1_12;   P_l2_12 <= P_l1_12;
    G_l2_13 <= G_l1_13;   P_l2_13 <= P_l1_13;
    G_l2_14 <= G_l1_14;   P_l2_14 <= P_l1_14;

    -- Level 3 (distance = 4)
    G_l3_0  <= G_l2_0;    P_l3_0  <= P_l2_0;
    G_l3_1  <= G_l2_1;    P_l3_1  <= P_l2_1;
    G_l3_2  <= G_l2_2;    P_l3_2  <= P_l2_2;
    G_l3_3  <= G_l2_3;    P_l3_3  <= P_l2_3;

    G_l3_7  <= G_l2_7 or (P_l2_7 and G_l2_3);
    P_l3_7  <= P_l2_7 and P_l2_3;

    G_l3_4  <= G_l2_4;    P_l3_4  <= P_l2_4;
    G_l3_5  <= G_l2_5;    P_l3_5  <= P_l2_5;
    G_l3_6  <= G_l2_6;    P_l3_6  <= P_l2_6;

    G_l3_8  <= G_l2_8;    P_l3_8  <= P_l2_8;
    G_l3_9  <= G_l2_9;    P_l3_9  <= P_l2_9;
    G_l3_10 <= G_l2_10;   P_l3_10 <= P_l2_10;
    G_l3_11 <= G_l2_11;   P_l3_11 <= P_l2_11;
    G_l3_12 <= G_l2_12;   P_l3_12 <= P_l2_12;
    G_l3_13 <= G_l2_13;   P_l3_13 <= P_l2_13;
    G_l3_14 <= G_l2_14;   P_l3_14 <= P_l2_14;

    -- prefix for bit 0
    G_pref_0  <= g0;
    P_pref_0  <= p0;

    -- prefix for bit 1
    G_pref_1  <= G_l1_1;
    P_pref_1  <= P_l1_1;

    -- prefix for bit 2
    G_pref_2  <= G_l1_2 or (P_l1_2 and G_pref_1);
    P_pref_2  <= P_l1_2 and P_pref_1;

    -- prefix for bit 3
    G_pref_3  <= G_l2_3;
    P_pref_3  <= P_l2_3;

    -- prefix for bit 4
    G_pref_4  <= G_l1_4 or (P_l1_4 and G_pref_3);
    P_pref_4  <= P_l1_4 and P_pref_3;

    -- prefix for bit 5
    G_pref_5  <= G_l1_5 or (P_l1_5 and G_pref_4);
    P_pref_5  <= P_l1_5 and P_pref_4;

    -- prefix for bit 6
    G_pref_6  <= G_l1_6 or (P_l1_6 and G_pref_5);
    P_pref_6  <= P_l1_6 and P_pref_5;

    -- prefix for bit 7
    G_pref_7  <= G_l3_7;
    P_pref_7  <= P_l3_7;

    -- prefix for bit 8
    G_pref_8  <= G_l1_8 or (P_l1_8 and G_pref_7);
    P_pref_8  <= P_l1_8 and P_pref_7;

    -- prefix for bit 9
    G_pref_9  <= G_l1_9 or (P_l1_9 and G_pref_8);
    P_pref_9  <= P_l1_9 and P_pref_8;

    -- prefix for bit 10
    G_pref_10 <= G_l1_10 or (P_l1_10 and G_pref_9);
    P_pref_10 <= P_l1_10 and P_pref_9;

    -- prefix for bit 11
    
    G_pref_11 <= G_l2_11 or (P_l2_11 and G_pref_7);
    P_pref_11 <= P_l2_11 and P_pref_7;

    -- prefix for bit 12 
    G_pref_12 <= G_l1_12 or (P_l1_12 and G_pref_11);
    P_pref_12 <= P_l1_12 and P_pref_11;

    -- prefix for bit 13
    G_pref_13 <= G_l1_13 or (P_l1_13 and G_pref_12);
    P_pref_13 <= P_l1_13 and P_pref_12;

    -- prefix for bit 14
    G_pref_14 <= G_l1_14 or (P_l1_14 and G_pref_13);
    P_pref_14 <= P_l1_14 and P_pref_13;

    -- carries
    
    C0  <= Cin;
    C1  <= G_pref_0  or (P_pref_0  and Cin); 
    C2  <= G_pref_1  or (P_pref_1  and Cin);
    C3  <= G_pref_2  or (P_pref_2  and Cin);
    C4  <= G_pref_3  or (P_pref_3  and Cin);
    C5  <= G_pref_4  or (P_pref_4  and Cin);
    C6  <= G_pref_5  or (P_pref_5  and Cin);
    C7  <= G_pref_6  or (P_pref_6  and Cin);
    C8  <= G_pref_7  or (P_pref_7  and Cin);
    C9  <= G_pref_8  or (P_pref_8  and Cin);
    C10 <= G_pref_9  or (P_pref_9  and Cin);
    C11 <= G_pref_10 or (P_pref_10 and Cin);
    C12 <= G_pref_11 or (P_pref_11 and Cin);
    C13 <= G_pref_12 or (P_pref_12 and Cin);
    C14 <= G_pref_13 or (P_pref_13 and Cin);
    C15 <= G_pref_14 or (P_pref_14 and Cin);

    -- sum bits
    SUM(0)  <= p0  xor C0;
    SUM(1)  <= p1  xor C1;
    SUM(2)  <= p2  xor C2;
    SUM(3)  <= p3  xor C3;
    SUM(4)  <= p4  xor C4;
    SUM(5)  <= p5  xor C5;
    SUM(6)  <= p6  xor C6;
    SUM(7)  <= p7  xor C7;
    SUM(8)  <= p8  xor C8;
    SUM(9)  <= p9  xor C9;
    SUM(10) <= p10 xor C10;
    SUM(11) <= p11 xor C11;
    SUM(12) <= p12 xor C12;
    SUM(13) <= p13 xor C13;
    SUM(14) <= p14 xor C14;

    Cout <= C15; -- final carry out

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

COMPONENT brent_kung_15 is
    port (
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

ENTITY compressor_8x2_16b_Brent_Kung IS
PORT ( a, b, c, d, e, f, g, h : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0)
	  );
END compressor_8x2_16b_Brent_Kung; 

ARCHITECTURE behavior OF compressor_8x2_16b_Brent_Kung IS

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

stage16: brent_kung_15 port map (carrya(14 downto 0), suma, '0', sum(15 downto 1), Coutab);

stage17: compressor52 port map (coutp0, coutp1, coutp2, coutp3, coutp4, carrya(15), Coutab, coutda2, coutda1, sum(16), carryda);
stage18: fulladder_a port map (carryda, coutda2, coutda1, sum(18), sum(17)); 

END behavior;
