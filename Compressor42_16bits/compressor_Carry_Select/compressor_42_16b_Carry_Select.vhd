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

-------------------------------------------------------------------
-- Somador Ripple-Carry de 4 bits
-------------------------------------------------------------------

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity rca4 is
    Port (
        A  : in  STD_LOGIC_VECTOR(3 downto 0);
        B  : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin: in  STD_LOGIC;
        S  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC
    );
end rca4;

architecture behavioral of rca4 is
    signal c1, c2, c3: STD_LOGIC;
begin
    -- bit 0
    S(0) <= A(0) xor B(0) xor Cin;
    c1   <= (A(0) and B(0)) or (A(0) and Cin) or (B(0) and Cin);

    -- bit 1
    S(1) <= A(1) xor B(1) xor c1;
    c2   <= (A(1) and B(1)) or (A(1) and c1) or (B(1) and c1);

    -- bit 2
    S(2) <= A(2) xor B(2) xor c2;
    c3   <= (A(2) and B(2)) or (A(2) and c2) or (B(2) and c2);

    -- bit 3
    S(3) <= A(3) xor B(3) xor c3;
    Cout <= (A(3) and B(3)) or (A(3) and c3) or (B(3) and c3);
end behavioral;


library IEEE;
use IEEE.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT rca4 is
    Port (
        A  : in  STD_LOGIC_VECTOR(3 downto 0);
        B  : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin: in  STD_LOGIC;
        S  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC
    );
end COMPONENT;

END my_components;

-------------------------------------------------------------------
-- Somador Carry-Select de 8 bits
-------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.my_components.all;

entity csa16 is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end csa16;

architecture RTL of csa16 is

    -- sinais para os blocos
signal S0, S1_0, S1_1, S2_0, S2_1, S3_0, S3_1 : STD_LOGIC_VECTOR(3 downto 0);
signal C0, C1_0, C1_1, C2_0, C2_1, C3_0, C3_1 : STD_LOGIC;

-- sinais adicionais usados na seleção
    signal C1, C2 : STD_LOGIC;

begin

    ------------------------------------------------------------------
    -- Bloco 0: bits 3..0 (usa Cin diretamente)
    ------------------------------------------------------------------
    B0: rca4 port map (A(3 downto 0), B(3 downto 0), Cin, S0, C0);

    ------------------------------------------------------------------
    -- Bloco 1: bits 7..4 (precomputação para Cin=0 e Cin=1)
    ------------------------------------------------------------------
    B1_0: rca4 port map (A(7 downto 4), B(7 downto 4), '0', S1_0, C1_0);

    B1_1: rca4 port map (A(7 downto 4), B(7 downto 4), '1', S1_1, C1_1);

    ------------------------------------------------------------------
    -- Bloco 2: bits 11..8
    ------------------------------------------------------------------
    B2_0: rca4 port map (A(11 downto 8), B(11 downto 8), '0', S2_0, C2_0);

    B2_1: rca4 port map (A(11 downto 8), B(11 downto 8), '1', S2_1, C2_1);

    ------------------------------------------------------------------
    -- Bloco 3: bits 15..12
    ------------------------------------------------------------------
    B3_0: rca4 port map (A(15 downto 12), B(15 downto 12), '0', S3_0, C3_0);

    B3_1: rca4 port map (A(15 downto 12), B(15 downto 12), '1', S3_1, C3_1);

    ------------------------------------------------------------------
    -- Multiplexação dos blocos
    ------------------------------------------------------------------
    Sum(3 downto 0) <= S0;

    Sum(7 downto 4) <= S1_0 when C0 = '0' else S1_1;
    C1              <= C1_0 when C0 = '0' else C1_1;

    Sum(11 downto 8) <= S2_0 when C1 = '0' else S2_1;
    C2               <= C2_0 when C1 = '0' else C2_1;

    Sum(15 downto 12) <= S3_0 when C2 = '0' else S3_1;
    Cout              <= C3_0 when C2 = '0' else C3_1;

end RTL;

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

COMPONENT csa16 is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end COMPONENT;

END my_components1;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_components1.all;

ENTITY compressor_42_16b_Carry_Select IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
	  );

END compressor_42_16b_Carry_Select;

ARCHITECTURE comportamento OF compressor_42_16b_Carry_Select IS

SIGNAL cout, carry: STD_LOGIC_VECTOR (15 downto 0); 
SIGNAL sum: STD_LOGIC_VECTOR (15 downto 1);
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

comp42_num8: compressor_4entradas PORT MAP(A(8), B(8), C(8), D(8), cout(7), cout(8), carry(8), sum(8));

comp42_num9: compressor_4entradas PORT MAP(A(9), B(9), C(9), D(9), cout(8), cout(9), carry(9), sum(9));

comp42_num10: compressor_4entradas PORT MAP(A(10), B(10), C(10), D(10), cout(9), cout(10), carry(10), sum(10));

comp42_num11: compressor_4entradas PORT MAP(A(11), B(11), C(11), D(11), cout(10), cout(11), carry(11), sum(11));

comp42_num12: compressor_4entradas PORT MAP(A(12), B(12), C(12), D(12), cout(11), cout(12), carry(12), sum(12));

comp42_num13: compressor_4entradas PORT MAP(A(13), B(13), C(13), D(13), cout(12), cout(13), carry(13), sum(13));

comp42_num14: compressor_4entradas PORT MAP(A(14), B(14), C(14), D(14), cout(13), cout(14), carry(14), sum(14));

comp42_num15: compressor_4entradas PORT MAP(A(15), B(15), C(15), D(15), cout(14), cout(15), carry(15), sum(15));
			
--------------------------------------------------------------------------------------------	

var0: csa16 PORT MAP(carry, (cout(15) & sum), '0', SOMA(16 downto 1), SOMA(17));

END comportamento;
