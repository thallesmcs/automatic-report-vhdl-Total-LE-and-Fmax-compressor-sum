----------------------------------------------------------------------------------
-- Top-level wrapper for the 3-input, 8-bit adder generated via Vitis HLS.
-- Mirrors the pipeline structure used in top_level_compressor_42, providing
-- registered inputs and outputs to support timing characterization.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_3somador8bits is
  port (
    clk       : in  std_logic;
    ap_rst    : in  std_logic;
    a         : in  std_logic_vector(7 downto 0);
    b         : in  std_logic_vector(7 downto 0);
    c         : in  std_logic_vector(7 downto 0);
    ap_return : out std_logic_vector(7 downto 0);
    c_out     : out std_logic_vector(1 downto 0)
  );
end top_level_3somador8bits;

architecture Behavioral of top_level_3somador8bits is

  ------------------------------------------------------------------------------
  -- Components
  ------------------------------------------------------------------------------
  component somador32bits is
    port (
      a         : in  std_logic_vector(7 downto 0);
      b         : in  std_logic_vector(7 downto 0);
      c         : in  std_logic_vector(7 downto 0);
      ap_return : out std_logic_vector(7 downto 0);
      c_out     : out std_logic_vector(1 downto 0);
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

  component FF_D2 is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic_vector(1 downto 0);
      q     : out std_logic_vector(1 downto 0)
    );
  end component;

  ------------------------------------------------------------------------------
  -- Internal signals
  ------------------------------------------------------------------------------
  signal rst_n        : std_logic;
  signal a_reg        : std_logic_vector(7 downto 0);
  signal b_reg        : std_logic_vector(7 downto 0);
  signal c_reg        : std_logic_vector(7 downto 0);
  signal sum_raw      : std_logic_vector(7 downto 0);
  signal sum_reg      : std_logic_vector(7 downto 0);
  signal c_out_raw    : std_logic_vector(1 downto 0);
  signal c_out_reg    : std_logic_vector(1 downto 0);

begin

  rst_n <= not ap_rst;

  ------------------------------------------------------------------------------
  -- Input pipeline registers
  ------------------------------------------------------------------------------
  ff_a : FF_D8
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => a,
      q     => a_reg
    );

  ff_b : FF_D8
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => b,
      q     => b_reg
    );

  ff_c : FF_D8
    port map (
      clk   => clk,
      rst_n => rst_n,
      d     => c,
      q     => c_reg
    );

  ------------------------------------------------------------------------------
  -- Device under test: 3-input adder
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
  -- Output pipeline registers
  ------------------------------------------------------------------------------
  ff_sum : FF_D8
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
