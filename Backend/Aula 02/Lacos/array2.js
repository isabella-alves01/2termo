
// pesos.push(peso) armazena todas as informaçoes 


const entrada = require('readline-sync');

console.log("=== SISTEMA DE CONTROLE DE QUALIDADE - PESAGEM ===");

// 1. Definição de variáveis
const pesos = []; // Array para guardar o histórico (Dia 4)
let somaTotal = 0; // Acumulador (Dia 3)

const qtdPecas = entrada.questionInt("Quantas pecas deseja avaliar? ");

// 2. Loop para coletar dados
for (let i = 0; i < qtdPecas; i++) {
    let peso = entrada.questionFloat(`Digite o peso da peca ${i + 1} (kg): `);

    pesos.push(peso);        // Guarda no prédio/Array
    somaTotal += peso;       // Soma no cofre/Acumulador
}

// 3. Cálculos
const media = somaTotal / qtdPecas;

// 4. Exibição do Relatório
console.log("\n--- RELATORIO DA AUDITORIA ---");
console.log(`Pesos registrados: [ ${pesos.join(" kg | ")} kg ]`);
console.log(`Media de peso do lote: ${media.toFixed(2)} kg`);

// 5. Decisão (Lógica combinada da Semana 2)
if (media >= 4.8 && media <= 5.2) {
    console.log("STATUS FINAL: LOTE APROVADO!");
} else {
    console.log("STATUS FINAL: LOTE REPROVADO (Fora do padrão)");
}


