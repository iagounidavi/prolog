% Iago Artner

% Definição de sintomas
sintoma(febre).
sintoma(tosse).
sintoma(cansaco).
sintoma(dor_de_cabeca).
sintoma(dor_de_garganta).
sintoma(dor_muscular).

% Associação de sintomas a doenças
doenca(gripe) :-
    sintoma(febre),
    sintoma(tosse),
    sintoma(cansaco).

doenca(infeccao_viral) :-
    sintoma(febre),
    sintoma(dor_de_garganta),
    sintoma(dor_muscular).

doenca(enxaqueca) :-
    sintoma(dor_de_cabeca),
    sintoma(cansaco).

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
    (   doenca(D), maplist(member, [febre, tosse, cansaco], Sintomas)
    ->  format('O diagnóstico provável é: ~w', [D]), nl
    ;   write('Não foi possível identificar a condição. Recomendamos consultar um médico.'), nl
    ).