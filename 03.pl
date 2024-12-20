% Livros categorizados por gênero e tópicos
livro('1984', ficcao, [politica], 'Um clássico distópico que explora os perigos de regimes totalitários.').
livro('Sapiens', historia, [ciencia, humanidade], 'Uma breve história da humanidade e sua evolução.').
livro('O Poder do Hábito', autoajuda, [psicologia, produtividade], 'Entenda como os hábitos moldam nossas vidas e como mudá-los.').
livro('Dom Quixote', ficcao, [aventura, classico], 'As desventuras cômicas de um cavaleiro idealista.').
livro('A Origem das Espécies', ciencia, [evolucao, biologia], 'A obra fundamental de Charles Darwin sobre a teoria da evolução.').

% Coleta de preferências
recomendar :-
    write('Bem-vindo ao sistema especialista de recomendação de livros!'), nl,
    write('Por favor, escolha seus gêneros favoritos.'), nl,
    selecionar_generos(GenerosEscolhidos),
    write('Agora, informe seus interesses.'), nl,
    selecionar_interesses(InteressesEscolhidos),
    (InteressesEscolhidos = [] -> 
        write('Você não selecionou nenhum interesse. Por favor, tente novamente!'), nl;
        sugerir_livros(GenerosEscolhidos, InteressesEscolhidos)
    ).

% Coleta de gêneros favoritos
selecionar_generos(Generos) :-
    findall(G, livro(_, G, _, _), TodosGeneros),
    sort(TodosGeneros, GenerosUnicos),
    perguntar_opcoes(GenerosUnicos, Generos, 'gênero').

% Coleta de tópicos de interesse
selecionar_interesses(Interesses) :-
    findall(I, livro(_, _, I, _), TodosInteresses),
    flatten(TodosInteresses, InteressesUnicos),
    sort(InteressesUnicos, InteressesUnicosOrdenados),
    perguntar_opcoes(InteressesUnicosOrdenados, Interesses, 'interesse').

% Coleta de múltiplas opções (gênero ou interesse)
perguntar_opcoes([], [], _).
perguntar_opcoes([O|Resto], [O|Escolhidos], Tipo) :-
    format('Você gosta de ~w (~w)? ', [O, Tipo]),
    read(Resposta),
    (Resposta == sim -> perguntar_opcoes(Resto, Escolhidos, Tipo);
     perguntar_opcoes(Resto, Escolhidos, Tipo)).
perguntar_opcoes([_|Resto], Escolhidos, Tipo) :-
    perguntar_opcoes(Resto, Escolhidos, Tipo).

% Implementação manual da interseção de listas
intersection_manual([], _, []).
intersection_manual([X|XS], Y, [X|Z]) :-
    member(X, Y),  % Verifica se X está na lista Y
    intersection_manual(XS, Y, Z).
intersection_manual([_|XS], Y, Z) :-
    intersection_manual(XS, Y, Z).

% Verifica se algum interesse está presente nos tópicos do livro
interesses_comum(Topicos, Interesses) :-
    intersection_manual(Topicos, Interesses, Intersecao),
    Intersecao \= [].

% Sugere livros com base nas preferências do usuário
sugerir_livros(Generos, Interesses) :-
    findall((Titulo, Sinopse),
        (   livro(Titulo, Genero, Topicos, Sinopse),
            member(Genero, Generos),              % Verifica o gênero
            interesses_comum(Topicos, Interesses)  % Verifica os interesses
        ),
        LivrosRecomendados),
    sort(LivrosRecomendados, LivrosRecomendadosSemDuplicatas), % Remove duplicatas
    (   LivrosRecomendadosSemDuplicatas \= []
    ->  write('Aqui estão os livros recomendados para você:'), nl,
        listar_livros(LivrosRecomendadosSemDuplicatas)
    ;   write('Não encontramos livros que correspondam aos seus interesses. Tente novamente!'), nl
    ).

% Lista os livros recomendados
listar_livros([]).
listar_livros([(Titulo, Sinopse)|Resto]) :-
    format('Título: ~w~nSinopse: ~w~n~n', [Titulo, Sinopse]),
    listar_livros(Resto).
