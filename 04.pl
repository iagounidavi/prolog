% Iago Artner

% Treinos e objetivos
exercicio('Supino Reto', hipertrofia, '3 séries de 10 repetições com peso moderado.').
exercicio('Agachamento Livre', hipertrofia, '4 séries de 8 repetições com carga progressiva.').
exercicio('Corrida na Esteira', perda_de_peso, '30 minutos em ritmo moderado.').
exercicio('Circuito Funcional', condicionamento, '20 minutos com exercícios variados de alta intensidade.').
exercicio('Remada Curvada', hipertrofia, '3 séries de 12 repetições com carga moderada.').
exercicio('Abdominal', perda_de_peso, '4 séries de 20 repetições.').

% Regras de recomendação
treino(hipertrofia) :-
    objetivo(ganhar_massa),
    experiencia(intermediario).

treino(perda_de_peso) :-
    objetivo(emagrecer),
    disponibilidade(tempo_limitado).

treino(condicionamento) :-
    objetivo(condicionamento_fisico),
    experiencia(basico).

% Coletar dados
recomendar_treino :-
    write('Bem-vindo ao sistema especialista de recomendação de treinos!'), nl,
    write('Por favor, responda às perguntas a seguir:'), nl,
    perguntar_objetivo(Objetivo),
    perguntar_experiencia(Experiencia),
    perguntar_disponibilidade(Disponibilidade),
    sugerir_treino(Objetivo, Experiencia, Disponibilidade).

% Pergunta sobre objetivo
perguntar_objetivo(Objetivo) :-
    write('Qual é o seu objetivo? (ganhar_massa, emagrecer, condicionamento_fisico): '),
    read(Objetivo),
    assertz(objetivo(Objetivo)).

% Pergunta sobre experiência
perguntar_experiencia(Experiencia) :-
    write('Qual é a sua experiência na academia? (basico, intermediario, avancado): '),
    read(Experiencia),
    assertz(experiencia(Experiencia)).

% Pergunta sobre disponibilidade de tempo
perguntar_disponibilidade(Disponibilidade) :-
    write('Quanto tempo você tem disponível? (tempo_limitado, tempo_moderado, tempo_amplo): '),
    read(Disponibilidade),
    assertz(disponibilidade(Disponibilidade)).

% Sugere treino baseado nas respostas
sugerir_treino(Objetivo, Experiencia, Disponibilidade) :-
    (   treino(Tipo),
        objetivo(Objetivo),
        experiencia(Experiencia),
        disponibilidade(Disponibilidade),
        write('Treino recomendado: '), write(Tipo), nl,
        listar_exercicios(Tipo)
    ;   write('Não foi possível encontrar um treino ideal para suas preferências. Tente ajustar suas respostas.'), nl
    ).

% Lista exercícios do treino recomendado
listar_exercicios(Tipo) :-
    findall((Nome, Detalhes),
        exercicio(Nome, Tipo, Detalhes),
        Exercicios),
    write('Aqui estão os exercícios recomendados:'), nl,
    listar(Exercicios).

% Lista auxiliar para exibir exercícios
listar([]).
listar([(Nome, Detalhes)|Resto]) :-
    format('Exercício: ~w~nInstruções: ~w~n~n', [Nome, Detalhes]),
    listar(Resto).