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

```plaintext
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
