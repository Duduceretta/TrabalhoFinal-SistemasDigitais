# **Elevador de 3 Andares - Projeto de Máquina de Estados Finitos (FSM)**

## Integrantes:
- **Nome do Integrante 1**  
- **Nome do Integrante 2**  
- **Nome do Integrante 3**

---

## Objetivo do Circuito

O objetivo deste projeto é desenvolver um modelo de **Máquina de Estados Finitos (FSM)** em VHDL para controlar um **elevador de 3 andares**. O sistema simula o comportamento de um elevador simples, com a capacidade de subir e descer entre três andares (1º, 2º e 3º), além de abrir e fechar as portas no momento certo.

---

## Diagrama de Estados (FSM)

A máquina de estados é composta pelos seguintes estados e transições:

### **Estados:**
- **PARADO**: O elevador está parado no andar atual, podendo ter as portas abertas ou fechadas.
- **SUBINDO**: O elevador está indo para o andar superior.
- **DESCENDO**: O elevador está indo para o andar inferior.
- **ABRINDO_FECHANDO**: O elevador está abrindo ou fechando as portas.

### **Transições:**
1. **PARADO → SUBINDO**: O botão para o andar superior é pressionado.
2. **PARADO → DESCENDO**: O botão para o andar inferior é pressionado.
3. **SUBINDO → PARADO**: O elevador chega no andar superior.
4. **DESCENDO → PARADO**: O elevador chega no andar inferior.
5. **PARADO → ABRINDO_FECHANDO**: O elevador chega ao andar de destino e as portas começam a abrir ou fechar.
6. **ABRINDO_FECHANDO → PARADO**: O elevador termina o processo de abrir ou fechar as portas.

### **Diagrama de Estados:**

''`plaintext
            [PARADO]
           /   |    \
    BotãoAndarSuperior  BotãoAndarInferior  ChegadaAoAndar
        |                     |                  |
    [SUBINDO]            [DESCENDO]          [ABRINDO_FECHANDO]
        |                     |                   |
   ChegadaAoAndar      ChegadaAoAndar       PortasFechadas / PortasAbertas
        |                     |                   |
    [ABRINDO_FECHANDO]     [ABRINDO_FECHANDO]  [PARADO]
           |                    |
      PortasAbertas        PortasFechadas
           |                    |
        [PARADO]            [PARADO]

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
