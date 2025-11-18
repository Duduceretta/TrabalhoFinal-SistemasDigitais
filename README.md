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

### 🖼️ Diagrama de Estados

<div align="center">
  <img width="707" height="274" alt="Diagrama de Estados FSM do Elevador" src="Diagrama e Simulação/Diagrama.png" />
</div>

---

## 📊 Simulação e Testbench
A validação do projeto foi feita através de simulação de ondas (Waveform). Abaixo, a descrição dos sinais utilizados no testbench:

### 📥 1. Entradas (Inputs)
*Sinais de estímulo gerados pelo Testbench para controlar o elevador.*

| Sinal | Símbolo | Descrição | Função |
| :--- | :---: | :--- | :--- |
| **`clk_tb`** | ⏰ | **Clock** (Sincronismo). | Sincroniza as operações da FSM. O sistema avança a cada borda de subida do relógio. |
| **`reset_tb`** | 🔄 | **Reset** (Reinício). | Quando acionado, força o elevador para o estado inicial (**Térreo**) e fecha as portas. |
| **`chamada1_tb`** | 1️⃣ | **Botão do 1º Andar**. | Solicita o elevador para o Térreo (Andar 1).<br>• Se estiver acima, inicia descida. |
| **`chamada2_tb`** | 2️⃣ | **Botão do 2º Andar**. | Solicita o elevador para o andar intermediário.<br>• Avalia se precisa subir ou descer. |
| **`chamada3_tb`** | 3️⃣ | **Botão do 3º Andar**. | Solicita o elevador para o topo.<br>• Se estiver abaixo, inicia subida. |

### 📤 2. Saídas (Outputs)
*Sinais de resposta do circuito para controle de motores e sensores.*

| Sinal | Símbolo | Descrição | Comportamento |
| :--- | :---: | :--- | :--- |
| **`andar_atual_tb`** | 📍 | **Sensor de Posição** (2 bits). | Indica o andar atual em binário:<br>• `00`: 1º Andar (Térreo).<br>• `01`: 2º Andar.<br>• `10`: 3º Andar. |
| **`motor_subindo_tb`** | ⬆️ | **Motor de Subida**. | • `'1'`: Aciona o motor para mover a cabine para **CIMA**.<br>• `'0'`: Motor parado. |
| **`motor_descendo_tb`** | ⬇️ | **Motor de Descida**. | • `'1'`: Aciona o motor para mover a cabine para **BAIXO**.<br>• `'0'`: Motor parado. |
| **`abrir_porta_tb`** | 👐 | **Comando Abrir Porta**. | Pulso enviado quando o elevador chega ao destino (Estado **ABRINDO**). |
| **`fechar_porta_tb`** | 🚪 | **Comando Fechar Porta**. | Sinal ativo enquanto o elevador se prepara para mover ou está em movimento (Segurança). |

## 📉 Resultados da Simulação

Abaixo, apresentamos o resultado da simulação (Waveform) realizada no ambiente de desenvolvimento. O gráfico valida a lógica da Máquina de Estados, demonstrando o comportamento dos sinais de entrada e saída ao longo do tempo.

<div align="center">
  <img width="707" height="274" alt="Waveform da Simulação" src="Diagrama e Simulação/Simulacao.png" />
</div>

---

### 🕵️‍♂️ Análise Passo a Passo do Funcionamento

Aqui detalhamos o ciclo completo de operação observado na imagem acima:

#### 1. 🏁 Início do Sistema
* **Estado:** `PARADO`
* **Posição:** 1º Andar (`andar_atual = "00"`)
* **Situação:** O sistema inicia resetado, com portas fechadas, aguardando chamadas.

#### 2. 🔼 Subindo para o 3º Andar
* **Ação:** O usuário pressiona o botão `chamada3`.
* **Transição:** O estado muda para **`SUBINDO`**.
* **Movimento:** O motor de subida é acionado. O sensor de andar detecta a passagem pelo 2º andar (`"01"`) até atingir o 3º andar (`"10"`).

#### 3. 📍 Chegada ao 3º Andar
* **Transição:** Ao detectar `andar = "10"`, o estado muda para **`ABRINDO_FECHANDO`**.
* **Ação:** As portas se abrem (`abrir_porta = '1'`).
* **Espera:** O elevador permanece no andar aguardando nova solicitação ou o fim do temporizador da porta.

#### 4. 🔽 Descendo para o 1º Andar
* **Ação:** O usuário pressiona o botão `chamada1`.
* **Transição:** O estado muda para **`DESCENDO`**.
* **Movimento:** O motor de descida é acionado, passando pelo 2º andar (`"01"`) até retornar ao térreo (`"00"`).

#### 5. 🏁 Chegada ao 1º Andar (Ciclo Completo)
* **Transição:** Ao chegar em `"00"`, o estado retorna para **`ABRINDO_FECHANDO`**.
* **Ação:** As portas se abrem novamente para o desembarque.
* **Fim:** O sistema volta ao estado `PARADO`, pronto para o próximo ciclo.

---

## 🚀 Conclusão e Considerações Finais

### 🎓 Aprendizados
> "A modelagem de sistemas sequenciais é a base para controlar o mundo real."

* **Modelagem FSM:** Compreendemos na prática como traduzir um problema real (elevador) para uma Máquina de Estados Finitos em VHDL.
* **Lógica Sequencial:** A importância das **transições condicionais** ficou evidente. O elevador só "sabe" o que fazer porque definimos regras estritas de transição baseadas no andar atual e no botão pressionado.

### 🚧 Dificuldades Superadas
* **Sincronismo de Portas:** O maior desafio foi o estado `ABRINDO_FECHANDO`. Foi necessário garantir que ele fosse acionado **exatamente** na chegada do andar, sem oscilações, para que a porta não abrisse com o elevador em movimento.
* **Travamento Lógico:** Inicialmente, o motor ficava "preso" nos estados de subida/descida. Ajustamos as condições de saída (borda do clock e verificação do sensor) para corrigir esse comportamento.

> **Resultado:** O projeto foi um sucesso, entregando uma FSM funcional e uma simulação fiel ao comportamento esperado de um elevador real.
