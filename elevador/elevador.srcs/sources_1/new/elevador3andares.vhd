----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 

-- Design Name: 
-- M-- odule Name: elevador3andares - Behavioral
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

entity elevador3andares is
 Port (
       clk             : in  std_logic;
       reset           : in  std_logic;
       chamada1        : in  std_logic;
       chamada2        : in  std_logic;
       chamada3        : in  std_logic;
       andar_atual     : in  std_logic_vector(1 downto 0);  -- 00=1º, 01=2º, 10=3º

       motor_subindo   : out std_logic;
       motor_descendo  : out std_logic;
       abrir_porta     : out std_logic;
       fechar_porta    : out std_logic
   );
end elevador3andares;

architecture Behavioral of elevador3andares is
    type estado_type is (PARADO, SUBINDO, DESCENDO, ABRINDO_FECHANDO);
    signal estado_atual, prox_estado : estado_type;

begin
    -----------------------------------------------------
    -- Processo de transição de estados (registrador)
    -----------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= PARADO;
        elsif rising_edge(clk) then
            estado_atual <= prox_estado;
        end if;
    end process;

    -----------------------------------------------------
    -- Lógica de transição de estados
    -----------------------------------------------------
    process(estado_atual, chamada1, chamada2, chamada3, andar_atual)
    begin
        -- Valores padrão
        prox_estado <= estado_atual;

        case estado_atual is

            when PARADO =>
                if chamada1 = '1' and andar_atual > "00" then
                    prox_estado <= DESCENDO;
                elsif chamada3 = '1' and andar_atual < "10" then
                    prox_estado <= SUBINDO;
                elsif chamada2 = '1' and andar_atual = "00" then
                    prox_estado <= SUBINDO;
                elsif chamada2 = '1' and andar_atual = "10" then
                    prox_estado <= DESCENDO;
                elsif chamada2 = '1' and andar_atual = "01" then
                    prox_estado <= ABRINDO_FECHANDO;
                else
                    prox_estado <= PARADO;
                end if;

            when SUBINDO =>
                if andar_atual = "10" then  -- Quando chega no andar 3
                    prox_estado <= ABRINDO_FECHANDO;
                else
                    prox_estado <= SUBINDO;
                end if;

            when DESCENDO =>
                if andar_atual = "00" then  -- Quando chega no andar 1
                    prox_estado <= ABRINDO_FECHANDO;
                else
                    prox_estado <= DESCENDO;
                end if;

            when ABRINDO_FECHANDO =>
                prox_estado <= PARADO;

            when others =>
                prox_estado <= PARADO;
        end case;
    end process;

    -----------------------------------------------------
    -- Saídas dependentes do estado atual
    -----------------------------------------------------
    process(estado_atual)
    begin
        motor_subindo  <= '0';
        motor_descendo <= '0';
        abrir_porta    <= '0';
        fechar_porta   <= '0';

        case estado_atual is
            when PARADO =>
                fechar_porta <= '1';  -- portas fechadas

            when SUBINDO =>
                motor_subindo <= '1';

            when DESCENDO =>
                motor_descendo <= '1';

            when ABRINDO_FECHANDO =>
                abrir_porta <= '1';  -- abrindo as portas

            when others =>
                null;
        end case;
    end process;

end Behavioral;
