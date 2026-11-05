// CONSULTA DE FUNCIONÁRIOS - ATIVIDADE GUIADA
// Execute depois do cadastro: node consulta.js
const fs = require('node:fs');

function carregarFuncionarios() {
  const texto = fs.readFileSync('funcionarios.json', 'utf8');
  return JSON.parse(texto);
}

function consultarPorId(funcionarios, id) {
  // PASSO 5: use find() para procurar funcionario.id === id
  return funcionarios.find(pessoa => pessoa.id === id);
}

function consultarPorNome(funcionarios, nome) {
  // PASSO 6: use find() para procurar nome exato, sem diferenciar maiúsculas
  return funcionarios.find(pessoa => pessoa.nome.toLowerCase() === nome.toLowerCase());
}

function filtrarPorFuncao(funcionarios, funcao) {
  // PASSO 7: use filter() para retornar todos da mesma função
  return funcionarios.filter(pessoa => pessoa.funcao.toLowerCase() === funcao.toLowerCase());

}

function mostrarFuncionario(funcionario) {
  if (!funcionario) {
    console.log('Funcionário não encontrado.');
    return;
  }
  console.log(`ID: ${funcionario.id} | Nome: ${funcionario.nome} | Idade: ${funcionario.idade} | Função: ${funcionario.funcao}`);
}

try {
  const funcionarios = carregarFuncionarios();
  console.log('=== TODOS OS FUNCIONÁRIOS ===');
  funcionarios.forEach(mostrarFuncionario);
  console.log('\n=== CONSULTA POR ID 99 ===');
  mostrarFuncionario(consultarPorId(funcionarios, 99));
  console.log('\n=== CONSULTA POR NOME ===');
  mostrarFuncionario(consultarPorNome(funcionarios, funcionarios[0].nome));
  console.log('\n=== FILTRO POR FUNÇÃO ===');
  // Troque o valor abaixo por uma função que você cadastrou.
  filtrarPorFuncao(funcionarios, funcionarios[0].funcao).forEach(mostrarFuncionario);
} catch (erro) {
  console.error('Não foi possível ler o JSON. Execute primeiro node cadastro.js.');
  console.error('Detalhe:', erro.message);
}
