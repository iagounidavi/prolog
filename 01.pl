% Iago Artner

% Definição de sintomas
sintoma(febre).
sintoma(tosse).
sintoma(cansaco).
sintoma(dor_de_cabeca).
sintoma(dor_de_garganta).
sintoma(dor_muscular).

% Associação de sintomas a doenças
doenca(gripe, [febre, tosse, cansaco]).
doenca(infeccao_viral, [febre, dor_de_garganta, dor_muscular]).
doenca(enxaqueca, [dor_de_cabeca, cansaco]).

% Coletar sintomas
diagnosticar :-
    write('Bem-vindo ao sistema especialista de diagnóstico médico!'), nl,
    write('Por favor, responda com "sim." ou "nao." para os seguintes sintomas:'), nl,
    verificar_sintomas(SintomasColetados),
    deduzir_doenca(SintomasColetados).

% Questiona sobre sintomas
verificar_sintomas(SintomasColetados) :-
    findall(S, sintoma(S), TodosSintomas),
    perguntar_sintomas(TodosSintomas, SintomasColetados).

perguntar_sintomas([], []). % Base: sem mais sintomas para perguntar.
perguntar_sintomas([S|Resto], [S|Sintomas]) :-
    format('Você está com ~w? ', [S]),
    read(Resposta),
    Resposta == sim, % Adiciona o sintoma à lista se o usuário confirmar.
    perguntar_sintomas(Resto, Sintomas).
perguntar_sintomas([_|Resto], Sintomas) :-
    perguntar_sintomas(Resto, Sintomas). % Passa para o próximo sintoma.

% Aponta a doença
deduzir_doenca(Sintomas) :-
    (   doenca(Doenca, SintomasNecessarios),
        eh_subset(SintomasNecessarios, Sintomas) % Verifica se os sintomas necessários estão presentes
    ->  format('O diagnóstico provável é: ~w.', [Doenca]), nl
    ;   write('Não foi possível identificar a condição. Recomendamos consultar um médico.'), nl
    ).

% Verifica se uma lista é subconjunto de outra
eh_subset([], _). % Base: Lista vazia é subconjunto de qualquer lista.
eh_subset([H|T], Lista) :-
    member(H, Lista), % Verifica se o elemento H está presente na lista.
    eh_subset(T, Lista). % Continua verificando os outros elementos.
