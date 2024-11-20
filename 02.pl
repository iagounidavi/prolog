% Iago Artner

% Sintomas comuns em veículos
sintoma(motor_nao_liga).
sintoma(luzes_fracas).
sintoma(barulho_ao_frear).
sintoma(pedal_freio_macio).
sintoma(vazamento_oleo).
sintoma(superaquecimento).

% Associação de sintomas aos problemas
problema(bateria_fraca, [motor_nao_liga, luzes_fracas]).
problema(freio_desgastado, [barulho_ao_frear, pedal_freio_macio]).
problema(vazamento_sistema, [vazamento_oleo]).
problema(superaquecimento_motor, [superaquecimento]).

% Regras para os problemas identificados
solucao(bateria_fraca, 'Verifique a bateria e o sistema de recarga. Substitua a bateria se necessário.').
solucao(freio_desgastado, 'Inspecione as pastilhas de freio e substitua se estiverem gastas.').
solucao(vazamento_sistema, 'Verifique o nível de óleo e inspecione por vazamentos evidentes.').
solucao(superaquecimento_motor, 'Verifique o nível de fluido de arrefecimento e o funcionamento do radiador.').

% Regra para problemas sem associação
recomendacao_segura('Este problema pode ser grave. Leve o veículo a um mecânico imediatamente.').

% Coleta de sintomas
diagnosticar :-
    write('Bem-vindo ao sistema especialista de análise de problemas de veículos!'), nl,
    write('Por favor, responda com "sim." ou "nao." para os seguintes sintomas:'), nl,
    verificar_sintomas(SintomasColetados),
    deduzir_problema(SintomasColetados).

% Pergunta ao usuário sobre os sintomas
verificar_sintomas(SintomasColetados) :-
    findall(S, sintoma(S), TodosSintomas),
    perguntar_sintomas(TodosSintomas, SintomasColetados).

perguntar_sintomas([], []). % Base: sem mais sintomas para perguntar.
perguntar_sintomas([S|Resto], [S|Sintomas]) :-
    format('Seu veículo apresenta ~w? ', [S]),
    read(Resposta),
    Resposta == sim, % Adiciona o sintoma à lista se o usuário confirmar.
    perguntar_sintomas(Resto, Sintomas).
perguntar_sintomas([_|Resto], Sintomas) :-
    perguntar_sintomas(Resto, Sintomas). % Passa para o próximo sintoma.

% Processa e sugere solução
deduzir_problema(Sintomas) :-
    (   problema(P, SintomasNecessarios),
        eh_subset(SintomasNecessarios, Sintomas) % Verifica se os sintomas necessários estão presentes
    ->  format('O problema identificado é: ~w', [P]), nl,
        solucao(P, Solucao),
        format('Solução recomendada: ~w', [Solucao]), nl
    ;   recomendacao_segura(Seg),
        write('Não foi possível identificar o problema.'), nl,
        format('~w', [Seg]), nl
    ).

% Verifica se uma lista é subconjunto de outra
eh_subset([], _). % Base: Lista vazia é subconjunto de qualquer lista.
eh_subset([H|T], Lista) :-
    member(H, Lista), % Verifica se o elemento H está presente na lista.
    eh_subset(T, Lista). % Continua verificando os outros elementos.
