// ☐ Criar um array vazio para armazenar os componentes.
// ☐ Cadastrar 3 componentes usando um laço.
// ☐ Para cada componente, criar um objeto com nome, quantidade e estoqueMinimo.
// ☐ Adicionar cada objeto ao array com push().
// ☐ Percorrer o array com um laço.
// ☐ Se quantidade for menor que estoqueMinimo, exibir 'REPOR ESTOQUE'.
// ☐ Caso contrário, exibir 'ESTOQUE OK'.

const entrada = require('readline-sync');
const componentes = [];

for (let i = 0; i < 3; i++) {
    const nome = entrada.question('Digite o nome do componente: ');
    const quantidade = entrada.questionInt('Digite a Quantidade em estoque: ');
    const estoqueMinimo = entrada.questionInt('Digite o estoque minimo: ');
    const componente = {
        nome: nome,
        quantidade: quantidade,
        estoqueMinimo: estoqueMinimo
    };
    componentes.push(componente);
}

for (let i = 0; i < componentes.length; i++) {
    const componente = componentes[i];
    if (componente.quantidade < componente.estoqueMinimo) {
        console.log(`REPOR ESTOQUE - ${componente.nome}`);
    } else {
        console.log(`ESTOQUE OK - ${componente.nome}`)
    }
}
