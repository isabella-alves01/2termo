// Objetivo: Cadastrar e percorrer dados armazenados em um array.
// Crie um programa para cadastrar os nomes de cinco operadores de uma equipe e, ao final, listar todos os nomes numerados.
// O programa deve:
// ☐ Criar um array vazio.
// ☐ Usar um laço para solicitar 5 nomes.
// ☐ Adicionar cada nome ao array usando push().
// ☐ Depois do cadastro, percorrer o array novamente.
// ☐ Exibir no formato: '1 - Nome', '2 - Nome' etc.
// ☐ Utilizar a propriedade length em pelo menos um dos laços.

const entrada = require('readline-sync');
const Operadores = [];

for (let i = 0; i < 5; i++) {
    const nomeOperador= entrada.question('Digite o nome do operador: ');
    Operadores.push(nomeOperador);
}

for (let i = 0; i < Operadores.length; i++) {
    console.log(`${i + 1} - ${Operadores[i]}`);
}





