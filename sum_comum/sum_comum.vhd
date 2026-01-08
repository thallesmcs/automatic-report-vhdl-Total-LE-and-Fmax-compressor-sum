library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Somador generico para N operandos de mesma largura.
entity sum_comum is
  generic (
    N_INPUTS  : positive := 7;
    WIDTH     : positive := 8;
    SUM_WIDTH : positive := 11  -- garanta largura suficiente para o maior valor
  );
  port (
    din : in  std_logic_vector(N_INPUTS * WIDTH - 1 downto 0);
    S   : out std_logic_vector(SUM_WIDTH - 1 downto 0)
  );
end entity sum_comum;

architecture rtl of sum_comum is
begin
  -- Soma direta, fatiando o barramento achatado.
  process (din)
    variable acc : unsigned(SUM_WIDTH - 1 downto 0);
  begin
    acc := (others => '0');

    for i in 0 to N_INPUTS - 1 loop
      acc := acc + resize(
        unsigned(din((i + 1) * WIDTH - 1 downto i * WIDTH)),
        SUM_WIDTH
      );
    end loop;

    S <= std_logic_vector(acc);
  end process;
end architecture rtl;
