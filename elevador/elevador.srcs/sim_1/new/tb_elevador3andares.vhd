----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2025 09:42:22
-- Design Name: 
-- Module Name: tb_elevador3andares - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_elevador3andares is
--  Port ( );
end tb_elevador3andares;

architecture Behavioral of tb_elevador3andares is
     component elevador3andares
       Port (
           clk             : in  std_logic;
           reset           : in  std_logic;
           chamada1        : in  std_logic;
           chamada2        : in  std_logic;
           chamada3        : in  std_logic;
           andar_atual     : in  std_logic_vector(1 downto 0);
           motor_subindo   : out std_logic;
           motor_descendo  : out std_logic;
           abrir_porta     : out std_logic;
           fechar_porta    : out std_logic
       );
   end component;

   -- Sinais internos para conectar ao DUT
   signal clk_tb           : std_logic := '0';
   signal reset_tb         : std_logic := '0';
   signal chamada1_tb      : std_logic := '0';
   signal chamada2_tb      : std_logic := '0';
   signal chamada3_tb      : std_logic := '0';
   signal andar_atual_tb   : std_logic_vector(1 downto 0) := "00";
   signal motor_subindo_tb : std_logic;
   signal motor_descendo_tb: std_logic;
   signal abrir_porta_tb   : std_logic;
   signal fechar_porta_tb  : std_logic;

   constant CLK_PERIOD : time := 10 ns;
begin
    uut: elevador3andares
        port map (
            clk             => clk_tb,
            reset           => reset_tb,
            chamada1        => chamada1_tb,
            chamada2        => chamada2_tb,
            chamada3        => chamada3_tb,
            andar_atual     => andar_atual_tb,
            motor_subindo   => motor_subindo_tb,
            motor_descendo  => motor_descendo_tb,
            abrir_porta     => abrir_porta_tb,
            fechar_porta    => fechar_porta_tb
        );

    clk_process : process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    stim_proc : process
        begin
            ------------------------------------------------------
            -- Inicialização
            ------------------------------------------------------
            report "=== Iniciando simulação ===";
            reset_tb <= '1';
            wait for 20 ns;
            reset_tb <= '0';
            wait for 20 ns;
    
            ------------------------------------------------------
            -- Situação inicial: elevador no 1º andar, parado
            ------------------------------------------------------
            andar_atual_tb <= "00"; -- 1º andar
            chamada1_tb <= '0';
            chamada2_tb <= '0';
            chamada3_tb <= '0';
            wait for 40 ns;
    
            ------------------------------------------------------
            -- Chamada para o 3º andar
            ------------------------------------------------------
            report ">>> Botão do 3º andar pressionado";
            chamada3_tb <= '1';
            wait for 20 ns;
            chamada3_tb <= '0';
    
            ------------------------------------------------------
            -- Simula movimento do elevador subindo
            ------------------------------------------------------
            wait for 60 ns;
            report ">>> Elevador no 2º andar";
            andar_atual_tb <= "01";
            wait for 60 ns;
            report ">>> Elevador no 3º andar (chegou)";
            andar_atual_tb <= "10";
    
            ------------------------------------------------------
            -- Espera abertura das portas no 3º andar
            ------------------------------------------------------
            wait for 100 ns;
    
            ------------------------------------------------------
            -- Agora chamada para o 1º andar
            ------------------------------------------------------
            report ">>> Botão do 1º andar pressionado";
            chamada1_tb <= '1';
            wait for 20 ns;
            chamada1_tb <= '0';
    
            ------------------------------------------------------
            -- Simula descida
            ------------------------------------------------------
            wait for 60 ns;
            report ">>> Elevador no 2º andar (descendo)";
            andar_atual_tb <= "01";
            wait for 60 ns;
            report ">>> Elevador chegou ao 1º andar";
            andar_atual_tb <= "00";
    
            ------------------------------------------------------
            -- Espera final
            ------------------------------------------------------
            wait for 100 ns;
            report "=== Fim da simulação ===";
            wait;
        end process;

end Behavioral;
