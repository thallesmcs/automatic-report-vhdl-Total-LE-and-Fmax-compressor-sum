library ieee;
use ieee.std_logic_1164.all;

Entity Mux21ab is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
end Mux21ab;
Architecture circuito of Mux21ab is

begin 

 with sel select 
	y <= a when '0',
		  b when others;
		  
end circuito;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY half_adder_a IS

PORT (a, b 	       : IN STD_LOGIC;
	  cout, s 		: OUT STD_LOGIC
     );
END half_adder_a;

ARCHITECTURE soma OF half_adder_a IS
BEGIN

s    <= a XOR b ;
cout <= a AND b;

END soma;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder_a IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END full_adder_a;

ARCHITECTURE comportamento OF full_adder_a IS

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

entity cgen is
   port(
      in1, in2, in3  : in  std_logic;
      CGEN           : out std_logic
   );
end cgen;

architecture arq of cgen is
begin

   CGEN <= ((in2 or in3) and in1) or (in2 and in3);

end arq;

library ieee;
use ieee.std_logic_1164.all;

entity carry_skip_7 is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of carry_skip_7 is

    -- sinais ripple do bloco 0 (bits 0–3)
    signal P0, P1, P2, P3 : std_logic;
    signal G0, G1, G2, G3 : std_logic;
    signal C1, C2, C3, C4 : std_logic;
    signal B0_prop         : std_logic;

    -- sinais ripple do bloco 1 (bits 4–6)
    signal P4, P5, P6 : std_logic;
    signal G4, G5, G6 : std_logic;
    signal C5, C6, C7 : std_logic;
    signal B1_prop     : std_logic;

    signal carry_mid : std_logic;

begin
    ----------------------------------------------------------
    -- PROPAGATE / GENERATE individuais
    ----------------------------------------------------------
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

    ----------------------------------------------------------
    -- BLOCO 0 — Ripple (0–3)
    ----------------------------------------------------------
    C1 <= G0 or (P0 and Cin);
    C2 <= G1 or (P1 and C1);
    C3 <= G2 or (P2 and C2);
    C4 <= G3 or (P3 and C3);

    -- Propagação total do bloco 0
    B0_prop <= P0 and P1 and P2 and P3;

    -- Carry que vai para o próximo bloco 
    carry_mid <= C4 when B0_prop = '0'
                 else Cin;

    ----------------------------------------------------------
    -- BLOCO 1 — Ripple (4–6)
    ----------------------------------------------------------
    C5 <= G4 or (P4 and carry_mid);
    C6 <= G5 or (P5 and C5);
    C7 <= G6 or (P6 and C6);

    -- Propagação total bloco 1
    B1_prop <= P4 and P5 and P6;

    ----------------------------------------------------------
    -- Soma final dos bits
    ----------------------------------------------------------
    SUM(0) <= P0 xor Cin;
    SUM(1) <= P1 xor C1;
    SUM(2) <= P2 xor C2;
    SUM(3) <= P3 xor C3;

    SUM(4) <= P4 xor carry_mid;
    SUM(5) <= P5 xor C5;
    SUM(6) <= P6 xor C6;

    ----------------------------------------------------------
    -- Carry de saída (skip final)
    ----------------------------------------------------------
    Cout <= C7 when B1_prop = '0'
            else carry_mid;

end architecture;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

PACKAGE my_componentsa1 IS

COMPONENT Mux21ab is 
port( 
a, b, sel 	: in std_logic;
y 				: out std_logic	
);
END COMPONENT;

COMPONENT half_adder_a IS

PORT (a, b 	       : IN STD_LOGIC;
	  cout, s 		: OUT STD_LOGIC
     );
END COMPONENT;

COMPONENT full_adder_a IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cgen is
   port(
      in1, in2, in3  : in  std_logic;
      CGEN           : out std_logic
   );
end COMPONENT;

COMPONENT carry_skip_7 is
    port (
        A    : in  std_logic_vector(6 downto 0);
        B    : in  std_logic_vector(6 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(6 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_componentsa1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsa1.all;

ENTITY compressor_4entradas1 IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
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
				
    s0: Mux21ab PORT MAP (A, C, out_xor1, out_mux1);
			
    s1: Mux21ab PORT MAP (D, Cin, out_xor3, out_mux2);
	
    Sum <= out_xor4;
	Carry <= out_mux2;
	Cout <= out_mux1;
	 	
END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsa1.all;

Entity compressor_7entradas1a is 
	port( 
		a, b, c, d, e, f, g, cin1, cin2: in std_logic;
		cout1, cout2, sum, carry: out std_logic	
		);
end compressor_7entradas1a;

Architecture circuito of compressor_7entradas1a is

 ---- SINAIS ----
   signal c1, c2, c3 : std_logic;
   signal s1, s2, s3, s4, s5 : std_logic;
begin


   cgen1: cgen port map(in1 => b, in2 => c, in3 => d, CGEN => c1);
   cgen2: cgen port map(in1 => e, in2 => f, in3 => g, CGEN => c2);
   cgen3: cgen port map(in1 => a, in2 => s1, in3 => s2, CGEN => c3);

   s1 <= (b xor c) xor d;
   s2 <= (e xor f) xor g;
   s3 <= c1 xor c2;
   s4 <= a xor (s1 xor s2);
   s5 <= s4 xor cin2;

   sum <= s5 xor cin1;
	
   carry <= s4   when s5 = '0' else
            cin1 when s5 = '1';

   cout1 <= s3 xor c3;

   cout2 <= c1 when s3 = '0' else
            c3 when s3 = '1';

END circuito;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_componentsb1 IS

COMPONENT compressor_4entradas1 IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

COMPONENT compressor_7entradas1a IS
port (A, B, C, D, E, F, G, cin1, cin2: in std_logic;
		cout1, cout2, sum, carry: out std_logic	
		);
end COMPONENT;

END my_componentsb1;

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE work.my_componentsa1.all;
USE work.my_componentsb1.all;

ENTITY compressor_7x2_8b_Carry_Skip IS
PORT ( a, b, c, d, e, f, g : IN  STD_LOGIC_vector(7 downto 0);
	   sum           : OUT STD_LOGIC_vector(10 downto 0)
	  );
END compressor_7x2_8b_Carry_Skip; 

ARCHITECTURE behavior OF compressor_7x2_8b_Carry_Skip IS

SIGNAL couta0, couta1, couta2, couta3, couta4, couta5, couta6, couta7, couta8, couta9, 
couta10, couta11, couta12, couta13, couta14, couta15: STD_LOGIC;
signal COUTa, temp1, temp0: STD_LOGIC;
signal carrya : STD_LOGIC_vector(7 downto 0); 
signal suma : STD_LOGIC_vector(6 downto 0); 
signal saidaparcial	: STD_LOGIC_vector(7 downto 0); 
signal saidaparcial1	: STD_LOGIC_vector(8 downto 1); 
BEGIN

stage_0: compressor_7entradas1a port map (a(0), b(0), c(0), d(0), e(0), f(0), g(0), '0', '0', couta0, couta1, sum(0), carrya(0));
stage_1: compressor_7entradas1a port map (a(1), b(1), c(1), d(1), e(1), f(1), g(1), couta0, '0', couta2, couta3, suma(0), carrya(1));
stage_2: compressor_7entradas1a port map (a(2), b(2), c(2), d(2), e(2), f(2), g(2), couta1, couta2, couta4, couta5, suma(1), carrya(2));
stage_3: compressor_7entradas1a port map (a(3), b(3), c(3), d(3), e(3), f(3), g(3), couta3, couta4, couta6, couta7, suma(2), carrya(3));
stage_4: compressor_7entradas1a port map (a(4), b(4), c(4), d(4), e(4), f(4), g(4), couta5, couta6, couta8, couta9, suma(3), carrya(4));
stage_5: compressor_7entradas1a port map (a(5), b(5), c(5), d(5), e(5), f(5), g(5), couta7, couta8, couta10, couta11, suma(4), carrya(5));
stage_6: compressor_7entradas1a port map (a(6), b(6), c(6), d(6), e(6), f(6), g(6), couta9, couta10, couta12, couta13, suma(5), carrya(6));
stage_7: compressor_7entradas1a port map (a(7), b(7), c(7), d(7), e(7), f(7), g(7), couta11, couta12, couta14, couta15, suma(6), carrya(7));

comp8: carry_skip_7 port map (carrya(6 downto 0), suma, '0', sum(7 downto 1), Couta);

stage_15: compressor_4entradas1 port map (couta13, carrya(7), couta14, '0', Couta, temp1, temp0, sum(8));
stage_16: full_adder_a port map (couta15, temp1, temp0, sum(10), sum(9));

END behavior;  
