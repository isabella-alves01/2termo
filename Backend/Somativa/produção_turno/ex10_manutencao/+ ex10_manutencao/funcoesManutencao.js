// EXERCÍCIO 10 — Funções de manutenção

function calcularMaoDeObra(horas) {
    return horas * 80;
}

function calcularTotal(valorPecas, horas) {
    const maoDeObra = calcularMaoDeObra(horas);
    return valorPecas + maoDeObra;
}

function verificarGarantia(meses) {
    if (meses <= 6) {
        return "EM GARANTIA";
    } else {
        return "FORA DA GARANTIA";
    }
}

module.exports = {
    calcularMaoDeObra,
    calcularTotal,
    verificarGarantia
};