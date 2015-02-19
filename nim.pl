:-
	nl,
	write('The game of NIM by Gaurav Sheni'),
	nl,nl,
	write('To begin, please enter an input as such'),
	nl,nl,
	write('nim([7],0)'),
	nl,nl.
nim([ H | T ], 0):-
	pred1([ H | T ], 0, -1).
nim([ H | T ], 1):-
	pred1([ H | T ], 1, -1).

pred1([ H | T], 0, -1):-
	%N =:= 0,
	%do what I want
	%human turn
	nl,
	write('It is your turn.'),
	nl,
	write('The current piles are shown below.'),
	nl,
	write('Please Enter Pile Num, ex 1, 2, 3..., followed by a dot'),
	nl,
	write([H|T]),
	length([H|T],L),
	nl,
	read(X),
	X=<L, %make sure pile num is less than length of list
	X>0, %make sure given pile num is higher than 0
	nth1(X,[H|T], R), %puts element found in R, using index of given X
	write('Select first number to split into'),
	nl,
	read(Z),
	U is abs(Z - R),
	not(U=:=Z),
	removechosen([H|T],N,X), %remove the pile value of selected
	concat(NP2,Z,N), %add new value to list
	concat(NP3,U,NP2), %add second new value to list
	check(NP3, 1, F), %check if still good to play
	changeHF(F,NF), %if the check returns a -2, stop gameplay
	pred1(NP3,1,NF). %make other move or stop game playing, depending on check

pred1([H | T], 1, -1):-
	nl,
	write([H|T]),
	nl,
	write('It is the computer turn.'),
	nl,
	find([H|T], 1, P),%finds the first avaliable move
	nth1(P,[H|T],R), %finds the value at index P of array
	removechosen([H|T],N,P), %remove the value from the array
	R2 is R-1, %auto make comp move so that its always, 1 and rest
	concat(NP2,R2,N), %put the first split number into list
	concat(NP3,1,NP2),%put the second split numbe into list
	check(NP3, 1, F),%check if still good to play
	changeCF(F,NF), %if the check returns a -2, stop gameplay
	pred1(NP3,0,NF). %make other move or stop gameplay
pred1(_,_,0):-
	nl,
	write('Game Done').
find([],_,-2). %if no moves avaiable
find([H|T], N, P):-
	H=<2, %make sure choosen value is greater than 2
	N2 is N + 1, %increment the index value
	find(T,N2,P). %make the tail the head, the new index value, P of location
find(_, N, N). %make the index value same as the N2 argument
removechosen([H|T],[H|T2],D):-
	not(D=:=1), %make sure the picked element is not equal to 1
	D2 is D-1, %increment down to go down the list and remove
	removechosen(T,T2,D2). %make the new second list
removechosen([_|T],T,1). %base case for when at end of list
concat([R|NewPile],R,NewPile). %put R and NewPile together
check([],_,-2). %if this fits, then do nothing
check([H|T], N, P):- %if it doens't fit that condition, find new move
	H=<2,
	N2 is N + 1,
	find(T,N2,P).
check(_, N, N). %make index value the same as N2 argument
changeCF(N,NF):-
	N < 0, %make sure check returned a -2
	NF is 0, %set the NF value, to stop the game once called back
	nl,
	write('You have Lost'),
	nl,
	write('Computer Won').
changeCF(N,NF):-
	N > 0, %if the check says valid movies left, go here
	NF is -1. %keep playing.
changeHF(N,NF):-
	N < 0, %make sure the check returned a -2
	NF is 0,
	nl,
	write('Computer Lost'),
	nl,
	write('You have Won').
changeHF(N,NF):-
	N > 0, %if the check says valid movies left, go here
	NF is -1. %keep palying





