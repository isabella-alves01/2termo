
const entrada = require(`readline-sync`);

const logistica = require(`./calculadoraFrete`);
console.log("==SISTEMA DE DE CALCULO DE FRETES==");

const nomeProduto = entrada.question("Qual e o nome do produto: ");
const distanciaKM = entrada.questionInt("Qual e a distancia em Km:");
const ValorCarga = entrada.questionInt("Qual e o valor da carga:");


const freteCalculado = logistica.calcularBasekm(distanciaKM,ValorCarga);
const valorSeguro = logistica.calcularSeguro(ValorCarga);
const verificarprazo = logistica.verificarprazo(distanciaKM)
const TotalEntrega = freteCalculado + valorSeguro

console.log("\n ---RESULTADOS FINAIS---");
console.log(`prazo: ${verificarprazo}`);
console.log(`valor frete: R$ ${freteCalculado.toFixed(2)}`);
console.log(`valor seguro: R$ ${valorSeguro.toFixed(2)}`);
console.log(`Total entrega: R$ ${TotalEntrega.toFixed(2)}`);




