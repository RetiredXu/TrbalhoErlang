-module(consumidor).
-export([start/2]).

start(Name, Buffer) ->
    %% Mensagem de console para inicialização do consumidor
    io:format("[Consumidor] - Consumidor iniciado ~n"),
    loop(Name, Buffer).

loop(Name, Buffer) ->
    %% Envia uma mensagem ao buffer para consumir um item
    Buffer ! {consumidor, self()},
    receive
        {consumidor, Item} ->
            io:format("[~p] - Item Consumido: ~p~n", [Name, Item]),

            %% Temporizador
            io:format("[~p] - Temporizador de ~p iniciado~n", [Name, Item]),
            timer:sleep(Item),
            io:format("[~p] - Temporizador de ~p finalizado~n", [Name, Item]);

        {empty} ->
            io:format("[~p] - Buffer Está Vazio~n", Name)
    end,
    loop(Name, Buffer).
