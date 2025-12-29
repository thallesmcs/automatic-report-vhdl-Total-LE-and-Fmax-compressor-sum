--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--============================================================
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

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

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
    port(
        A, B, Cin : in  std_logic;
        Sum       : out std_logic;
        Cout      : out std_logic
    );
end entity;

architecture rtl of full_adder is
begin
    Sum  <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT full_adder is
    port(
        A, B, Cin : in  std_logic;
        Sum       : out std_logic;
        Cout      : out std_logic
    );

end COMPONENT;

END my_components;

library IEEE;
use IEEE.std_logic_1164.all;
USE work.my_components.all;

entity ripple4 is
    port(
        A, B   : in  std_logic_vector(3 downto 0);
        Cin    : in  std_logic;
        Sum    : out std_logic_vector(3 downto 0);
        Cout   : out std_logic;
        Pgroup : out std_logic      -- propagate group
    );
end entity;

architecture rtl of ripple4 is
    signal c : std_logic_vector(4 downto 1);
    signal p : std_logic_vector(3 downto 0);
begin
    FA0: full_adder port map(A(0), B(0), Cin,  Sum(0), c(1));
    FA1: full_adder port map(A(1), B(1), c(1), Sum(1), c(2));
    FA2: full_adder port map(A(2), B(2), c(2), Sum(2), c(3));
    FA3: full_adder port map(A(3), B(3), c(3), Sum(3), c(4));

    Cout <= c(4);

    -- propagate bits
    p(0) <= A(0) xor B(0);
    p(1) <= A(1) xor B(1);
    p(2) <= A(2) xor B(2);
    p(3) <= A(3) xor B(3);

    -- grupo propaga se todos propagam
    Pgroup <= p(0) and p(1) and p(2) and p(3);
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;

PACKAGE my_components1 IS

COMPONENT ripple4 is
    port(
        A, B   : in  std_logic_vector(3 downto 0);
        Cin    : in  std_logic;
        Sum    : out std_logic_vector(3 downto 0);
        Cout   : out std_logic;
        Pgroup : out std_logic      -- propagate group
    );
end COMPONENT;

END my_components1;

library IEEE;
use IEEE.std_logic_1164.all;
USE work.my_components1.all;

entity carry_skip_8bit is
    port(
        A, B : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end carry_skip_8bit;

architecture rtl of carry_skip_8bit is
    signal c4        : std_logic;
    signal p_low     : std_logic;
    signal skip_cout : std_logic;
    Signal opena     : std_logic;
begin
    -- bloco inferior 4 bits
    LSB: ripple4 port map(A(3 downto 0), B(3 downto 0), Cin, Sum(3 downto 0), c4, p_low);

    -- lógica de skip: se todo grupo inferior propaga ? pular carry
    skip_cout <= Cin when p_low = '1' else c4;

    -- bloco superior 4 bits
    MSB: ripple4 port map(A(7 downto 4), B(7 downto 4), skip_cout, Sum(7 downto 4), Cout, opena);
end rtl;

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

PACKAGE my_components2 IS

COMPONENT compressor_4entradas IS
PORT (A, B, C, D, Cin: IN STD_LOGIC;
	  Cout, Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

COMPONENT carry_skip_8bit is
    port(
        A, B : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end COMPONENT;

END my_components2;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE work.my_components2.all;

ENTITY compressor_42_8b_Carry_Skip IS
PORT (
	  A, B, C, D: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	  SOMA: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	  );

END compressor_42_8b_Carry_Skip;

ARCHITECTURE comportamento OF compressor_42_8b_Carry_Skip IS

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

var0: carry_skip_8bit PORT MAP(carry, (cout(7) & sum), '0', SOMA(8 downto 1), SOMA(9));

--var1: HALF_ADDER PORT MAP(cout(7), COUTa, SOMA(9), SOMA(8));

END comportamento;
