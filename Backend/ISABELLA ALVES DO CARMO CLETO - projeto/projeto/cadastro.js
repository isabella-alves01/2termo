// CADASTRO DE FUNCIONÁRIOS - ATIVIDADE GUIADA
// Execute no terminal: node cadastro.js
const fs = require('node:fs');
const readline = require('node:readline/promises');
const { stdin: entrada, stdout: saida } = require('node:process');

const rl = readline.createInterface({ input: entrada, output: saida });

async function cadastrarFuncionarios() {
  const funcionarios = []; // Array vazio: receberá quatro objetos
  console.log('=== CADASTRO DE 4 FUNCIONÁRIOS ===');

  for (let i = 0; i < 4; i++) {
    console.log(`\nFuncionário ${i + 1} de 4`);
    const nome = (await rl.question('Nome: ')).trim();
    const idadeTexto = await rl.question('Idade: ');
    const funcao = (await rl.question('Função: ')).trim();
    const idade = Number(idadeTexto);

    // PASSO 1: crie um objeto com id, nome, idade e funcao.
    // Dica: o id pode ser i + 1.
    // const funcionario = { ... };

  const funcionario = { id: i + 1, nome: nome, idade: idade, funcao: funcao };

    // PASSO 2: acrescente o objeto ao array usando push().
    // funcionarios.push(funcionario);
  
  funcionarios.push(funcionario);
  
  }

  // PASSO 3: transforme o array em texto JSON formatado.
  // const json = JSON.stringify(funcionarios, null, 2);

const json = JSON.stringify(funcionarios, null, 2);
fs.writeFileSync('funcionarios.json', json, 'utf8');


  // PASSO 4: grave o texto em funcionarios.json.
  // fs.writeFileSync('funcionarios.json', json, 'utf8');

  console.log(`\nRegistros no array: ${funcionarios.length}`);
  console.log('Quando concluir os PASSOS 1 a 4, este programa gravará o JSON.');
}

cadastrarFuncionarios()
  .catch(erro => console.error('Erro:', erro.message))
  .finally(() => rl.close());
