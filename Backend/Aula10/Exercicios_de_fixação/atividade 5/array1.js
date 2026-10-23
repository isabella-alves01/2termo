// Atividade 5: Registro de Peças Defeituosas (Array Simples)
// Foco: Criar uma lista do zero e preenchê-la usando um laço for.
// "Imaginem que vocês estão no setor de Qualidade. Vocês precisam registrar os
// números de série de todas as peças que saíram da máquina com defeito para
// gerar um relatório no final.
// O que vocês devem fazer:
// 1. Crie um array vazio chamado pecasDefeituosas.
// 2. Pergunte ao usuário: 'Quantas peças com defeito foram encontradas?'
// 3. Use um laço for que rode essa quantidade de vezes.
// 4. Dentro do laço, peça o número de série da peça e use o .push() para
// guardar esse número no seu array.
// 5. Ao final, mostre o relatório: 'Total de peças: [tamanho da lista] - Números
// de série: [lista completa]'."

const entrada = require(`readline-sync`);

const pecasDefeituosas = [];
const qtd = entrada.questionInt("Quantas peças com defeito foram encontradas? ");

for (let i = 0; i < qtd; i++) {
    const numeroSerie = entrada.question(`Digite o número de série da peça ${i + 1}: `);
    pecasDefeituosas.push(numeroSerie);
}

console.log(`Total de peças: ${pecasDefeituosas.length} - Números de série: ${pecasDefeituosas.join}`);

