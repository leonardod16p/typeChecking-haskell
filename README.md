# Bidirectional Type Checker (STLC) em Haskell
### Motivação

Meu interesse por fundamentos da matemática e assistentes de prova me levaram a estudar cálculo lambda e teoria de tipos. Achei que seria interessante lidar com algo concreto durante o processo de aprendizado. A programação funcional tende a ser o berço desses conceitos.

Num primeiro momento, voltei a minha atenção para Haskell. O sistema de tipos dessa linguagem serve como ferramenta de modelagem teórica para estabelecer zonas previsíveis de comportamento de software.

Para entender como isso funciona toda essa fundamentação na linguagem, decidi construir um Type Checker Bidirecional para um Cálculo Lambda Simplesmente Tipado (STLC). O desenvolvimento foi guiado pelo tutorial “Bidirectional Typing Rules: A Tutorial”, de David Raymond Christiansen.

### O que foi Implementado

O projeto consiste em um interpretador de tipos que valida expressões matemáticas baseadas em regras lógicas. O foco não é a avaliação do resultado (execução), mas a verificação da corretude dos tipos (semântica estática).

O sistema suporta:

- Tipos Base: Bool (com literais True e False).

- Abstrações: Funções Lambda (\x. body).

- Aplicação: Aplicação de função (f x).

- Controle de Fluxo: Condicional If Then Else.

- Anotações de Tipo: Sintaxe para explicitar tipos (expr : Type), essenciais para alternar entre modos de inferência e checagem.

### Estrutura do Código

O projeto foi dividido em 4 arquivos principais:

1. Definições: A definição de Expr (Expressão) e Type (Tipo);
2. TypeChecker: A lógica de verificação de tipos;
3. Parser: O interpretador das expressões;
4. Main: O arquivo principal, que realiza os testes com inputs para verificar o funcionamento.


### Aprendizados e Reflexões

Esse projeto explora talvez o que há de mais poderoso na linguagem Haskell:

- Parsing: Parece que Haskell foi desenhado para fazer parsers.
- Contexto Funcional e Curiosidade: O fato de estar programando em uma linguagem funcional de tipagem estática forte (Haskell) naturalmente levanta questões sobre seu funcionamento interno. Esse contexto me obrigou a buscar entender como sistemas de tipos funcionam na prática.
- ADTs e Recursividade: O desenvolvimento exigiu a habilidade de lidar com ADTs (Abstract Data Types) e pensar em definições construídas de maneira recursiva.
- Compiladores: Ao lidar com a implementação e pensar em como expressões são parseadas, ganha-se uma ideia concreta de como os compiladores funcionam.





