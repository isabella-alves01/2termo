// Objetivo: Trabalhar com if, else if e else em uma regra de negócio.
// Crie um programa que leia a temperatura de uma máquina e classifique sua situação.
// O programa deve:
// ☐ Até 60 °C: situação NORMAL.
// ☐ De 61 °C até 80 °C: situação ATENÇÃO.
// ☐ Acima de 80 °C: situação CRÍTICA.
// ☐ Solicitar a temperatura pelo terminal.
// ☐ Exibir a temperatura e a classificação.


const entrada = require('readline-sync');

console.log("---CLASSIFICAÇÃO DE TEMPERATURA---");

const temperatura = entrada.questionFloat("Qual e a temperatura da maquina?");


if(temperatura <=60){
    console.log(`\nSituação NORMAL'${temperatura}`)
}else if( temperatura >=61 && temperatura <=80){
    console.log(`\n situação ATENCAO ${temperatura}`)
}
else{
    console.log(`\n situacao CRITICA`)
}
    


