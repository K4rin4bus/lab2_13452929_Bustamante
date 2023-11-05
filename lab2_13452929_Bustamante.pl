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

%====================================================================%
% RF3: TDA Flow - constructor
%====================================================================%
% Predicado: flow/4
% Dom: id (int) X name-msg (String)  X Option  (Lista de 0 o maa opciones) X Flow
% Meta Primaria: flow/4
% Meta Secundaria: addWithoutDuplicates/3
flow(Id, NameMsg, Options, [Id, NameMsg, OptionsWithoutDuplicates]) :-
    addWithoutDuplicates(Options, [], OptionsWithoutDuplicates).

noPertenece(Elemento, Lista) :-
    \+ member(Elemento, Lista).

% Caso base, lista vacia devuelve otra lista vacia
addWithoutDuplicates([], ListaInputAcc, ListaInputAcc).

% Si la cabeza (Elemento) no esta en la lista de salida, se agrega
addWithoutDuplicates([Elemento|Resto], ListaInputAcc, ListaOutput) :-
    noPertenece(Elemento, ListaInputAcc),
    addWithoutDuplicates(Resto, [Elemento|ListaInputAcc], ListaOutput).

% Si la cabeza (Elemento) ya esta en la lista de salida, se omite
addWithoutDuplicates([Elemento|Resto], ListaInputAcc, ListaOutput) :-
    member(Elemento, ListaInputAcc),
    addWithoutDuplicates(Resto, ListaInputAcc, ListaOutput).

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
% RF5: TDA chatbot - constructor
%====================================================================%
% Predicado: chatbot/6
% Dom: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows (Lista de 0 o mas flujos) X chabot
% Meta Primaria: chatbot/6
% Meta Secundaria: addWithoutDuplicates/3
chatbot(ChatbotId, Name, WelcomeMsg, StartFlowId, Flows, [ChatbotId, Name, WelcomeMsg, StartFlowId, FlowsWithoutDuplicates]) :-
    addWithoutDuplicates(Flows, [], FlowsWithoutDuplicates).

%====================================================================%
% RF6: TDA chatbot - modificador
%====================================================================%
% Predicado: chatbotAddFlow/3
% Dom: chatbot X flow X chatbot
% Meta Primaria: chatbotAddFlow/3
% Meta Secundaria: chatbot/6, addFlowToChatBot/3

% agregar flujo a los flujos del ChatBot
addFlowToChatBot(Flow, ListaFlows, NewListaFlows) :-
    agregarAlPrincipio(Flow, ListaFlows, NewListaFlows).

chatbotAddFlow(ChatBotInput, NewFlowInput, NewChatBotFlow) :-
    % debemos llamar al constructor de ChatBot, tomo los valores del ChatBot que me llega
    chatbot(CbIdInput, NameInput, WelcomeMsgInput, StartFlowIdInput, FlowsInput, ChatBotInput),
    % agregar flujo a los flujos del ChatBot, devuelve lista de flujos con flujo nuevo
    addFlowToChatBot(NewFlowInput, FlowsInput, NewFlows),
    % llamar al constructor con el Chatbot con nuevos flujos
    chatbot(CbIdInput, NameInput, WelcomeMsgInput, StartFlowIdInput, NewFlows, NewChatBotFlow).
	






%====================================================================%
% RFX: TDA 
%====================================================================%
% Predicado: 
% Dom: 
% Meta Primaria: 
% Meta Secundaria:


% Consulta:

