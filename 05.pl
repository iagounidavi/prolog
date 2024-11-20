% Iago Artner

% Base de fatos: evidências, testemunhos e relações
evidencia(impressao_digital, lugar_crime, jose).
evidencia(motivo, financeiro, jose).
evidencia(testemunha, visto_discutindo, maria).
evidencia(relacao, intima, maria).
evidencia(alibi, ausente, carlos).
evidencia(impressao_digital, arma_crime, ana).

% Regras para suspeitos e teorias
suspeito(jose) :-
    evidencia(impressao_digital, lugar_crime, jose),
    evidencia(motivo, financeiro, jose).

suspeito(ana) :-
    evidencia(impressao_digital, arma_crime, ana).

suspeito(maria) :-
    evidencia(testemunha, visto_discutindo, maria),
    evidencia(relacao, intima, maria).

teoria(crime_passional) :-
    evidencia(testemunha, visto_discutindo, Alvo),
    evidencia(relacao, intima, Alvo).

teoria(crime_planejado) :-
    evidencia(impressao_digital, arma_crime, Suspeito),
    evidencia(alibi, ausente, Suspeito).

% Menu interativo
menu :-
    write('===== Sistema de Análise Criminal ====='), nl,
    write('Escolha uma opção:'), nl,
    write('1. Registrar evidências'), nl,
    write('2. Consultar suspeitos'), nl,
    write('3. Consultar teorias do crime'), nl,
    write('4. Sair'), nl,
    read(Opcao),
    executar_opcao(Opcao).

% Execução de opções do menu
executar_opcao(1) :-
    registrar_evidencias,
    menu.
executar_opcao(2) :-
    consultar_suspeitos,
    menu.
executar_opcao(3) :-
    consultar_teorias,
    menu.
executar_opcao(4) :-
    write('Encerrando o sistema. Até mais!'), nl.
executar_opcao(_) :-
    write('Opção inválida. Tente novamente.'), nl,
    menu.

% Registrar novas evidências
registrar_evidencias :-
    write('Digite o tipo de evidência (impressao_digital, motivo, testemunha, relacao, alibi): '), nl,
    read(Tipo),
    write('Digite o detalhe associado (ex: lugar_crime, financeiro, etc.): '), nl,
    read(Detalhe),
    write('Digite o nome relacionado à evidência: '), nl,
    read(Nome),
    assertz(evidencia(Tipo, Detalhe, Nome)),
    write('Evidência registrada com sucesso!'), nl.

% Consultar suspeitos
consultar_suspeitos :-
    write('Analisando suspeitos com base nas evidências...'), nl,
    findall(Suspeito, suspeito(Suspeito), Suspeitos),
    (   Suspeitos \= []
    ->  write('Suspeitos identificados:'), nl,
        listar(Suspeitos)
    ;   write('Nenhum suspeito identificado com as evidências atuais.'), nl
    ).

% Consultar teorias do crime
consultar_teorias :-
    write('Analisando teorias do crime com base nas evidências...'), nl,
    findall(Teoria, teoria(Teoria), Teorias),
    (   Teorias \= []
    ->  write('Teorias identificadas:'), nl,
        listar(Teorias)
    ;   write('Nenhuma teoria identificada com as evidências atuais.'), nl
    ).

% Listar elementos
listar([]).
listar([Elemento|Resto]) :-
    write('- '), write(Elemento), nl,
    listar(Resto).
