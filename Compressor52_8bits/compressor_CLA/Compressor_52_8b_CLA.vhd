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

entity cla_7bit is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of cla_7bit is

    -- sinais de propagate e generate
    signal P0, P1, P2, P3, P4, P5, P6 : std_logic;
    signal G0, G1, G2, G3, G4, G5, G6 : std_logic;

    -- carries internos
    signal C1, C2, C3, C4, C5, C6, C7 : std_logic;

begin

    -------------------------------------------------------
    -- Propagate e Generate
    -------------------------------------------------------
    P0 <= A(0) xor B(0);
    P1 <= A(1) xor B(1);
    P2 <= A(2) xor B(2);
    P3 <= A(3) xor B(3);
    P4 <= A(4) xor B(4);
    P5 <= A(5) xor B(5);
    P6 <= A(6) xor B(6);

    G0 <= A(0) and B(0);
    G1 <= A(1) and B(1);
    G2 <= A(2) and B(2);
    G3 <= A(3) and B(3);
    G4 <= A(4) and B(4);
    G5 <= A(5) and B(5);
    G6 <= A(6) and B(6);

    -------------------------------------------------------
    -- Look-Ahead Carry logic 
    -------------------------------------------------------

    C1 <= G0 or (P0 and Cin);

    C2 <= G1 or (P1 and G0) or (P1 and P0 and Cin);

    C3 <= G2 or (P2 and G1) or (P2 and P1 and G0) or
                 (P2 and P1 and P0 and Cin);

    C4 <= G3 or (P3 and G2) or (P3 and P2 and G1) or
                 (P3 and P2 and P1 and G0) or
                 (P3 and P2 and P1 and P0 and Cin);

    C5 <= G4 or (P4 and C4);

    C6 <= G5 or (P5 and G4) or (P5 and P4 and C4);

    C7 <= G6 or (P6 and G5) or (P6 and P5 and G4) or
                 (P6 and P5 and P4 and C4);

    -------------------------------------------------------
    -- Somadores finais
    -------------------------------------------------------
    SUM(0) <= P0 xor Cin;
    SUM(1) <= P1 xor C1;
    SUM(2) <= P2 xor C2;
    SUM(3) <= P3 xor C3;
    SUM(4) <= P4 xor C4;
    SUM(5) <= P5 xor C5;
    SUM(6) <= P6 xor C6;

    Cout <= C7;

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

COMPONENT cla_7bit is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
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

ENTITY Compressor_52_8b_CLA IS
PORT ( 
	   a, b, c, d, e : IN  STD_LOGIC_vector(7 downto 0);
	   sum           : OUT STD_LOGIC_vector(10 downto 0) 
	 );
END Compressor_52_8b_CLA; 

ARCHITECTURE behavior OF Compressor_52_8b_CLA IS

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

comp8: cla_7bit port map (carrys(6 downto 0), sums(7 downto 1), '0', sum(7 downto 1), Couta);
comp15: compressor_4entradas1 port map (cout11(7), cout22(7), carrys(7), COUTa, '0', temp1, temp0, sum(8));
comp16: halfadder1a port map (temp1, temp0, sum(10), sum(9)); 

END behavior;