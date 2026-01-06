library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_compressor_32_8b is
    port (
        clk    : in  std_logic;
        ap_rst : in  std_logic;
        a     : in  std_logic_vector(7 downto 0);
        b     : in  std_logic_vector(7 downto 0);
        c     : in  std_logic_vector(7 downto 0);
        soma   : out std_logic_vector(7 downto 0);
        c_out  : out std_logic_vector(1 downto 0)
    );
end entity;

architecture Behavioral of top_level_compressor_32_8b is

    component compressor32_8b_Sklansky is
        port (
            A : in  std_logic_vector(7 downto 0);
            B : in  std_logic_vector(7 downto 0);
            C : in  std_logic_vector(7 downto 0);
            S : out std_logic_vector(9 downto 0)
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

    signal rst_n     : std_logic;
    signal a_reg     : std_logic_vector(7 downto 0);
    signal b_reg     : std_logic_vector(7 downto 0);
    signal c_reg     : std_logic_vector(7 downto 0);
    signal s_raw     : std_logic_vector(9 downto 0);
    signal soma_raw  : std_logic_vector(7 downto 0);
    signal soma_reg  : std_logic_vector(7 downto 0);
    signal c_out_raw : std_logic_vector(1 downto 0);
    signal c_out_reg : std_logic_vector(1 downto 0);

begin

    rst_n <= not ap_rst;

    ff_a : FF_D8
        port map (clk => clk, rst_n => rst_n, d => a, q => a_reg);

    ff_b : FF_D8
        port map (clk => clk, rst_n => rst_n, d => b, q => b_reg);

    ff_c : FF_D8
        port map (clk => clk, rst_n => rst_n, d => c, q => c_reg);
    u_compressor : compressor32_8b_Sklansky
        port map (
            A => a_reg,
            B => b_reg,
            C => c_reg,
            S => s_raw
        );

    soma_raw  <= s_raw(7 downto 0);
    c_out_raw <= s_raw(9 downto 8);

    ff_soma : FF_D8
        port map (clk => clk, rst_n => rst_n, d => soma_raw, q => soma_reg);

    ff_c_out : FF_D2
        port map (clk => clk, rst_n => rst_n, d => c_out_raw, q => c_out_reg);

    soma  <= soma_reg;
    c_out <= c_out_reg;

end Behavioral;
