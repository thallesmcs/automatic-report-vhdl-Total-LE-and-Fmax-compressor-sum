library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_compressor_7x2_8b is
end entity tb_compressor_7x2_8b;

architecture tb of tb_compressor_7x2_8b is
  -- Ajuste aqui para cada arquitetura: largura, numero de entradas e tamanho da soma.
  constant WIDTH      : natural := 8;   -- 8 ou 16
  constant N_INPUTS   : natural := 7;   -- 3,4,5,7,8, etc.
  constant SUM_WIDTH  : natural := 11;  -- deve comportar N_INPUTS * (2^WIDTH - 1)
  constant N_TESTS    : natural := 200;
  constant MAX_INPUTS : natural := 8;   -- numero maximo suportado aqui
  constant PRINT_FIRST: natural := 50;  -- quantos vetores iniciais exibir

  type vec_array_t is array (natural range <>) of std_logic_vector(WIDTH - 1 downto 0);

  signal din_arr    : vec_array_t(0 to MAX_INPUTS - 1);
  signal uut_sum    : std_logic_vector(SUM_WIDTH - 1 downto 0);
  signal golden_sum : std_logic_vector(SUM_WIDTH - 1 downto 0);
  signal din_flat   : std_logic_vector(N_INPUTS * WIDTH - 1 downto 0);

  -- Sinais nomeados para facilitar o port map dos DUTs atuais (ate 8 entradas).
  signal a, b, c, d, e, f, g, h : std_logic_vector(WIDTH - 1 downto 0);
begin
  -- Achata o vetor din_arr para o somador de referencia.
  gen_flat: for i in 0 to N_INPUTS - 1 generate
    din_flat((i + 1) * WIDTH - 1 downto i * WIDTH) <= din_arr(i);
  end generate;

  -- Liga os primeiros elementos do array a sinais nomeados (ajude no port map).
  a <= din_arr(0);
  b <= din_arr(1) when N_INPUTS > 1 else (others => '0');
  c <= din_arr(2) when N_INPUTS > 2 else (others => '0');
  d <= din_arr(3) when N_INPUTS > 3 else (others => '0');
  e <= din_arr(4) when N_INPUTS > 4 else (others => '0');
  f <= din_arr(5) when N_INPUTS > 5 else (others => '0');
  g <= din_arr(6) when N_INPUTS > 6 else (others => '0');
  h <= din_arr(7) when N_INPUTS > 7 else (others => '0');

  -- UUT: ajuste o entity/port map conforme a arquitetura sob teste.
  uut: entity work.compressor_7x2_8b_Carry_Select
    port map (
      a   => a,
      b   => b,
      c   => c,
      d   => d,
      e   => e,
      f   => f,
      g   => g,
      sum => uut_sum
    );

  golden: entity work.sum_comum
    generic map (
      N_INPUTS  => N_INPUTS,
      WIDTH     => WIDTH,
      SUM_WIDTH => SUM_WIDTH
    )
    port map (
      din => din_flat,
      S   => golden_sum
    );

  stimulus: process
    variable seed1 : positive := 101;
    variable seed2 : positive := 77;
    variable randv : real;
    variable val   : integer;
  begin
    for t in 1 to N_TESTS loop
      for i in 0 to N_INPUTS - 1 loop
        uniform(seed1, seed2, randv);
        val := integer(floor(randv * real(2 ** WIDTH)));
        din_arr(i) <= std_logic_vector(to_unsigned(val, WIDTH));
      end loop;

      wait for 1 ns;  -- tempo para propagacao combinacional

      if t <= PRINT_FIRST then
        report "t=" & integer'image(t) &
               " A=" & integer'image(to_integer(unsigned(a))) &
               " B=" & integer'image(to_integer(unsigned(b))) &
               " C=" & integer'image(to_integer(unsigned(c))) &
               " D=" & integer'image(to_integer(unsigned(d))) &
               " E=" & integer'image(to_integer(unsigned(e))) &
               " F=" & integer'image(to_integer(unsigned(f))) &
               " G=" & integer'image(to_integer(unsigned(g))) &
               " UUT=" & integer'image(to_integer(unsigned(uut_sum))) &
               " REF=" & integer'image(to_integer(unsigned(golden_sum)))
          severity note;
      end if;

      assert uut_sum = golden_sum
        report "Mismatch no teste " & integer'image(t) &
               " esperado=" & integer'image(to_integer(unsigned(golden_sum))) &
               " obtido=" & integer'image(to_integer(unsigned(uut_sum)))
        severity error;
    end loop;

    report "Todos os " & integer'image(N_TESTS) & " vetores passaram." severity note;
    wait;
  end process;
end architecture tb;
