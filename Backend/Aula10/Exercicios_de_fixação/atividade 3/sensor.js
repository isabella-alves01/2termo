function checarTemperatura(valor) {
    if (valor > 40) {
        return "ALERTA: Caldeira Superaquecida !!!!";
    } else {
        return "Caldeira em temperatura normal";
    }
}
function checarUmidade(valor) {
    if (valor < 20) {
        return "ALERTA: Ar muito seco.";
    }else {
        return "Umidade normal";
    }
}
module.exports = {
    checarTemperatura,
    checarUmidade
}
