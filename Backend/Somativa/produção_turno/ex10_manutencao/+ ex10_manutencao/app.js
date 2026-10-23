// EXERCÍCIO 10 — Programa principal

const entrada = require("readline-sync");

const {
    calcularMaoDeObra,
    calcularTotal,
    verificarGarantia
} = require("./funcoesManutencao");

const maquina = entrada.question("Nome da máquina: ");
const valorPecas = entrada.questionFloat("Valor das peças: R$ ");
const horas = entrada.questionFloat("Horas de serviço: ");
const meses = entrada.questionInt("Meses desde a última manutenção: ");

const maoDeObra = calcularMaoDeObra(horas);
const total = calcularTotal(valorPecas, horas);
const garantia = verificarGarantia(meses);

console.log("\n=== RELATÓRIO DE MANUTENÇÃO ===");
console.log(`Máquina: ${maquina}`);
console.log(`Mão de obra: R$ ${maoDeObra.toFixed(2)}`);
console.log(`Peças: R$ ${valorPecas.toFixed(2)}`);
console.log(`Total: R$ ${total.toFixed(2)}`);
console.log(`Garantia: ${garantia}`);