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
use ieee.numeric_std.all;

entity brent_kung_15 is
    port (
        A    : in  std_logic_vector(14 downto 0);
        B    : in  std_logic_vector(14 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(14 downto 0);
        Cout : out std_logic
    );
end brent_kung_15;

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

COMPONENT brent_kung_15 is
    port (
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

ENTITY Compressor_52_16b_Brent_Kung IS
PORT ( 
	   a, b, c, d, e : IN  STD_LOGIC_vector(15 downto 0);
	   sum           : OUT STD_LOGIC_vector(18 downto 0) 
	 );
END Compressor_52_16b_Brent_Kung; 

ARCHITECTURE behavior OF Compressor_52_16b_Brent_Kung IS

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

comp16: brent_kung_15 port map (carrys(14 downto 0), sums(15 downto 1), '0', sum(15 downto 1), Couta);
comp17: compressor_4entradas1 port map (cout11(15), cout22(15), carrys(15), Couta, '0', temp1, temp0, sum(16));
comp18: halfadder1a port map (temp1, temp0, sum(18), sum(17)); 

END behavior;