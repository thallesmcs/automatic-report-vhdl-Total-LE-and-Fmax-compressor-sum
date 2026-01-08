library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;

-- Testbench: compara somador_comum (DUT) com sum_comum (golden)
entity tb_somadores is
end entity tb_somadores;

architecture tb of tb_somadores is
  constant WIDTH      : natural := 4;
  constant N_INPUTS   : natural := 2;
  constant SUM_WIDTH  : natural := 5;
  constant N_TESTS    : natural := 200;
  constant PRINT_FIRST: natural := 50;
  constant USE_GOLD_FILE : boolean := true; -- se true, usa vetor deterministico do arquivo
  constant GOLD_FILE_PATH : string := "../gold_tb/gold_vectors.txt";

  signal a, b       : std_logic_vector(WIDTH - 1 downto 0);
  signal uut_s      : std_logic_vector(WIDTH - 1 downto 0);
  signal uut_cout   : std_logic;
  signal uut_sum    : std_logic_vector(SUM_WIDTH - 1 downto 0);
  signal golden_sum : std_logic_vector(SUM_WIDTH - 1 downto 0);
  signal din_flat   : std_logic_vector(N_INPUTS * WIDTH - 1 downto 0);

begin

  -- Achata A e B para o somador de referencia.
  din_flat(WIDTH - 1 downto 0)             <= a;
  din_flat(2 * WIDTH - 1 downto 1 * WIDTH) <= b;

  uut: entity work.somador_comum
    port map (
      a    => a,
      b    => b,
      s    => uut_s,
      cout => uut_cout
    );

  uut_sum <= uut_cout & uut_s;

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
    file fvec      : text;
    variable l     : line;
    variable int_a, int_b, int_s : integer;
    variable t     : integer := 0;
  begin
    if USE_GOLD_FILE then
      file_open(fvec, GOLD_FILE_PATH, read_mode);
      while not endfile(fvec) loop
        readline(fvec, l);
        read(l, int_a);
        read(l, int_b);
        read(l, int_s);
        t := t + 1;

        a <= std_logic_vector(to_unsigned(int_a, WIDTH));
        b <= std_logic_vector(to_unsigned(int_b, WIDTH));

        wait for 1 ns;

        if t <= PRINT_FIRST then
          report "t=" & integer'image(t) &
                 " A=" & integer'image(int_a) &
                 " B=" & integer'image(int_b) &
                 " UUT=" & integer'image(to_integer(unsigned(uut_sum))) &
                 " REF=" & integer'image(to_integer(unsigned(golden_sum))) &
                 " EXPECT=" & integer'image(int_s)
            severity note;
        end if;

        assert to_integer(unsigned(uut_sum)) = int_s
          report "Mismatch (arquivo) teste " & integer'image(t) &
                 " esperado=" & integer'image(int_s) &
                 " obtido=" & integer'image(to_integer(unsigned(uut_sum)))
          severity error;

        assert uut_sum = golden_sum
          report "Mismatch (golden) teste " & integer'image(t) &
                 " esperado=" & integer'image(to_integer(unsigned(golden_sum))) &
                 " obtido=" & integer'image(to_integer(unsigned(uut_sum)))
          severity error;
      end loop;
      file_close(fvec);
      report "Todos os vetores do arquivo foram testados." severity note;
    else
      for t in 1 to N_TESTS loop
        uniform(seed1, seed2, randv);
        val := integer(floor(randv * real(2 ** WIDTH)));
        a <= std_logic_vector(to_unsigned(val, WIDTH));

        uniform(seed1, seed2, randv);
        val := integer(floor(randv * real(2 ** WIDTH)));
        b <= std_logic_vector(to_unsigned(val, WIDTH));

        wait for 1 ns;

        if t <= PRINT_FIRST then
          report "t=" & integer'image(t) &
                 " A=" & integer'image(to_integer(unsigned(a))) &
                 " B=" & integer'image(to_integer(unsigned(b))) &
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
    end if;

    wait;
  end process;
end architecture tb;
