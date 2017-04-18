%
% Haris Krasniqi [Nurikabe Puzzle]
%

#const xmax=5.
#const ymax=5.

%Init grid
xcoo(1..xmax).
ycoo(1..ymax).

%Define cell
cell(f(X,Y)) :- xcoo(X), ycoo(Y).

%Inputs
input(f(2,2), 3).
input(f(3,1), 3).
input(f(1,5), 2).
input(f(5,5), 1).

%Define neighbours
yNeighbour(f(X,Y), f(X,Y+1)) :- xcoo(X), ycoo(Y), ycoo(Y+1).
xNeighbour(f(X,Y), f(X+1,Y)) :- xcoo(X), ycoo(Y), xcoo(X+1).
yNeighbour(A,B) :- yNeighbour(B,A).
xNeighbour(A,B) :- xNeighbour(B,A).

%Define numbered cell
numbered(F, N) :- cell(F), input(F, N).

%An island is full if it contains as many land(brown) cells as the number in the region. 
%Any 1s are trivially full waters
%%When you encounter a full water, any cells that boarder it must be land/water(blue)
fullIsland(F) :- numbered(F, 1).
water(C) :- fullIsland(F), yNeighbour(F, C).
water(C) :- fullIsland(F), xNeighbour(F, C).
water(C) :- fullIsland(F), yNeighbour(C, F).
water(C) :- fullIsland(F), xNeighbour(C, F).

%What is not water is a land
land(F) :- cell(F), not water(F).


%Since two numbered cells in a nurikabe puzzle cannot be part of the same water,
%any cell that has two numbered neighbors must be black (seperate water)
:- water(F), yNeighbour(C, F), numbered(F, N).


%TODO
%-If an water(black cells) doesn't yet have its target number of cells, and there is only one cell bordering, that cell is a part of water too
%-All waters lands(blue cells) should be connected orthogonally