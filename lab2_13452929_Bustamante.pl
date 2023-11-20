% Archivo de Laboratorio 2 - Prolog


% RF1
% TDAs

%====================================================================%
% TDA system - constructor
%====================================================================%
mySystem(Name, InitialChatbotCodeLink, Chatbots, Users, CurrentUser, [Name, InitialChatbotCodeLink, ChatbotsWithoutDuplicates, UsersWithoutDuplicates, CurrentUser]) :-
    addWithoutDuplicates(Chatbots, [], ChatbotsWithoutDuplicates),
    addWithoutDuplicates(Users, [], UsersWithoutDuplicates).
    

%El sistema además de contener los distintos chatbots, también contiene el chatHistory 
%de cada usuario que interactúa con el sistema. Sobre el chatHistory, éste corresponde 
%al registro completo del diálogo entre usuario y cada uno de los chatbots con los que interactúa. 
%El historial se mantiene para cada usuario y debe tener el String formateado de cada mensaje del usuario 
%y chatbot (para luego ser visualizado con el predicado write), fecha, hora y emisor (usuario o sistema).


%====================================================================%
% Agregar elementos a una lista Sin Duplicados
%====================================================================%

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

% elemento No pertenece a lista
noPertenece(Elemento, Lista) :-
    \+ member(Elemento, Lista).

%====================================================================%
% Agregar elementos al principio de una lista
%====================================================================%
agregarAlPrincipio(Elemento, ListaInput, [Elemento | ListaInput]).

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

%====================================================================%
% RF4: TDA Flow - modificador
%====================================================================%
% Predicado: flowAddOption/3
% Dom: flow X option X flow
% Meta Primaria: flowAddOption/3
% Meta Secundaria: flow/4, addOptionToOptions/3

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
    % llamo al constructor de ChatBot, tomo los valores del ChatBot que me llega
    chatbot(CbIdInput, NameInput, WelcomeMsgInput, StartFlowIdInput, FlowsInput, ChatBotInput),
    % agregar flujo a los flujos del ChatBot, devuelve lista de flujos con flujo nuevo
    addFlowToChatBot(NewFlowInput, FlowsInput, NewFlows),
    % llamar al constructor con el Chatbot con nuevos flujos
    chatbot(CbIdInput, NameInput, WelcomeMsgInput, StartFlowIdInput, NewFlows, NewChatBotFlow).
	
%====================================================================%
% RF7: TDA system - constructor
%====================================================================%
% Predicado: system/4
% Dom: name (string) X InitialChatbotCodeLink (Int) X chatbots (Lista de 0 o mas chatbots) X system
% Meta Primaria: system/4
% Meta Secundaria: mySystem/6
system(Name, InitialChatbotCodeLink, Chatbots, System) :-
    mySystem(Name, InitialChatbotCodeLink, Chatbots, [], " ", System).

%====================================================================%
% RF8: TDA system - modificador 
%====================================================================%
% Predicado: systemAddChatbot
% Dom: system X chatbot X system
% Meta Primaria: systemAddChatbot/3
% Meta Secundaria: mySystem/6, addChatBotToSystem/3

% agregar Cb a los ChatBots del System
addChatBotToSystem(ChatBot, ListaChatBots, NewListaChatBots) :-
    agregarAlPrincipio(ChatBot, ListaChatBots, NewListaChatBots).

systemAddChatbot(SystemInput, NewCBInput, NewSystemCB) :-
    % constructor de System, tomo valores del SystemInput
    mySystem(NameInput, InitialChatbotCodeLinkInput, ChatbotsInput, UsersInput, CurrentUserInput, SystemInput),
    % agregar CB a los ChatBots, devuelve lista de ChatBots con CB nuevo
    addChatBotToSystem(NewCBInput, ChatbotsInput, NewChatBots),
    % llamar al constructor con el System y el nuevo chatbots
    mySystem(NameInput, InitialChatbotCodeLinkInput, NewChatBots, UsersInput, CurrentUserInput,NewSystemCB).

%====================================================================%
% RF9: TDA system - modificador. 
%====================================================================%
% Predicado: systemAddUser/3
% Dom: system X user (string) X system
% Meta Primaria: systemAddUser
% Meta Secundaria: system/6, addUsersToSystem/3

% agregar nueva lista de usuarios al sistema
addUsersToSystem(User, ListaUsers, NuevaListaUsers) :-
     agregarAlPrincipio(User, ListaUsers, NuevaListaUsers).

% creando el usuario
systemAddUser(SystemInput, NewUserInput, NewSystem) :-
    mySystem(NameInput, InitialChatbotCodeLinkInput, ChatBotsInput, UsersInput, CurrentUserInput, SystemInput),
    addUsersToSystem(NewUserInput, UsersInput, NewListaUsers),
    mySystem(NameInput, InitialChatbotCodeLinkInput, ChatBotsInput, NewListaUsers, CurrentUserInput, NewSystem).

%====================================================================%
% RF10: TDA system - modificador. 
%====================================================================%
% Predicado: systemLogin/3
% Dom: system X user (string) X system
% Meta Primaria: systemLogin
% Meta Secundaria: 

systemLogin(SystemInput, NewUserInput, NewSystem) :-
	mySystem(NameInput, InitialChatbotCodeLinkInput, ChatBotsInput, UsersInput, _, SystemInput),
    pertenece(NewUserInput, UsersInput),
   % existeCurrentUser(CurrentUserInput),
    mySystem(NameInput, InitialChatbotCodeLinkInput, ChatBotsInput, UsersInput, NewUserInput, NewSystem).


%====================================================================%
% RF11: TDA system - modificador. 
%====================================================================%
% Predicado: systemLogout/2
% Dom: system X system
% Meta Primaria: systemLogout
% Meta Secundaria: 
%systemLogout(SystemInput, NewSystem).
    
%systemLogout(S4, S5).


%====================================================================%
% RFX: TDA 
%====================================================================%
% Predicado: 
% Dom: 
% Meta Primaria: 
% Meta Secundaria:


% Consulta: