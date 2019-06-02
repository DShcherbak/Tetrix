﻿uses GraphABC;

const M = 19;
    N = 29;
    a = 20;

type Ar = array [0..M] of array [0..N] of boolean;
type Ac = array [0..M] of array [0..N] of Color;

var colors:Ac;
    field:Ar;
    
procedure square(x,y:integer);
begin
  setBrushColor(colors[x][y]);
  rectangle(a*x,a*y,a*(x+1),a*(y+1));
end;
    
procedure redraw_field();
var i, j:integer;
begin
  for i:=0 to M do
    for j:=0 to N do
    begin
      square(i,j);
    end;
end;

    
var x,y:integer;

BEGIN
  setWindowSize(a*M,a*N);
  for x:=0 to M do
    for y:=0 to N do
    begin
      field[x][y]:=false;
      colors[x][y]:=clRandom;
    end;
  redraw_field;
END.