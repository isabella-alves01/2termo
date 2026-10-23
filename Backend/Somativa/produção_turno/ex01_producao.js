
const entrada = require('readline-sync')

console.log("---PRODUÇÃO DO TURNO---")

let  pecasPorHora= entrada.questionInt("Quantas pecas fora produzidas por hora? ");
let  horasPorTurno = entrada.questionInt("Qual e a quantidade de horas por turno?");
let producaoTotalPorTurno = pecasPorHora * horasPorTurno


console.log(`\nProdução por hora ${pecasPorHora}, Quantidade de horas por turno ${horasPorTurno}, Total produzido ${producaoTotalPorTurno}`);

