// Objetivo: Utilizar entrada de dados no terminal e operações com valores numéricos.
// Crie um programa para calcular o custo de uma compra de matéria-prima.
// O programa deve:
// ☐ Importar a biblioteca readline-sync.
// ☐ Solicitar ao usuário o nome do material.
// ☐ Solicitar a quantidade comprada.
// ☐ Solicitar o preço unitário.
// ☐ Calcular o valor total da compra.
// ☐ Exibir um pequeno resumo da compra.
// Arquivo para entrega
// Salve este exercício como: ex02_compra.js
// Execute o arquivo pelo terminal com Node.js e confirme seu funcionamento.


const entrada = require('readline-sync')

console.log("---PEDIDOS DE MATERIA PRIMA---")

const  nome_material = entrada.question("Qual e o nome do material?");
const  quantidadeComprada = entrada.questionFloat("Qual e  a quantidade comprada?");
const  precoUnitario =  entrada.questionFloat("Qual e o preco unitario do seu material?");
const ValorTotalDaCompra = quantidadeComprada * precoUnitario

console.log(`\n Nome do seu material: ${nome_material}  A quantidade que voce comprou: ${quantidadeComprada}  O valor de cada um: ${precoUnitario}  O total da sua compra e de  ${ValorTotalDaCompra}`);



