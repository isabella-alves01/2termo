// Atividade 4: O "Mercadinho" (Organização de Responsabilidades)

// "Este é o teste final. Quero um sistema de vendas. Mas atenção à regra
// profissional: O arquivo de funções não pode fazer perguntas! Ele apenas recebe
// números e devolve cálculos."


// - Programa caixa.js:
// - Faz todos os question do readline-sync.
// - Usa o módulo para processar e imprime o cupom final.

const entrada = require('readline-sync');
const vendas = require('./calculosVendas');

console.log("===SISTEMA DE VENDAS===");

const nomeCliente = entrada.question("Digite o nome do cliente: ");
const precoProduto = entrada.questionFloat("Digite o preço do produto: ");
const quantidadeProduto = entrada.questionInt("Digite a quantidade do produto: ");

const total = vendas.calcularTotal(precoProduto, quantidadeProduto);
const cupom = vendas.gerarCupom(nomeCliente, total);
console.log("\n===CUPOM FISCAL===");
console.log(cupom);






