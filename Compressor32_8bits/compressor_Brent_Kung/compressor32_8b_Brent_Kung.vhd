--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--============================================================
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END mux_1bit;

ARCHITECTURE comportamento OF mux_1bit IS
BEGIN
	
	WITH sel SELECT
	   
	   mux_out <=	a WHEN '0',
					b WHEN others;
					
END comportamento;

library ieee;
use ieee.std_logic_1164.all;

entity brent_kung_adder8 is
    port (
        A, B : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        S    : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end brent_kung_adder8;

architecture rtl of brent_kung_adder8 is

    -- Sinais de Propagate e Generate iniciais
    signal P : std_logic_vector(7 downto 0);
    signal G : std_logic_vector(7 downto 0);

    -- Sinais intermedi�rios para a �rvore Brent�Kung
    signal G1, P1 : std_logic_vector(7 downto 0);
    signal G2, P2 : std_logic_vector(7 downto 0);
    signal G3, P3 : std_logic_vector(7 downto 0);

    -- Carries finais de cada posi��o
    signal C : std_logic_vector(8 downto 0);

begin

    --------------------------------------------------------------------
    -- 1) Propagate e Generate individuais
    --------------------------------------------------------------------
    P <= A xor B;
    G <= A and B;

    C(0) <= Cin;

    --------------------------------------------------------------------
    -- 2) Primeira camada (n�vel 1) � prefixos de 2 bits
    --------------------------------------------------------------------
    G1(0) <= G(0);
    P1(0) <= P(0);

    G1(1) <= G(1) or (P(1) and G(0));
    P1(1) <= P(1) and P(0);

    G1(2) <= G(2);
    P1(2) <= P(2);

    G1(3) <= G(3) or (P(3) and G(2));
    P1(3) <= P(3) and P(2);

    G1(4) <= G(4);
    P1(4) <= P(4);

    G1(5) <= G(5) or (P(5) and G(4));
    P1(5) <= P(5) and P(4);

    G1(6) <= G(6);
    P1(6) <= P(6);

    G1(7) <= G(7) or (P(7) and G(6));
    P1(7) <= P(7) and P(6);


    --------------------------------------------------------------------
    -- 3) Segunda camada (n�vel 2) � prefixos de 4 bits
    --------------------------------------------------------------------
    G2(0) <= G1(0);     P2(0) <= P1(0);
    G2(1) <= G1(1);     P2(1) <= P1(1);

    G2(2) <= G1(2) or (P1(2) and G1(1));
    P2(2) <= P1(2) and P1(1);

    G2(3) <= G1(3) or (P1(3) and G1(1));
    P2(3) <= P1(3) and P1(1);

    G2(4) <= G1(4);     P2(4) <= P1(4);
    G2(5) <= G1(5);     P2(5) <= P1(5);

    G2(6) <= G1(6) or (P1(6) and G1(5));
    P2(6) <= P1(6) and P1(5);

    G2(7) <= G1(7) or (P1(7) and G1(5));
    P2(7) <= P1(7) and P1(5);


    --------------------------------------------------------------------
    -- 4) Terceira camada (n�vel 3) � prefixos de 8 bits
    --------------------------------------------------------------------
    G3(0) <= G2(0);     P3(0) <= P2(0);
    G3(1) <= G2(1);     P3(1) <= P2(1);
    G3(2) <= G2(2);     P3(2) <= P2(2);
    G3(3) <= G2(3);     P3(3) <= P2(3);

    G3(4) <= G2(4) or (P2(4) and G2(3));
    P3(4) <= P2(4) and P2(3);

    G3(5) <= G2(5) or (P2(5) and G2(3));
    P3(5) <= P2(5) and P2(3);

    G3(6) <= G2(6) or (P2(6) and G2(3));
    P3(6) <= P2(6) and P2(3);

    G3(7) <= G2(7) or (P2(7) and G2(3));
    P3(7) <= P2(7) and P2(3);


    --------------------------------------------------------------------
    -- 5) Distribui��o das carries finais
    --    C(i) = G_prefix(i-1) OR (P_prefix(i-1) AND Cin)
    --------------------------------------------------------------------
    C(1) <= G3(0) or (P3(0) and Cin);
    C(2) <= G3(1) or (P3(1) and Cin);
    C(3) <= G3(2) or (P3(2) and Cin);
    C(4) <= G3(3) or (P3(3) and Cin);
    C(5) <= G3(4) or (P3(4) and Cin);
    C(6) <= G3(5) or (P3(5) and Cin);
    C(7) <= G3(6) or (P3(6) and Cin);
    C(8) <= G3(7) or (P3(7) and Cin);


    --------------------------------------------------------------------
    -- 6) Soma final
    --------------------------------------------------------------------
    S(0) <= P(0) xor C(0);
    S(1) <= P(1) xor C(1);
    S(2) <= P(2) xor C(2);
    S(3) <= P(3) xor C(3);
    S(4) <= P(4) xor C(4);
    S(5) <= P(5) xor C(5);
    S(6) <= P(6) xor C(6);
    S(7) <= P(7) xor C(7);

    Cout <= C(8);

end rtl;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT brent_kung_adder8 is
    port (
        A, B : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        S    : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_components;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END compressor32;

ARCHITECTURE comportamento OF compressor32 IS

SIGNAL  out_xor1:  STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	Sum <= out_xor1 XOR C;
	
s0: mux_1bit
	  PORT MAP   (a => A,
				     b => C,
				     mux_out => Carry,
				     sel => out_xor1
				   );

END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components1 IS

COMPONENT compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY compressor32_8b_Brent_Kung IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	   );
END compressor32_8b_Brent_Kung;

ARCHITECTURE comportamento OF compressor32_8b_Brent_Kung IS

SIGNAL carry: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL sum: STD_LOGIC_VECTOR(7 DOWNTO 1);

BEGIN

    
-- Compressores 3:2 (CSA)
estagio0: compressor32 PORT MAP(A(0),B(0),C(0),carry(0),S(0));
estagio1: compressor32 PORT MAP(A(1),B(1),C(1),carry(1),sum(1));
estagio2: compressor32 PORT MAP(A(2),B(2),C(2),carry(2),sum(2));
estagio3: compressor32 PORT MAP(A(3),B(3),C(3),carry(3),sum(3));
estagio4: compressor32 PORT MAP(A(4),B(4),C(4),carry(4),sum(4));
estagio5: compressor32 PORT MAP(A(5),B(5),C(5),carry(5),sum(5));
estagio6: compressor32 PORT MAP(A(6),B(6),C(6),carry(6),sum(6));
estagio7: compressor32 PORT MAP(A(7),B(7),C(7),carry(7),sum(7));

var0: brent_kung_adder8 PORT MAP(carry, '0' & sum, '0', S(8 downto 1), S(9));

END comportamento;

					

