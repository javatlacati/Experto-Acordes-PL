%%%%%%%%%%Base de datos%%%%%%%%%%%%
nota('C').
nota('C#').
nota('D').
nota('D#').
nota('E').
nota('F').
nota('F#').
nota('G').
nota('G#').
nota('A').
nota('A#').
nota('B').

%%%%% intervalos%%%%
% nombre   = distancia en tonos
% 2ª menor = 0.5
% 2ª Mayor = 1
% 3ª menor = 1.5
% 3ª Mayor = 2
% 4ª Justa = 2.5
% 4ª aum = 3.5
% 5ª Justa = 4
% 6ª menor = 4.5
% 6ª Mayor = 5
% 7ª menor = 5.5
% 7ª Mayor = 6
% 8ª Justa = 6.5

% Semitono 0.5
segunda_menor('C','C#').
segunda_menor('C#','D').
segunda_menor('D','D#').
segunda_menor('D#','E').
segunda_menor('E','F').
segunda_menor('F','F#').
segunda_menor('F#','G').
segunda_menor('G','G#').
segunda_menor('G#','A').
segunda_menor('A','A#').
segunda_menor('A#','B').
segunda_menor('B','C').

% segunda_mayor tambien es la novena mayor
segunda_mayor(Nota1,Nota3):-segunda_menor(Nota1,Nota2),segunda_menor(Nota2,Nota3).
tercera_menor(Nota1,Nota3):-segunda_menor(Nota1,Nota2),segunda_mayor(Nota2,Nota3).
tercera_mayor(Nota1,Nota3):-segunda_mayor(Nota1,Nota2),segunda_mayor(Nota2,Nota3).
cuarta_justa(Nota1,Nota3):-segunda_menor(Nota1,Nota2),tercera_mayor(Nota2,Nota3).
cuarta_aumentada(Nota1,Nota3):-segunda_menor(Nota1,Nota2),cuarta_justa(Nota2,Nota3).
quinta_justa(Nota1,Nota3):- segunda_menor(Nota1,Nota2),cuarta_aumentada(Nota2,Nota3).
sexta_menor(Nota1,Nota3):- segunda_menor(Nota1,Nota2),quinta_justa(Nota2,Nota3).
sexta_mayor(Nota1,Nota3):- segunda_menor(Nota1,Nota2),sexta_menor(Nota2,Nota3).
septima_menor(Nota1,Nota3):- segunda_menor(Nota1,Nota2),sexta_mayor(Nota2,Nota3).
septima_mayor(Nota1,Nota3):-segunda_menor(Nota1,Nota2),septima_menor(Nota2,Nota3).
octava_justa(Nota1,Nota3):- segunda_menor(Nota1,Nota2),septima_mayor(Nota2,Nota3).

%%tipos de acordes
acorde_mayor(Nota1,Nota2,Nota3):-tercera_mayor(Nota1,Nota2),quinta_justa(Nota1,Nota3).
acorde_menor(Nota1,Nota2,Nota3):-tercera_menor(Nota1,Nota2),quinta_justa(Nota1,Nota3).
acorde_mayor_septima(Nota1,Nota2,Nota3,Nota4):-acorde_mayor(Nota1,Nota2,Nota3),septima_mayor(Nota1,Nota4).
acorde_menor_septima(Nota1,Nota2,Nota3,Nota4):-acorde_menor(Nota1,Nota2,Nota3),septima_menor(Nota1,Nota4).
acorde_mayor_sexta(Nota1,Nota2,Nota3,Nota4):-tercera_mayor(Nota1,Nota2),quinta_justa(Nota1,Nota3),sexta_mayor(Nota1,Nota4).
acorde_menor_sexta(Nota1,Nota2,Nota3,Nota4):-tercera_menor(Nota1,Nota2),quinta_justa(Nota1,Nota3),sexta_mayor(Nota1,Nota4).
%Acorde disminuido: un acorde menor que incluye una quinta disminuida
%Acorde aumentado: un acorde mayor que incluye una quinta aumentada

%%%%%%%%%%%%%%% CLI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acorde(Nota1,Nota2,Nota3,Nombre):-acorde_mayor(Nota1,Nota2,Nota3),swritef(Nombre, '%2L%w', [Nota1, 'Mayor']).
acorde(Nota1,Nota2,Nota3,Nombre):-acorde_menor(Nota1,Nota2,Nota3),swritef(Nombre, '%2L%w', [Nota1, 'Menor']).
%recursivodad con problemas en producción
acorde(Nota1,Nota2,Nota3,Nombre):-acorde(Nota2,Nota1,Nota3,Nombre),!|acorde(Nota3,Nota1,Nota2,Nombre),!|acorde(Nota3,Nota2,Nota1,Nombre),!|acorde(Nota1,Nota3,Nota2,Nombre),!.

%transposiciones

acorde(Nota1,Nota2,Nota3,Nota4,Nombre):-acorde_mayor_sexta(Nota1,Nota2,Nota3,Nota4),swritef(Nombre, '%2L%w', [Nota1, 'Mayor Sexta']).
acorde(Nota1,Nota2,Nota3,Nota4,Nombre):-acorde_menor_sexta(Nota1,Nota2,Nota3,Nota4),swritef(Nombre, '%2L%w', [Nota1, 'Menor Sexta']).

acorde(Nota1,Nota2,Nota3,Nota4,Nombre):-acorde(Nota1,Nota2,Nota3,Nombre1),acorde_menor_septima(Nota1,Nota2,Nota3,Nota4),swritef(Nombre, '%2L%w', [Nombre1, 'Menor Séptima']).
acorde(Nota1,Nota2,Nota3,Nota4,Nombre):-acorde(Nota1,Nota2,Nota3,Nombre1),acorde_mayor_septima(Nota1,Nota2,Nota3,Nota4),swritef(Nombre, '%2L%w', [Nombre1, 'Mayor Séptima']).
%acorde(Nota1,Nota2,Nota3,Nota4,Nombre):-acorde_mayor_septima(Nota1,Nota2,Nota3,Nota4),swritef(Nombre, '%2L%w', [Nota1, 'Séptima Mayor']).
%acorde(Nota1,Nota2,Nota3,Nota4,Nombre):-acorde_menor_septima(Nota1,Nota2,Nota3,Nota4),swritef(Nombre, '%2L%w', [Nota1, 'Séptima Menor']).
