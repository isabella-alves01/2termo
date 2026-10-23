// Atividade 6: Cadastro de Visitantes da Fábrica (Array de Objetos)
// Foco: Criar uma lista de objetos preenchida dinamicamente.
// "Agora o nível subiu! Vamos fazer o sistema da portaria. Eu não quero guardar
// apenas o nome do visitante, eu quero guardar o Nome e a Empresa de onde ele
// vem.
// O que vocês devem fazer:
// 1. Crie um array vazio chamado listaVisitantes.
// 2. Crie um laço while que pergunte: 'Deseja cadastrar um novo visitante?
// (s/n)'.
// 3. Se a resposta for 's':
// o Peça o Nome e a Empresa.
// o Crie um objeto { nome: ..., empresa: ... }.
// o Dê um .push() desse objeto para dentro da sua lista.




const entrada = require(`readline-sync`);
let listaVisitantes = []

while (true) {
    let opcao = entrada.question("deseja cadastrar um visitante? (s/n):")

    if(opcao.toUpperCase() !== 's') {
        break;
    }      

}

let nome = entrada.question("Digite o nome do visitante: ");
let empresaVis = entrada.question("Digite a empresa do visitante: ");

listaVisitantes.push({nome: nome, empresa: empresaVis});

console.log("===LISTA DE VISITANTES===");
for (let i = 0; i < listaVisitantes.length; i++) {
    console.log(`Visitante ${i + 1}: Nome: ${listaVisitantes[i].nome}, Empresa: ${listaVisitantes[i].empresa}`);
}




