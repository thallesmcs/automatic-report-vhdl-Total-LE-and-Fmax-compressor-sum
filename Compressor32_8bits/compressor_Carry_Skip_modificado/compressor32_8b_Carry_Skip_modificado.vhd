--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--

--Modificado por Schivittz 
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
	 signal c4, s_cout        : std_logic;
    signal p_low     : std_logic;
    signal skip_cout : std_logic;
    Signal prop_msb  : std_logic;
begin
    -- bloco inferior 4 bits
    LSB: ripple4 port map(A(3 downto 0), B(3 downto 0), Cin, Sum(3 downto 0), c4, p_low);

    -- l�gica de skip: se todo grupo inferior propaga ? pular carry
    skip_cout <= Cin when p_low = '1' else c4;

    -- bloco superior 4 bits
    MSB: ripple4 port map(A(7 downto 4), B(7 downto 4), skip_cout, Sum(7 downto 4), s_cout, prop_msb);
	 
	 -- l�gica de skip do cout da sa�da: se todo grupo inferior propaga ? pular carry
	 cout <= skip_cout when prop_msb = '1' else s_cout;
	 
	 
end rtl;

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

PACKAGE my_components2 IS

COMPONENT compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

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

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components2.all;

ENTITY compressor32_8b_Carry_Skip IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	   );
END compressor32_8b_Carry_Skip;

ARCHITECTURE comportamento OF compressor32_8b_Carry_Skip IS

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

var0: carry_skip_8bit PORT MAP(carry, '0' & sum, '0', S(8 downto 1), S(9));

END comportamento;

					

