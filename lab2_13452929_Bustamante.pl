% Archivo de Laboratorio 2 - Prolog


% RF1
% TDAs

%====================================================================%
% RF2: TDA Option - constructor
%====================================================================%
% Predicado: option/6
% Dom: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o mas palabras claves) X Option
% Meta Primaria: option/6
% Meta Secundaria: 
option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keyword, [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keyword]).
% ver como agregar opciones sin duplicado

%====================================================================%
% RF3: TDA Flow - constructor
%====================================================================%
% Predicado: flow/4
% Dom: id (int) X name-msg (String)  X Option  (Lista de 0 o maa opciones) X Flow
% Meta Primaria: flow/4
% Meta Secundaria: 
flow(Id, NameMsg, Option, [Id, NameMsg, Option]).
% ver como agregar flujos sin duplicado

%====================================================================%
% RF4: TDA Flow - modificador
%====================================================================%
% Predicado: flowAddOption/3
% Dom: flow X option X flow
% Meta Primaria: flowAddOption/3
% Meta Secundaria: flow/4, addOptionToOptions/3

agregarAlPrincipio(Elemento, ListaInput, [Elemento | ListaInput]).

% agregar opcion a las opciones de los flujos
addOptionToOptions(Option, ListaOptions, NewListaOptions) :-
    agregarAlPrincipio(Option, ListaOptions, NewListaOptions).

flowAddOption(FlowInput, NewOptionInput, NewFlow):-
    % debemos llamar al constructor de flow, tomo los valores del flujo que me llega
    flow(IdInput, NameMsgInput, OptionsInput, FlowInput),
    % agregar opcion a las opciones de los flujos, devuelve lista de opciones con option nueva
    addOptionToOptions(NewOptionInput, OptionsInput, NewOptions),
    % llamar al constructor con el flujo con nuevas opciones
    flow(IdInput, NameMsgInput, NewOptions, NewFlow).

%====================================================================%
% RF5: TDA chatbot - constructor. 
%====================================================================%
% Predicado: 
% Dom: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows (Lista de 0 o más flujos) X chabot
% Meta Primaria: 
% Meta Secundaria:







%====================================================================%
% RFX: TDA 
%====================================================================%
% Predicado: 
% Dom: 
% Meta Primaria: 
% Meta Secundaria:
