// Objetivo: Utilizar laço de repetição para gerar uma sequência de resultados.
// Uma máquina produz uma quantidade fixa de peças a cada ciclo. Crie um programa que mostre a produção
// acumulada do ciclo 1 até o ciclo 10.
// O programa deve:
// ☐ Solicitar quantas peças a máquina produz por ciclo.
// ☐ Utilizar um laço for para percorrer os ciclos de 1 até 10.
// ☐ Em cada ciclo, exibir o número do ciclo e a produção acumulada.
// ☐ Não escrever manualmente as dez linhas.



const entrada = require('readline-sync');

console.log("---TABELA DE PRODUÇÃO---");

const pecasPorCiclo = entrada.questionInt("Quantas pecas a maquina vai produzir por ciclo? ");

let producaoAcumulada = 0;

for (let ciclo = 1; ciclo <= 10; ciclo++) {
    producaoAcumulada += pecasPorCiclo;
    console.log(`Ciclo ${ciclo}: a produção acumulada ${producaoAcumulada}`);
}









