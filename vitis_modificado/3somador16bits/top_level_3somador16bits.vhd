----------------------------------------------------------------------------------
-- Top-level wrapper for the 3-input, 16-bit adder generated via Vitis HLS.
-- Mirrors the pipeline structure used em top_level_compressor_42, com entradas
-- e saídas registradas para análise de temporização.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_3somador16bits is
  port (
    clk       : in  std_logic;
    ap_rst    : in  std_logic;
    a         : in  std_logic_vector(15 downto 0);
    b         : in  std_logic_vector(15 downto 0);
    c         : in  std_logic_vector(15 downto 0);
    ap_return : out std_logic_vector(15 downto 0);
    c_out     : out std_logic_vector(1 downto 0)
  );
end top_level_3somador16bits;

architecture Behavioral of top_level_3somador16bits is

  ------------------------------------------------------------------------------
  -- Componentes
  ------------------------------------------------------------------------------
  component somador32bits is
    port (
      a         : in  std_logic_vector(15 downto 0);
      b         : in  std_logic_vector(15 downto 0);
      c         : in  std_logic_vector(15 downto 0);
      ap_return : out std_logic_vector(15 downto 0);
      c_out     : out std_logic_vector(1 downto 0);
      ap_rst    : in  std_logic
    );
  end component;

  component FF_D16 is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic_vector(15 downto 0);
      q     : out std_logic_vector(15 downto 0)
    );
  end component;

  component FF_D2 is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic_vector(1 downto 0);
      q     : out std_logic_vector(1 downto 0)
    );
  end component;

  ------------------------------------------------------------------------------
  -- Sinais internos
  ------------------------------------------------------------------------------
  signal rst_n        : std_logic;
  signal a_reg        : std_logic_vector(15 downto 0);
  signal b_reg        : std_logic_vector(15 downto 0);
  signal c_reg        : std_logic_vector(15 downto 0);
  signal sum_raw      : std_logic_vector(15 downto 0);
  signal sum_reg      : std_logic_vector(15 downto 0);
  signal c_out_raw    : std_logic_vector(1 downto 0);
  signal c_out_reg    : std_logic_vector(1 downto 0);

begin

  rst_n <= not ap_rst;

  ------------------------------------------------------------------------------
  -- Registradores de entrada
  ------------------------------------------------------------------------------
  ff_a : FF_D16
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => a,
      q     => a_reg
    );

  ff_b : FF_D16
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => b,
      q     => b_reg
    );

  ff_c : FF_D16
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => c,
      q     => c_reg
    );

  ------------------------------------------------------------------------------
  -- Dispositivo em teste: somador de 3 entradas
  ------------------------------------------------------------------------------
  u_somador : somador32bits
    port map (
      a         => a_reg,
      b         => b_reg,
      c         => c_reg,
      ap_return => sum_raw,
      c_out     => c_out_raw,
      ap_rst    => ap_rst
    );

  ------------------------------------------------------------------------------
  -- Registradores de saída
  ------------------------------------------------------------------------------
  ff_sum : FF_D16
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => sum_raw,
      q     => sum_reg
    );

  ff_cout : FF_D2
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => c_out_raw,
      q     => c_out_reg
    );

  ap_return <= sum_reg;
  c_out     <= c_out_reg;

end Behavioral;
