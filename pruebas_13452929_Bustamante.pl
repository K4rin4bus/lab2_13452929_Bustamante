% archivo con listado de consultas

option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1),
option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2),
flow(1, "Flujo 1: mensaje de prueba", [ ], F1),
flow(2, "Flujo 1: mensaje de prueba", [O1, O2, O2], F2),
flowAddOption(F1, O1, F3),
chatbot(0, "Asistente", "Bienvenido ¿Qué te gustaría hacer?", 1, [F1, F2, F1], CB),
system("NewSystem", 0, [ ], S0),
system("NewSystem", 1, [CB], S1),
systemAddChatbot(S0, CB, S2),
systemAddUser(S1, “user0”, S2),
systemAddUser(S2, “user1”, S3).

