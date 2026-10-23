const entrada = require(`readline-sync`);

const sistema = require(`./conversor`);
console.log("==SISTEMA DE CONVERSÃO==");

const valorDolar = entrada.questionFloat("Qual e o valor em Dólar: ");

const valorTotal = sistema.calcula(5.00, valorDolar);
console.log(`O valor em Real é: R$ ${valorTotal.toFixed(2)}`);

