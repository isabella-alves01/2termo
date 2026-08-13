
const entrada = require("readline-sync");
let total=0;
let preco = -1;


while (preco !==0){
    preco = entrada.question.Float("preco: R$")
}
    if(preco!=0) {
        total==preco;
        console.log(`Subtotal: R$ ${total.toFixed(2)}`);

    }

    // total.tofixed = Ele serve para o numero ter duas casas decimais 
    // let = Armazena a palavra, que nao pode ser modificada depois 
    // != = Diferente de 
