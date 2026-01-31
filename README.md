# Motivação

Meu interesse por fundamentos da matemática e assistentes de prova me levaram a estudar cálculo lambda e teoria de tipos. Achei que seria interessante lidar com algo concreto durante o processo de aprendizado. A programação funcional tende a ser o berço desses conceitos. Num primeiro momento, voltei a minha atenção para Haskell. 
Apesar de o objetivo final ser Lean, parecia interessante ter um prelúdio em um nível mais simples (se comparado ao que acontece nesses assistentes de prova). 
Os sistemas de tipos são ferramentas de modelagem teórica para estabelecer zonas previsíveis de comportamento de software. 
Se conseguimos produzir um programa que se encaixa no nosso saber dos tipos envolvidos, temos a garantia do pleno funcionamento do programa em seu estado ideal. 
Haskell é uma linguagem de programação com um paradigma funcional puro, com tipagem estática e forte. Isso dá a Haskell mais poder teórico para produzir software bem comportado. 
Me baseei no tutorial em formato de artigo chamado “Bidirectional Typing Rules: A Tutorial”, de David Raymond Christiansen, para construir o type checker.

# Estrutura

O projeto foi dividido em 4 arquivos principais:

- a definição de Expr (Expressão) e Type (Tipo)

- o typeChecker

- o parser

- o arquivo principal, que realiza os testes com inputs para verificar o funcionamento
