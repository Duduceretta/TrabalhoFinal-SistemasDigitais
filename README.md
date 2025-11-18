# 🛗 Elevador de 3 Andares - Controlador FSM em VHDL

> Projeto desenvolvido para a disciplina de Sistemas Digitais.

## 👥 Integrantes
* **Bruno Difante**
* **Eduardo Ceretta**

---

## 🎯 Objetivo do Projeto

O objetivo deste projeto é desenvolver um modelo de **Máquina de Estados Finitos (FSM)** utilizando a linguagem de descrição de hardware **VHDL**. O sistema simula o comportamento de controle de um elevador de 3 andares, gerenciando a lógica de movimentação (subir/descer), monitoramento de posição e controle de portas.

---

## ⚙️ Arquitetura da Máquina de Estados (FSM)

O sistema opera com base em 4 estados principais e transições lógicas baseadas nas entradas dos botões e sensores de andar.

### Estados Definidos:
* **PARADO:** O elevador está estático no andar atual (aguardando chamada).
* **SUBINDO:** O motor é acionado para mover a cabine para um andar superior.
* **DESCENDO:** O motor é acionado para mover a cabine para um andar inferior.
* **ABRINDO_FECHANDO:** Estado de transição onde o elevador chegou ao destino e manipula as portas.

### Diagrama de Estados

<img width="707" height="274" alt="image" src="Diagrama e Simulação/Diagrama.png" />

📊 Simulação e Testbench
A validação do projeto foi feita através de simulação de ondas (Waveform). Abaixo, a descrição dos sinais utilizados no testbench:

## 📥 1. Entradas (Inputs)
*Sinais de estímulo gerados pelo Testbench para controlar o elevador.*

| Sinal | Símbolo | Descrição | Função |
| :--- | :---: | :--- | :--- |
| **`clk_tb`** | ⏰ | **Clock** (Sincronismo). | Sincroniza as operações da FSM. O sistema avança a cada borda de subida do relógio. |
| **`reset_tb`** | 🔄 | **Reset** (Reinício). | Quando acionado, força o elevador para o estado inicial (**Térreo**) e fecha as portas. |
| **`chamada1_tb`** | 1️⃣ | **Botão do 1º Andar**. | Solicita o elevador para o Térreo (Andar 1).<br>• Se estiver acima, inicia descida. |
| **`chamada2_tb`** | 2️⃣ | **Botão do 2º Andar**. | Solicita o elevador para o andar intermediário.<br>• Avalia se precisa subir ou descer. |
| **`chamada3_tb`** | 3️⃣ | **Botão do 3º Andar**. | Solicita o elevador para o topo.<br>• Se estiver abaixo, inicia subida. |

## 📤 2. Saídas (Outputs)
*Sinais de resposta do circuito para controle de motores e sensores.*

| Sinal | Símbolo | Descrição | Comportamento |
| :--- | :---: | :--- | :--- |
| **`andar_atual_tb`** | 📍 | **Sensor de Posição** (2 bits). | Indica o andar atual em binário:<br>• `00`: 1º Andar (Térreo).<br>• `01`: 2º Andar.<br>• `10`: 3º Andar. |
| **`motor_subindo_tb`** | ⬆️ | **Motor de Subida**. | • `'1'`: Aciona o motor para mover a cabine para **CIMA**.<br>• `'0'`: Motor parado. |
| **`motor_descendo_tb`** | ⬇️ | **Motor de Descida**. | • `'1'`: Aciona o motor para mover a cabine para **BAIXO**.<br>• `'0'`: Motor parado. |
| **`abrir_porta_tb`** | 👐 | **Comando Abrir Porta**. | Pulso enviado quando o elevador chega ao destino (Estado **ABRINDO**). |
| **`fechar_porta_tb`** | 🚪 | **Comando Fechar Porta**. | Sinal ativo enquanto o elevador se prepara para mover ou está em movimento (Segurança). |


Explicação do Funcionamento Passo a Passo

Início do Sistema: O elevador começa no 1º andar (andar_atual = "00"), com as portas fechadas e o sistema em estado PARADO.

Subindo para o 3º Andar:

O usuário pressiona o botão para o 3º andar.

O elevador começa a subir e o estado muda para SUBINDO.

Durante o movimento, o motor é acionado e o elevador passa pelo 2º andar (andar_atual = "01") e, em seguida, chega ao 3º andar (andar_atual = "10").

Chegada ao 3º Andar:

O elevador chega ao 3º andar, e o estado muda para ABRINDO_FECHANDO.

As portas são abertas.

O elevador fica parado no 3º andar, aguardando o comando para descer ou abrir as portas.

Descendo para o 1º Andar:

O usuário pressiona o botão para o 1º andar.

O elevador começa a descer e o estado muda para DESCENDO.

O motor é acionado e o elevador passa pelo 2º andar (andar_atual = "01") e, em seguida, chega ao 1º andar (andar_atual = "00").

Chegada ao 1º Andar:

O elevador chega ao 1º andar, e o estado muda para ABRINDO_FECHANDO novamente.

As portas são abertas.

O elevador fica parado e aguarda o próximo comando.

Conclusão
Aprendizados:

Durante o desenvolvimento deste projeto, aprendemos a modelar sistemas sequenciais usando máquinas de estados finitos (FSM) em VHDL, o que nos permitiu simular o comportamento de um elevador.

A utilização de transições condicionais foi crucial para garantir que o elevador se comportasse de maneira realista, realizando os movimentos de subida, descida, e abertura/fechamento das portas no momento certo.

Dificuldades:

Um dos principais desafios foi garantir que o estado de ABRINDO_FECHANDO fosse corretamente acionado quando o elevador chegasse ao andar de destino, garantindo que as portas se abrissem e fechassem no momento certo.

Além disso, tivemos que ajustar as transições entre os estados de SUBINDO e DESCENDO, pois o motor estava ficando preso em um dos estados, o que levou a revisões nas condições de transição.

No final, o projeto foi um sucesso, com a implementação de uma FSM funcional e a simulação do elevador operando de forma correta, conforme o esperado.
