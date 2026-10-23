// Objetivo: Combinar repetição, entrada de dados e acumulador.
// Durante um teste de processo, são realizadas cinco medições. Crie um programa que leia as cinco medições
// e calcule a média.
// O programa deve:
// ☐ Criar uma variável acumuladora iniciada em zero.
// ☐ Usar um laço para solicitar exatamente 5 valores.
// ☐ Somar cada valor ao acumulador.
// ☐ Ao final, calcular a média.
// ☐ Exibir a soma das medições e a média final.


const entrada = require('readline-sync');

console.log("---MEDIA DE 5 MEDIÇOES---");

let soma = 0;

for (let i = 1; i <= 5; i++) {
    const medicao = entrada.questionFloat(`Digite a ${i} medicao : `);
    soma += medicao;
}

const media = soma / 5;

console.log(`\nsoma das medicoes: ${soma}`);
console.log(`Media final: ${media}`);





