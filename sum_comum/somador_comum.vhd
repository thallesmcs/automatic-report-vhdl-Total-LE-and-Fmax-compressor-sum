library ieee;
use ieee.std_logic_1164.all;

entity somador_comum is
	port (
		a    : in  std_logic_vector(3 downto 0);
		b    : in  std_logic_vector(3 downto 0);
		s    : out std_logic_vector(3 downto 0);
		cout : out std_logic
	);
end entity somador_comum;

architecture soma of somador_comum is
	signal cin: std_logic_vector(3 downto 0);
begin
	cin(0) <= '0';
	s(0)   <= a(0) xor b(0) xor cin(0);
	cin(1) <= (a(0) and b(0)) or (a(0) and cin(0)) or (b(0) and cin(0));
	s(1)   <= a(1) xor b(1) xor cin(1);
	cin(2) <= (a(1) and b(1)) or (a(1) and cin(1)) or (b(1) and cin(1));
	s(2)   <= a(2) xor b(2) xor cin(2);
	cin(3) <= (a(2) and b(2)) or (a(2) and cin(2)) or (b(2) and cin(2));
	s(3)   <= a(3) xor b(3) xor cin(3);
	cout   <= (a(3) and b(3)) or (a(3) and cin(3)) or (b(3) and cin(3));
end architecture soma;