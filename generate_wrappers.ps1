$ErrorActionPreference = 'Stop'
$root = 'f:\github_projects\New JICS'

function New-FFCode {
    param(
        [string]$Entity,
        [int]$Width,
        [string]$Path
    )

    $code = @"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity $Entity is
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;
        d     : in  std_logic_vector($($Width - 1) downto 0);
        q     : out std_logic_vector($($Width - 1) downto 0)
    );
end entity;

architecture rtl of $Entity is
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            q <= (others => '0');
        elsif rising_edge(clk) then
            q <= d;
        end if;
    end process;
end architecture;
"@

    Set-Content -Path $Path -Value $code.Trim() -Encoding ascii
}

function New-TopLevel {
    param(
        [string]$TopName,
        [string]$ComponentName,
        [int]$Width,
        [string[]]$Inputs,
        [int]$COutWidth,
        [string]$OutputPort,
        [string]$Path
    )

    $inputPortLines = ($Inputs | ForEach-Object { "        {0,-6}: in  std_logic_vector({1} downto 0);" -f $_, ($Width - 1) }) -join "`n"
    $componentInputLines = ($Inputs | ForEach-Object { "            {0} : in  std_logic_vector({1} downto 0);" -f ($_.ToUpper()), ($Width - 1) }) -join "`n"
    $signalRegLines = ($Inputs | ForEach-Object { "    signal {0}_reg     : std_logic_vector({1} downto 0);" -f $_, ($Width - 1) }) -join "`n"
    $ffInstances = ($Inputs | ForEach-Object { "    ff_{0} : FF_D{1}`n        port map (clk => clk, rst_n => rst_n, d => {0}, q => {0}_reg);" -f $_, $Width }) -join "`n`n"
    $portMapLines = ($Inputs | ForEach-Object { "            {0} => {1}_reg," -f ($_.ToUpper()), $_ }) -join "`n"
    $totalWidth = $Width + $COutWidth

    $content = @"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity $TopName is
    port (
        clk    : in  std_logic;
        ap_rst : in  std_logic;
$inputPortLines
        soma   : out std_logic_vector($($Width - 1) downto 0);
        c_out  : out std_logic_vector($($COutWidth - 1) downto 0)
    );
end entity;

architecture Behavioral of $TopName is

    component $ComponentName is
        port (
$componentInputLines
            $OutputPort : out std_logic_vector($($totalWidth - 1) downto 0)
        );
    end component;

    component FF_D$Width is
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            d     : in  std_logic_vector($($Width - 1) downto 0);
            q     : out std_logic_vector($($Width - 1) downto 0)
        );
    end component;

    component FF_D$COutWidth is
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            d     : in  std_logic_vector($($COutWidth - 1) downto 0);
            q     : out std_logic_vector($($COutWidth - 1) downto 0)
        );
    end component;

    signal rst_n     : std_logic;
$signalRegLines
    signal s_raw     : std_logic_vector($($totalWidth - 1) downto 0);
    signal soma_raw  : std_logic_vector($($Width - 1) downto 0);
    signal soma_reg  : std_logic_vector($($Width - 1) downto 0);
    signal c_out_raw : std_logic_vector($($COutWidth - 1) downto 0);
    signal c_out_reg : std_logic_vector($($COutWidth - 1) downto 0);

begin

    rst_n <= not ap_rst;

$ffInstances
    u_compressor : $ComponentName
        port map (
$portMapLines
            $OutputPort => s_raw
        );

    soma_raw  <= s_raw($($Width - 1) downto 0);
    c_out_raw <= s_raw($($totalWidth - 1) downto $Width);

    ff_soma : FF_D$Width
        port map (clk => clk, rst_n => rst_n, d => soma_raw, q => soma_reg);

    ff_c_out : FF_D$COutWidth
        port map (clk => clk, rst_n => rst_n, d => c_out_raw, q => c_out_reg);

    soma  <= soma_reg;
    c_out <= c_out_reg;

end Behavioral;
"@

    Set-Content -Path $Path -Value $content.Trim() -Encoding ascii
}

$families = @(

    # 3:2 compressores retornam porta SOMA e 1 bit de carry-out
    @{folder='Compressor32_8bits';  width=8;  cOut=2; outPort='S'; top='top_level_compressor_32_8b';   regex='^compressor32_8b_(.+)$';    inputs=@('a','b','c')},

    # 4:2 compressores retornam porta SOMA e 2 bits de carry-out
    @{folder='Compressor42_8bits';  width=8;  cOut=2; outPort='SOMA'; top='top_level_compressor_42_8b';   regex='^compressor_42_8b_(.+)$';    inputs=@('a','b','c','d')},
    @{folder='Compressor42_16bits'; width=16; cOut=2; outPort='SOMA'; top='top_level_compressor_42_16b';  regex='^compressor_42_16b_(.+)$';   inputs=@('a','b','c','d')},

    # 5:2, 7:2 e 8:2 retornam porta sum (minúsculo) e têm 3 bits de carry-out
    @{folder='Compressor52_8bits';  width=8;  cOut=3; outPort='sum';  top='top_level_compressor_52_8b';   regex='^Compressor_52_8b_(.+)$';    inputs=@('a','b','c','d','e')},
    @{folder='Compressor52_16bits'; width=16; cOut=3; outPort='sum';  top='top_level_compressor_52_16b';  regex='^Compressor_52_16b_(.+)$';   inputs=@('a','b','c','d','e')},

    @{folder='Compressor72_8bits';  width=8;  cOut=3; outPort='sum';  top='top_level_compressor_7x2_8b';  regex='^compressor_7x2_8b_(.+)$';   inputs=@('a','b','c','d','e','f','g')},
    @{folder='Compressor72_16bits'; width=16; cOut=3; outPort='sum';  top='top_level_compressor_7x2_16b'; regex='^compressor_7x2_16b_(.+)$'; inputs=@('a','b','c','d','e','f','g')},

    @{folder='Compressor82_8bits';  width=8;  cOut=3; outPort='sum';  top='top_level_compressor_8x2_8b';  regex='^compressor_8x2_8b_(.+)$';   inputs=@('a','b','c','d','e','f','g','h')},
    @{folder='Compressor82_16bits'; width=16; cOut=3; outPort='sum';  top='top_level_compressor_8x2_16b'; regex='^compressor_8x2_16b_(.+)$'; inputs=@('a','b','c','d','e','f','g','h')}
)

foreach ($fam in $families) {
    $folderPath = Join-Path $root $fam.folder
    $files = Get-ChildItem -Path $folderPath -File -Recurse -Filter '*.vhd'
    foreach ($file in $files) {
        $name = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        if ($name -match $fam.regex) {
            $variant = $matches[1]
            $targetDir = Join-Path $folderPath ("compressor_" + $variant)
            New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
            if ($file.DirectoryName -ne $targetDir) {
                Move-Item -Path $file.FullName -Destination $targetDir -Force
            }
            $ffDataName = "FF_D$($fam.width)"
            $ffCarryName = "FF_D$($fam.cOut)"
            New-FFCode -entity $ffDataName -width $fam.width -path (Join-Path $targetDir ($ffDataName + '.vhd'))
            New-FFCode -entity $ffCarryName -width $fam.cOut -path (Join-Path $targetDir ($ffCarryName + '.vhd'))
            $topPath = Join-Path $targetDir ($fam.top + '.vhd')
            New-TopLevel -topName $fam.top -componentName $name -width $fam.width -inputs $fam.inputs -cOutWidth $fam.cOut -OutputPort $fam.outPort -path $topPath
        }
    }
}
