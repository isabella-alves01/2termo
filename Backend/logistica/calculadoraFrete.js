function calcularBasekm(distancia,frete) {
        const valorFrete = 2.10;
        const valorPorKm = distancia * frete
        return valorPorKm;
}



function calcularSeguro(ValorCarga,seguroCalculado) {
        const seguro = 0.01;
        const seguroCalculado =  ValorCarga * seguro
        return ValorCarga + seguroCalculado;
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



