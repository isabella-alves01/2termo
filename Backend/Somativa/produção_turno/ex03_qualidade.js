// Objetivo: Aplicar uma estrutura condicional simples.
// Uma peça será aprovada no controle de qualidade quando seu peso estiver entre 95 g e 105 g, inclusive. Crie um programa que leia o peso e informe o resultado da inspeção.
// O programa deve:
// ☐ Solicitar o peso da peça.
// ☐ Usar if/else para decidir se a peça está dentro do padrão.
// ☐ Exibir 'PEÇA APROVADA' quando estiver entre 95 e 105 g.
// ☐ Exibir 'PEÇA REPROVADA' nos demais casos.
// ☐ Exibir também o peso informado.
// Arquivo para entrega
// Salve este exercício como:  ex03_qualidade.js
// Execute o arquivo pelo terminal com Node.js e confirme seu funcionamento.

// Teste mínimo
// • Teste com 100 g e com 110 g.



const entrada = require('readline-sync');

console.log("---PEÇAS APROVADAS OU REPROVADAS---");

const precoPeca = entrada.questionFloat("Qual e o preco da peca?");

if(precoPeca <=105 && precoPeca>=95){
    console.log(`\nPEÇA APROVADA'${precoPeca}`)
}else{
    console.log(`\nPEÇA REPROVADA' ${precoPeca}`)
}



