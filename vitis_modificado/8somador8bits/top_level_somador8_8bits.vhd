----------------------------------------------------------------------------------
-- Top-level wrapper para o somador de 8 entradas e 8 bits do Vitis HLS.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_somador8_8bits is
  port (
    clk       : in  std_logic;
    ap_rst    : in  std_logic;
    a         : in  std_logic_vector(7 downto 0);
    b         : in  std_logic_vector(7 downto 0);
    c         : in  std_logic_vector(7 downto 0);
    d         : in  std_logic_vector(7 downto 0);
    e         : in  std_logic_vector(7 downto 0);
    f         : in  std_logic_vector(7 downto 0);
    g         : in  std_logic_vector(7 downto 0);
    h         : in  std_logic_vector(7 downto 0);
    ap_return : out std_logic_vector(7 downto 0);
    c_out     : out std_logic_vector(2 downto 0)
  );
end top_level_somador8_8bits;

architecture Behavioral of top_level_somador8_8bits is

  component somador8bits is
    port (
      a         : in  std_logic_vector(7 downto 0);
      b         : in  std_logic_vector(7 downto 0);
      c         : in  std_logic_vector(7 downto 0);
      d         : in  std_logic_vector(7 downto 0);
      e         : in  std_logic_vector(7 downto 0);
      f         : in  std_logic_vector(7 downto 0);
      g         : in  std_logic_vector(7 downto 0);
      h         : in  std_logic_vector(7 downto 0);
      ap_return : out std_logic_vector(7 downto 0);
      c_out     : out std_logic_vector(2 downto 0);
      ap_rst    : in  std_logic
    );
  end component;

  component FF_D8 is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic_vector(7 downto 0);
      q     : out std_logic_vector(7 downto 0)
    );
  end component;

  component FF_D3 is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic_vector(2 downto 0);
      q     : out std_logic_vector(2 downto 0)
    );
  end component;

  signal rst_n        : std_logic;
  signal a_reg        : std_logic_vector(7 downto 0);
  signal b_reg        : std_logic_vector(7 downto 0);
  signal c_reg        : std_logic_vector(7 downto 0);
  signal d_reg        : std_logic_vector(7 downto 0);
  signal e_reg        : std_logic_vector(7 downto 0);
  signal f_reg        : std_logic_vector(7 downto 0);
  signal g_reg        : std_logic_vector(7 downto 0);
  signal h_reg        : std_logic_vector(7 downto 0);
  signal sum_raw      : std_logic_vector(7 downto 0);
  signal sum_reg      : std_logic_vector(7 downto 0);
  signal c_out_raw    : std_logic_vector(2 downto 0);
  signal c_out_reg    : std_logic_vector(2 downto 0);

begin

  rst_n <= not ap_rst;

  ff_a : FF_D8
    port map (clk => clk, rst_n => rst_n, d => a, q => a_reg);

  ff_b : FF_D8
    port map (clk => clk, rst_n => rst_n, d => b, q => b_reg);

  ff_c : FF_D8
    port map (clk => clk, rst_n => rst_n, d => c, q => c_reg);

  ff_d1 : FF_D8
    port map (clk => clk, rst_n => rst_n, d => d, q => d_reg);

  ff_e : FF_D8
    port map (clk => clk, rst_n => rst_n, d => e, q => e_reg);

  ff_f : FF_D8
    port map (clk => clk, rst_n => rst_n, d => f, q => f_reg);

  ff_g : FF_D8
    port map (clk => clk, rst_n => rst_n, d => g, q => g_reg);

  ff_h : FF_D8
    port map (clk => clk, rst_n => rst_n, d => h, q => h_reg);

  u_somador : somador8bits
    port map (
      a         => a_reg,
      b         => b_reg,
      c         => c_reg,
      d         => d_reg,
      e         => e_reg,
      f         => f_reg,
      g         => g_reg,
      h         => h_reg,
      ap_return => sum_raw,
      c_out     => c_out_raw,
      ap_rst    => ap_rst
    );

  ff_sum : FF_D8
    port map (clk => clk, rst_n => rst_n, d => sum_raw, q => sum_reg);

  ff_cout : FF_D3
    port map (clk => clk, rst_n => rst_n, d => c_out_raw, q => c_out_reg);

  ap_return <= sum_reg;
  c_out     <= c_out_reg;

end Behavioral;
