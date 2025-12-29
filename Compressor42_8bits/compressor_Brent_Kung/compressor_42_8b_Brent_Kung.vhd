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

    -- Sinais intermediários para a árvore Brent–Kung
    signal G1, P1 : std_logic_vector(7 downto 0);
    signal G2, P2 : std_logic_vector(7 downto 0);
    signal G3, P3 : std_logic_vector(7 downto 0);

    -- Carries finais de cada posição
    signal C : std_logic_vector(8 downto 0);

begin

    --------------------------------------------------------------------
    -- 1) Propagate e Generate individuais
    --------------------------------------------------------------------
    P <= A xor B;
    G <= A and B;

    C(0) <= Cin;

    --------------------------------------------------------------------
    -- 2) Primeira camada (nível 1) — prefixos de 2 bits
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
    -- 3) Segunda camada (nível 2) — prefixos de 4 bits
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
    -- 4) Terceira camada (nível 3) — prefixos de 8 bits
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
    -- 5) Distribuição das carries finais
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

ENTITY compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END compressor_4entradas;

ARCHITECTURE comportamento OF compressor_4entradas IS

SIGNAL  out_xor1, out_xor2, out_xor3, out_xor4 :  STD_LOGIC;
SIGNAL	out_mux1, out_mux2 : STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	out_xor2 <= C XOR D;

	out_xor3 <= out_xor1 XOR out_xor2;

	out_xor4 <= Cin XOR out_xor3;
				
    s0: mux_1bit PORT MAP (A, C, out_mux1, out_xor1);
			
    s1: mux_1bit PORT MAP (D, Cin, out_mux2, out_xor3);
	
    Sum <= out_xor4;
	Carry <= out_mux2;
	Cout <= out_mux1;
	 	
END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components1 IS

COMPONENT compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

END my_components1;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY compressor_42_8b_Brent_Kung IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	  );

END compressor_42_8b_Brent_Kung;

ARCHITECTURE comportamento OF compressor_42_8b_Brent_Kung IS

SIGNAL cout, carry: STD_LOGIC_VECTOR (7 downto 0); 
SIGNAL sum: STD_LOGIC_VECTOR (7 downto 1);
SIGNAL COUTa: STD_LOGIC;

BEGIN

comp42_num0: compressor_4entradas PORT MAP(A(0), B(0), C(0), D(0), '0', cout(0), carry(0), SOMA(0));
					
comp42_num1: compressor_4entradas PORT MAP(A(1), B(1), C(1), D(1), cout(0), cout(1), carry(1), sum(1));
			
comp42_num2: compressor_4entradas PORT MAP(A(2), B(2), C(2), D(2), cout(1), cout(2), carry(2), sum(2));
								
comp42_num3: compressor_4entradas PORT MAP(A(3), B(3), C(3), D(3), cout(2), cout(3), carry(3), sum(3));

comp42_num4: compressor_4entradas PORT MAP(A(4), B(4), C(4), D(4), cout(3), cout(4), carry(4), sum(4));

comp42_num5: compressor_4entradas PORT MAP(A(5), B(5), C(5), D(5), cout(4), cout(5), carry(5), sum(5));

comp42_num6: compressor_4entradas PORT MAP(A(6), B(6), C(6), D(6), cout(5), cout(6), carry(6), sum(6));

comp42_num7: compressor_4entradas PORT MAP(A(7), B(7), C(7), D(7), cout(6), cout(7), carry(7), sum(7));
			

--------------------------------------------------------------------------------------------	

var0: brent_kung_adder8 PORT MAP(carry, (cout(7) & sum), '0', SOMA(8 downto 1), SOMA(9));

END comportamento;
