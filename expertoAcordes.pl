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
%%%%%%%%%Reglas%%%%%%%%%%%%%%%%%%%%
%despues_que(X,Y):-antes_que(Y,X).

intervalo_segunda_mayor(X,Z):-segunda_menor(X,Y),segunda_menor(Y,Z).
intervalo_segunda_aumentada(X,Z):-segunda_menor(X,Y),intervalo_segunda_mayor(Y,Z).
intervalo_tercera_menor(X,Z):-intervalo_segunda_mayor(X,Y),intervalo_segunda_mayor(Y,Z).
intervalo_tercera_mayor(X,Z):-segunda_menor(X,Y),intervalo_tercera_menor(Y,Z).
intervalo_cuarta_justa(X,Z):-segunda_menor(X,Y),intervalo_tercera_mayor(Y,Z).
intervalo_cuarta_aumentada(X,Z):-segunda_menor(X,Y),intervalo_cuarta_justa(Y,Z).
intervalo_quinta_disminuida(X,Z):-intervalo_tercera_menor(X,Y),intervalo_tercera_menor(Y,Z).
intervalo_quinta_justa(X,Z):-segunda_menor(X,Y),intervalo_quinta_disminuida(Y,Z).
intervalo_quinta_aumentada(X,Z):-segunda_menor(X,Y),intervalo_quinta_justa(Y,Z).
intervalo_sexta_menor(X,Z):-segunda_menor(X,Y),intervalo_quinta_aumentada(Y,Z).

acorde_mayor(X,Y,Z):-intervalo_tercera_menor(X,Y),intervalo_cuarta_aumentada(X,Z).
acorde_menor(X,Y,Z):-intervalo_segunda_aumentada(X,Y),intervalo_cuarta_aumentada(X,Z).
acorde_septima(X,Y,Z,W):-acorde_mayor(X,Y,Z),intervalo_sexta_menor(X,W).
acorde_septima(X,Y,Z,W):-acorde_menor(X,Y,Z),intervalo_sexta_menor(X,W).
acorde_mayor_sexta(X,Y,Z,W):-intervalo_tercera_menor(X,Y),intervalo_tercera_mayor(X,Z),intervalo_quinta_justa(X,W).
acorde_menor_sexta(X,Y,Z,W):-intervalo_segunda_aumentada(X,Y),intervalo_tercera_mayor(X,Z),intervalo_quinta_justa(X,W).

%%%%%%%%%%%%%%% CLI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acorde(X,Y,Z,Nombre):-acorde_mayor(X,Y,Z),swritef(Nombre, '%2L%w', [X, 'Mayor']).
acorde(X,Y,Z,Nombre):-acorde_menor(X,Y,Z),swritef(Nombre, '%2L%w', [X, 'Menor']).
%recursivodad con problemas en producción
acorde(X,Y,Z,Nombre):-acorde(Y,X,Z,Nombre),!|acorde(Z,X,Y,Nombre),!|acorde(Z,Y,X,Nombre),!|acorde(X,Z,Y,Nombre),!.

%transposiciones

acorde(X,Y,Z,W,Nombre):-acorde_mayor_sexta(X,Y,Z,W),swritef(Nombre, '%2L%w', [X, 'Mayor Sexta']).
acorde(X,Y,Z,W,Nombre):-acorde_menor_sexta(X,Y,Z,W),swritef(Nombre, '%2L%w', [X, 'Menor Sexta']).

acorde(X,Y,Z,W,Nombre):-acorde(X,Y,Z,Nombre1),acorde_septima(X,Y,Z,W),swritef(Nombre, '%2L%w', [Nombre1, 'Séptima']).
%acorde(X,Y,Z,W,Nombre):-acorde_mayor_septima(X,Y,Z,W),swritef(Nombre, '%2L%w', [X, 'Séptima Mayor']).
%acorde(X,Y,Z,W,Nombre):-acorde_menor_septima(X,Y,Z,W),swritef(Nombre, '%2L%w', [X, 'Séptima Menor']).
