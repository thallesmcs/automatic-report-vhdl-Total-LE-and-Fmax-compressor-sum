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

COMPONENT carry_select_7 is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end  COMPONENT;

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

ENTITY Compressor_52_8b_Carry_Select IS
PORT ( 
	   a, b, c, d, e : IN  STD_LOGIC_vector(7 downto 0);
	   sum           : OUT STD_LOGIC_vector(10 downto 0) 
	 );
END Compressor_52_8b_Carry_Select; 

ARCHITECTURE behavior OF Compressor_52_8b_Carry_Select IS

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

comp8: carry_select_7 port map (carrys(6 downto 0), sums(7 downto 1), '0', sum(7 downto 1), Couta);
comp15: compressor_4entradas1 port map (cout11(7), cout22(7), carrys(7), COUTa, '0', temp1, temp0, sum(8));
comp16: halfadder1a port map (temp1, temp0, sum(10), sum(9)); 

END behavior;