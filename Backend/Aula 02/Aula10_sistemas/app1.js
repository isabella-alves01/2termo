const entrada = require(`readline-sync`);

//Buscando ferramentas no arquivo funcoesOficina.js
//o `./ significa "nesta mesma pasta"
const oficina = require(`./funcoesOficina`);
console.log("==SISTEMA DE GESTÃO DE OFICINA==");

const peca = entrada.questionFloat("Preco de peca: R$");
const horas = entrada.questionInt("Horas de servico:");
const tempoUso = entrada.questionInt("Meses desde o ultimo conserto:");

//Usameos o nome `oficina` (que damos no require) seguido do ponto .
const totalFinalBruto = oficina.calcularOrcamento(peca, horas);
const statusGarantia = oficina.verificarGarantia(tempoUso);
const totalComDesconto = oficina.aplicarDesconto(totalFinalBruto)

console.log("\n ---RELATORIO FINAL---");
console.log(`Orcamento sem desconto: R$ ${totalFinalBruto.toFixed(2)}`);
console.log(`Orcamento com desconto (5%): R$ ${totalComDesconto.toFixed(2)}`);
console.log(`Status do veiculo: ${statusGarantia}`);


console.log("\n ---RESULTADOS FINAIS---");
console.log(`prazo: R$ ${verificarprazo.toFixed(2)}`);
console.log(`valor frete: R$ ${freteCalculado.toFixed(2)}`);
console.log(`valor seguro: R$ ${valorSeguro.toFixed(2)}`);
console.log(`Total entrega: R$ ${TotalEntrega.toFixed(2)}`)



function calcularBasekm(distancia,frete) {
        const valorFrete = 2.10;
        const valorPorKm = distancia * frete
        return distancia + frete;
}



function calcularSeguro(ValorCarga,seguro) {
        const ValorSeguro = 0.01;
        const seguroCalculado =  ValorCarga * seguro
        return ValorCarga + seguro;
}



function verificarprazo(kilometros) {
    if (kilometros>=100) {
        return "1 dia útil";   
    } else {
        return "3 a 5 dias úteis";
    }
}

module.exports = {
    calcularBasekm,
    calcularSeguro,
    verificarprazo
}

