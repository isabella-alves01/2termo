# Repositório de Exercícios - 2º Termo DEVIS

## 📋 Descrição do Projeto

Este repositório contém os exercícios e projetos práticos desenvolvidos durante o 2º termo do curso de Desenvolvimento e Inovação em Software (DEVIS) na SESISENAI. O projeto é organizado em três disciplinas principais: Backend (Node.js), Banco de Dados e Front-end (HTML), com foco no aprendizado de programação, modelagem de dados e desenvolvimento web.

## 🛠️ Tecnologias Utilizadas

- **Node.js** - Runtime JavaScript para execução de scripts backend
- **JavaScript (ES6+)** - Linguagem de programação principal
- **HTML5** - Linguagem de marcação para front-end
- **readline-sync** - Biblioteca para entrada interativa de dados no console
- **Modelagem de Dados Conceitual** - Ferramenta brModeler para criação de modelos de banco de dados

## 📁 Estrutura de Pastas

```
2termo/
├── Backend/
│   └── Aula 02/
│       ├── package.json           # Dependências do projeto Node.js
│       ├── package-lock.json      # Lock file das dependências
│       ├── node_modules/          # Pasta de módulos instalados
│       ├── texto_README           # Instruções originais do projeto
│       └── Lacos/                 # Exercícios sobre laços e arrays
│           ├── array.js           # Exercício de manipulação de arrays
│           ├── array2.js          # Exercício avançado de arrays
│           ├── ex5.js             # Exercício 5 - Laços e acumuladores
│           └── ex6.js             # Exercício 6 - Contadores e loops
│
├── BCD/
│   └── Aula 03/
│       ├── MODELO_CONCEITUAL_ESCOLA.brM        # Modelo conceitual do sistema escolar
│       └── MODELOS_RELACIONAMENTOS_CONCEITUAL.brM # Modelos de relacionamentos
│
├── LIMA/
│   ├── Aula 02/                   # Exercícios básicos de HTML5
│   │   ├── index.html             # Exercício de tags HTML e formatação
│   │   └── equipe.html            # Página de apresentação da equipe
│   │
│   └── Projeto/                   # Projeto SmartCoffee - Cafeteria
│       ├── index.html             # Página inicial da cafeteria
│       ├── clientes.html          # Página de gerenciamento de clientes
│       ├── delivery.html          # Página de serviço de delivery
│       ├── estoque.html           # Página de controle de estoque
│       ├── funcionarios.html      # Página de gerenciamento de funcionários
│       ├── pagamento.html         # Página de processamento de pagamento
│       ├── pedidos.html           # Página de gerenciamento de pedidos
│       ├── produtos.html          # Página de catálogo de produtos
│       └── progamadefidelidade.html # Página do programa de fidelidade
│
└── README.md                      # Este arquivo

```

## 📝 Resumo dos Exercícios

### Backend - Aula 02 (JavaScript/Node.js)

#### Pasta: Lacos/

**array.js**
- Demonstração básica de arrays em JavaScript
- Acesso a elementos de um array por índice
- Conceito: Declaração e indexação de arrays

**array2.js**
- Sistema de controle de qualidade com pesagem de peças
- Operações avançadas com arrays: `.push()` para armazenar dados
- Uso de acumuladores para somar valores
- Cálculo de média de um lote de peças
- Conceitos: Arrays como histórico, acumuladores, operações matemáticas

**ex5.js**
- Exercício com laços `while` e validação de entrada
- Uso da biblioteca `readline-sync` para entrada interativa
- Acumulador de valores com validação (aceita apenas valores positivos)
- Formatação de números decimais com `.toFixed(2)`
- Conceitos: Validação de entrada, acumuladores, formatação de dados

**ex6.js**
- Exercício simples de loop contador
- Uso de `while` para iteração com incremento
- Exibição de sequência numérica no console
- Conceitos: Contadores, laços de repetição

### BCD - Aula 03 (Banco de Dados)

**MODELO_CONCEITUAL_ESCOLA.brM**
- Modelo conceitual de um sistema escolar
- Definição de entidades e suas características principais
- Exercício de modelagem de dados abstrata

**MODELOS_RELACIONAMENTOS_CONCEITUAL.brM**
- Modelos conceituais focados em relacionamentos entre entidades
- Definição de cardinalidade entre entidades
- Exercício de compreensão de relacionamentos em banco de dados

### LIMA - Aula 02 (HTML5 Básico)

**index.html**
- Exercício de tags HTML5 fundamentais
- Uso de títulos (h1, h2, etc.)
- Tags de formatação de texto: `<b>`, `<i>`, `<u>`, `<mark>`
- Tags especiais: `<abbr>`, `<pre>`, `<code>` para exibir código
- Conceitos: Semântica HTML, formatação de texto, abreviações

**equipe.html**
- Página de apresentação da equipe

### LIMA - Projeto (SmartCoffee)

**SmartCoffee - Sistema de Gerenciamento de Cafeteria**

Um projeto integrado que simula um sistema web para gerenciamento de uma cafeteria chamada "SmartCoffee - Cafetando com Isa".

**Componentes principais:**

- **index.html** - Página inicial/home da cafeteria com apresentação
- **clientes.html** - Módulo de gerenciamento de dados de clientes
- **produtos.html** - Catálogo e gerenciamento de produtos disponíveis
- **pedidos.html** - Sistema de gestão de pedidos dos clientes
- **estoque.html** - Controle e monitoramento de estoque
- **funcionarios.html** - Gerenciamento de dados dos funcionários
- **pagamento.html** - Sistema de processamento de pagamentos
- **delivery.html** - Módulo de gerenciamento de entregas
- **progamadefidelidade.html** - Programa de fidelidade para clientes

**Conceitos abordados no projeto:**
- Navegação entre páginas com links `<a href>`
- Estrutura HTML5 completa com DOCTYPE, meta tags responsivas
- Organização modular de funcionalidades em diferentes páginas
- Prototipagem de interface para sistema de gerenciamento

## 🚀 Como Executar os Arquivos

### Executar Exercícios JavaScript (Backend/Aula 02)

#### Pré-requisitos
- Node.js instalado no computador
- Terminal/Prompt de comando

#### Instalação de Dependências

```bash
# Navegue até a pasta Backend/Aula 02/
cd Backend/Aula\ 02/

# Instale as dependências (readline-sync)
npm install
```

#### Executar um Arquivo JavaScript

```bash
# Exemplo: executar o arquivo array.js
node Lacos/array.js

# Exemplo: executar o arquivo array2.js (Sistema de Pesagem)
node Lacos/array2.js

# Exemplo: executar o arquivo ex5.js (Entrada interativa)
node Lacos/ex5.js

# Exemplo: executar o arquivo ex6.js (Contador)
node Lacos/ex6.js
```

#### Exemplo de Saída

Para `array2.js`:
```
=== SISTEMA DE CONTROLE DE QUALIDADE - PESAGEM ===
Quantas pecas deseja avaliar? 3
Digite o peso da peca 1 (kg): 2.5
Digite o peso da peca 2 (kg): 2.7
Digite o peso da peca 3 (kg): 2.6

--- RELATORIO DA AUDITORIA ---
Pesos registrados: [ 2.5 kg | 2.7 kg | 2.6 kg ]
Media de peso do lote: 2.60 kg
```

### Visualizar Arquivos HTML (LIMA)

#### Aula 02
```bash
# Abra o arquivo no navegador (duplo-clique ou arraste para o navegador)
LIMA/Aula 02/index.html
LIMA/Aula 02/equipe.html
```

#### Projeto SmartCoffee
```bash
# Comece pela página inicial
LIMA/Projeto/index.html

# Depois navegue para outras páginas usando os links
```

### Visualizar Modelos de Banco de Dados (BCD)

Os arquivos `.brM` devem ser abertos com a ferramenta **brModeler** ou similar:
- BrModeler (gratuito) - https://www.brmodelolotensaouml.com.br/
- Ou outra ferramenta de modelagem que suporte o formato brM

```bash
# Abra os arquivos com brModeler
BCD/Aula 03/MODELO_CONCEITUAL_ESCOLA.brM
BCD/Aula 03/MODELOS_RELACIONAMENTOS_CONCEITUAL.brM
```

## 📚 Instruções de Git

### Configuração Inicial (primeira vez)

```bash
# Clonar o repositório
git clone <url-do-repositorio>

# Entrar na pasta do projeto
cd 2termo

# Verificar o status
git status
```

### Workflow Git Básico

```bash
# 1. Ver o status das mudanças
git status

# 2. Adicionar arquivos para staging
git add .                    # Adiciona todos os arquivos
# ou
git add <caminho-do-arquivo> # Adiciona um arquivo específico

# 3. Criar um commit com mensagem
git commit -m "Descrição das mudanças realizadas"

# 4. Enviar para o repositório remoto
git push origin main
# ou (dependendo do nome da branch)
git push origin master

# 5. Trazer as alterações do repositório remoto
git pull origin main
```

### Exemplo de Workflow Completo

```bash
# Fazer uma alteração no arquivo
echo "Alteração no arquivo" >> Backend/Aula\ 02/Lacos/array.js

# Verificar status
git status

# Adicionar a mudança
git add Backend/Aula\ 02/Lacos/array.js

# Fazer commit
git commit -m "Atualização do exercício array.js"

# Enviar para o repositório remoto
git push origin main
```

### Comandos Git Úteis

```bash
# Ver histórico de commits
git log

# Ver diferenças entre versões
git diff

# Desfazer a última mudança não commitada
git checkout -- <arquivo>

# Desfazer o último commit (mantendo as mudanças)
git reset --soft HEAD~1

# Ver branches disponíveis
git branch

# Criar e alternar para uma nova branch
git checkout -b nome-da-branch

# Alternar entre branches
git checkout nome-da-branch

# Mesclar uma branch na branch atual
git merge nome-da-branch
```

## 👤 Autor

**Isabella Alves do Carmo Cleto**

---

## 📖 Notas Importantes

- Todos os exercícios JavaScript requerem Node.js para execução
- A biblioteca `readline-sync` é necessária para os exercícios que requerem entrada interativa
- Os arquivos HTML podem ser visualizados diretamente em navegadores modernos (Chrome, Firefox, Edge, Safari)
- Os modelos de banco de dados (`.brM`) requerem a ferramenta brModeler ou compatível para visualização adequada
- O projeto segue a estrutura padrão de organização por disciplina e aula

## 📞 Suporte

Para dúvidas ou problemas na execução:
1. Verifique se o Node.js está instalado: `node --version`
2. Verifique se as dependências foram instaladas: `npm list`
3. Certifique-se de estar no diretório correto antes de executar comandos

---

**Última atualização:** 2026-08-13
