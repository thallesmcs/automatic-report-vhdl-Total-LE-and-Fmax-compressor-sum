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

entity sklansky_8 is
    port (
        A    : in  std_logic_vector(7 downto 0);
        B    : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end entity;

architecture rtl of sklansky_8 is

    -- par G,P
    type gp_t is record
        g : std_logic;
        p : std_logic;
    end record;

    -- função prefix combine
    function combine(left, right : gp_t) return gp_t is
        variable r : gp_t;
    begin
        r.g := left.g or (left.p and right.g);
        r.p := left.p and right.p;
        return r;
    end function;

    -- nível 0 (G,P individuais)
    signal g0_0, g0_1, g0_2, g0_3, g0_4, g0_5, g0_6, g0_7 : std_logic;
    signal p0_0, p0_1, p0_2, p0_3, p0_4, p0_5, p0_6, p0_7 : std_logic;

    -- nível 1 (combine de pares)
    signal gp1_1, gp1_3, gp1_5, gp1_7 : gp_t;

    -- nível 2 (combine grupos de 4)
    signal gp2_2, gp2_3, gp2_6, gp2_7 : gp_t;

    -- nível 3 (combine grupos de 8)
    signal gp3_4, gp3_5, gp3_6, gp3_7 : gp_t;

    -- carries
    signal c1, c2, c3, c4, c5, c6, c7 : std_logic;

begin

    --------------------------------------------------------------------
    --  NÍVEL 0 – sinais G e P básicos
    --------------------------------------------------------------------
    g0_0 <= A(0) and B(0);     p0_0 <= A(0) xor B(0);
    g0_1 <= A(1) and B(1);     p0_1 <= A(1) xor B(1);
    g0_2 <= A(2) and B(2);     p0_2 <= A(2) xor B(2);
    g0_3 <= A(3) and B(3);     p0_3 <= A(3) xor B(3);
    g0_4 <= A(4) and B(4);     p0_4 <= A(4) xor B(4);
    g0_5 <= A(5) and B(5);     p0_5 <= A(5) xor B(5);
    g0_6 <= A(6) and B(6);     p0_6 <= A(6) xor B(6);
    g0_7 <= A(7) and B(7);     p0_7 <= A(7) xor B(7);

    --------------------------------------------------------------------
    --  NÍVEL 1 – combine pares
    --------------------------------------------------------------------
    gp1_1 <= combine( (g0_1, p0_1), (g0_0, p0_0) );
    gp1_3 <= combine( (g0_3, p0_3), (g0_2, p0_2) );
    gp1_5 <= combine( (g0_5, p0_5), (g0_4, p0_4) );
    gp1_7 <= combine( (g0_7, p0_7), (g0_6, p0_6) );

    --------------------------------------------------------------------
    --  NÍVEL 2 – combine grupos de 4 
    --------------------------------------------------------------------
    gp2_2 <= combine( (g0_2, p0_2), gp1_1 );
    gp2_3 <= combine( gp1_3,       gp1_1 );
    gp2_6 <= combine( (g0_6, p0_6), gp1_5 );
    gp2_7 <= combine( gp1_7,       gp1_5 );

    --------------------------------------------------------------------
    --  NÍVEL 3 – combine grupos de 8 
    --------------------------------------------------------------------
    gp3_4 <= combine( (g0_4, p0_4), gp2_3 );
    gp3_5 <= combine( (g0_5, p0_5), gp2_3 );
    gp3_6 <= combine( gp2_6,        gp2_3 );
    gp3_7 <= combine( gp2_7,        gp2_3 );

    --------------------------------------------------------------------
    --  CARRIES
    --------------------------------------------------------------------
    -- carry(0) = Cin
    c1 <= g0_0 or (p0_0 and Cin);       -- carry into bit1
    c2 <= gp1_1.g or (gp1_1.p and Cin); -- carry into bit2
    c3 <= gp2_2.g or (gp2_2.p and Cin); -- carry into bit3
    c4 <= gp2_3.g or (gp2_3.p and Cin); -- carry into bit4
    c5 <= gp3_4.g or (gp3_4.p and Cin); -- carry into bit5
    c6 <= gp3_5.g or (gp3_5.p and Cin); -- carry into bit6
    c7 <= gp3_6.g or (gp3_6.p and Cin); -- carry into bit7

    --------------------------------------------------------------------
    --  SOMA
    --------------------------------------------------------------------
    SUM(0) <= p0_0 xor Cin;
    SUM(1) <= p0_1 xor c1;
    SUM(2) <= p0_2 xor c2;
    SUM(3) <= p0_3 xor c3;
    SUM(4) <= p0_4 xor c4;
    SUM(5) <= p0_5 xor c5;
    SUM(6) <= p0_6 xor c6;
    SUM(7) <= p0_7 xor c7;

    --------------------------------------------------------------------
    --  CARRY OUT
    --------------------------------------------------------------------
    Cout <= gp3_7.g or (gp3_7.p and Cin);

end architecture;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT sklansky_8 is
    port (
        A    : in  std_logic_vector(7 downto 0);
        B    : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        SUM  : out std_logic_vector(7 downto 0);
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

ENTITY compressor_42_8b_Sklansky IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	  );

END compressor_42_8b_Sklansky;

ARCHITECTURE comportamento OF compressor_42_8b_Sklansky IS

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

var0: sklansky_8 PORT MAP(carry, (cout(7) & sum), '0', SOMA(8 downto 1), SOMA(9));

END comportamento;
