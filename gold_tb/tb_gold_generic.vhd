library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;

-- Testbench generico: le vetores de um arquivo (operandos + soma esperada) e compara
-- DUT (uut_sum) contra soma esperada e contra sum_comum (golden).
-- Ajuste as constantes abaixo e o port map do UUT para cada arquitetura.
entity tb_gold_generic is
end entity tb_gold_generic;

architecture tb of tb_gold_generic is
  -- CONFIGURACAO RAPIDA:
  --   WIDTH:     8 ou 16
  --   N_INPUTS:  3,4,5,7,8
  --   SUM_WIDTH: bits suficientes (ex.: 3*255=765 ->10; 8*65535~524280 ->20)
  --   GOLD_FILE_PATH: aponte para o arquivo correspondente (gold_vectors_X.txt)
  constant WIDTH        : natural := 8;   -- 8 ou 16
  constant N_INPUTS     : natural := 3;   -- 3,4,5,7,8
  constant SUM_WIDTH    : natural := 10;  -- 3*255 = 765 (10 bits)
  constant PRINT_FIRST  : natural := 50;
  constant USE_GOLD_FILE: boolean := true;
  constant GOLD_FILE_PATH: string := "../gold_tb/gold_vectors_3.txt";

  constant MAX_INPUTS   : natural := 8;
  type vec_array_t is array (natural range <>) of std_logic_vector(WIDTH - 1 downto 0);
  type int_array_t is array (natural range <>) of integer;

  signal in_arr     : vec_array_t(0 to MAX_INPUTS - 1);
  signal din_flat   : std_logic_vector(N_INPUTS * WIDTH - 1 downto 0);
  signal uut_sum    : std_logic_vector(SUM_WIDTH - 1 downto 0);
  signal golden_sum : std_logic_vector(SUM_WIDTH - 1 downto 0);

  -- Sinais nomeados para facilitar port map de ate 8 entradas.
  signal a, b, c, d, e, f, g, h : std_logic_vector(WIDTH - 1 downto 0);
begin
  -- Flatten para o somador de referencia.
  gen_flat: for i in 0 to N_INPUTS - 1 generate
    din_flat((i + 1) * WIDTH - 1 downto i * WIDTH) <= in_arr(i);
  end generate;

  -- Liga nos aliases (use no port map do UUT).
  a <= in_arr(0);
  b <= in_arr(1) when N_INPUTS > 1 else (others => '0');
  c <= in_arr(2) when N_INPUTS > 2 else (others => '0');
  d <= in_arr(3) when N_INPUTS > 3 else (others => '0');
  e <= in_arr(4) when N_INPUTS > 4 else (others => '0');
  f <= in_arr(5) when N_INPUTS > 5 else (others => '0');
  g <= in_arr(6) when N_INPUTS > 6 else (others => '0');
  h <= in_arr(7) when N_INPUTS > 7 else (others => '0');

  --------------------------------------------------------------------
  -- UUT: compressor 3->2 de 8 bits (Brent-Kung). Ajuste caso mude de DUT.
  --------------------------------------------------------------------
  uut: entity work.compressor32_8b_Carry_Skip_modificado
    port map (
      A => a,
      B => b,
      C => c,
      S => uut_sum
    );

  -- Golden de referencia.
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
    file fvec      : text;
    variable l     : line;
    variable ints  : int_array_t(0 to MAX_INPUTS); -- ult posicao eh expected
    variable t     : integer := 0;
    variable seed1 : positive := 101;
    variable seed2 : positive := 77;
    variable randv : real;
    variable val   : integer;
    variable msg   : line;
    variable had_error : boolean := false;
  begin
    if USE_GOLD_FILE then
      file_open(fvec, GOLD_FILE_PATH, read_mode);
      while not endfile(fvec) loop
        readline(fvec, l);
        for i in 0 to N_INPUTS loop  -- le N_INPUTS operandos + expected
          read(l, ints(i));
        end loop;
        t := t + 1;

        for i in 0 to N_INPUTS - 1 loop
          in_arr(i) <= std_logic_vector(to_unsigned(ints(i), WIDTH));
        end loop;

        wait for 1 ns;

        if t <= PRINT_FIRST then
          msg := null;
          write(msg, string'("t="));
          write(msg, t);
          write(msg, string'(" ops="));
          write(msg, ints(0)); write(msg, string'(" ")); write(msg, ints(1));
          if N_INPUTS >= 3 then write(msg, string'(" ")); write(msg, ints(2)); end if;
          if N_INPUTS >= 4 then write(msg, string'(" ")); write(msg, ints(3)); end if;
          if N_INPUTS >= 5 then write(msg, string'(" ")); write(msg, ints(4)); end if;
          if N_INPUTS >= 6 then write(msg, string'(" ")); write(msg, ints(5)); end if;
          if N_INPUTS >= 7 then write(msg, string'(" ")); write(msg, ints(6)); end if;
          if N_INPUTS >= 8 then write(msg, string'(" ")); write(msg, ints(7)); end if;
          write(msg, string'(" UUT=")); write(msg, to_integer(unsigned(uut_sum)));
          write(msg, string'(" REF=")); write(msg, to_integer(unsigned(golden_sum)));
          write(msg, string'(" EXPECT=")); write(msg, ints(N_INPUTS));
          report msg.all severity note;
        end if;

        if to_integer(unsigned(uut_sum)) /= ints(N_INPUTS) then
          had_error := true;
          report "Mismatch (arquivo) teste " & integer'image(t) &
                 " esperado=" & integer'image(ints(N_INPUTS)) &
                 " obtido=" & integer'image(to_integer(unsigned(uut_sum)))
            severity error;
        end if;

        if uut_sum /= golden_sum then
          had_error := true;
          report "Mismatch (golden) teste " & integer'image(t) &
                 " esperado=" & integer'image(to_integer(unsigned(golden_sum))) &
                 " obtido=" & integer'image(to_integer(unsigned(uut_sum)))
            severity error;
        end if;
      end loop;
      file_close(fvec);
      report "Todos os vetores do arquivo foram testados." severity note;
    else
      for t in 1 to 200 loop  -- fallback random
        for i in 0 to N_INPUTS - 1 loop
          uniform(seed1, seed2, randv);
          val := integer(floor(randv * real(2 ** WIDTH)));
          in_arr(i) <= std_logic_vector(to_unsigned(val, WIDTH));
        end loop;
        wait for 1 ns;

        if t <= PRINT_FIRST then
          report "t=" & integer'image(t) &
                 " UUT=" & integer'image(to_integer(unsigned(uut_sum))) &
                 " REF=" & integer'image(to_integer(unsigned(golden_sum)))
            severity note;
        end if;

        if uut_sum /= golden_sum then
          had_error := true;
          report "Mismatch (golden) teste " & integer'image(t) &
                 " esperado=" & integer'image(to_integer(unsigned(golden_sum))) &
                 " obtido=" & integer'image(to_integer(unsigned(uut_sum)))
            severity error;
        end if;
      end loop;
      report "Todos os vetores aleatorios passaram." severity note;
    end if;

    if had_error then
      report "TESTE CONCLUIDO: ERROS DETECTADOS." severity warning;
    else
      report "TESTE CONCLUIDO: SEM ERROS." severity note;
    end if;

    wait;
  end process;
end architecture tb;
