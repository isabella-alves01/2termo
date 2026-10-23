const sensor = require('./sensor');
const entrada = require('readline-sync');

console.log("===SISTEMA DE MONITORAMENTO DE TEMPERATURA===");

const temperatura = entrada.questionFloat("Digite a temperatura da caldeira: ");
const umidade = entrada.questionFloat("Digite a umidade do ar: ");

const resultadoTemperatura = sensor.checarTemperatura(temperatura);
const resultadoUmidade = sensor.checarUmidade(umidade);

console.log("Resultado da verificação de temperatura:");
console.log(resultadoTemperatura);
console.log("Resultado da verificação de umidade:");
console.log(resultadoUmidade);