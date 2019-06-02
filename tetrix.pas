uses GraphABC;

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

function check_row(j:integer):boolean;
var i:integer;
    flag:boolean;
begin
  flag:=true;
  for i:=0 to M do
    if(field[i][j] = false) then flag:=false;
  check_row:=flag;
end;


function check_field():boolean;
var x,y,i,j:integer;
    flag:boolean;
begin
flag:=false;
  for y:=N downto 0 do 
  begin
    if(check_row(y)) then 
    begin
      for j:=y downto 1 do
      begin
        for i:=0 to M do 
        begin
          colors[i][j]:=colors[i][j-1];
          field[i][j]:=field[i][j-1];
        end;
      end;
      for i:=0 to M do 
        begin
          colors[i][0]:=clWhite;
          field[i][0]:=false;
        end;
     flag:=true; 
    end;
    redraw_field;
    sleep(300);
  end;
  check_field:=flag;
end;
    
var x,y:integer;
    need_check:boolean;

BEGIN
  setWindowSize(a*M,a*N);
  for x:=0 to M do
    for y:=0 to N do
    begin
      field[x][y]:=true;
      colors[x][y]:=clRandom;
    end;
  redraw_field;
  while(true) do
  begin
    need_check:=true;
    while(need_check) do
    begin
      need_check:=check_field;
      circle(100,100,100);
      sleep(500);
      redraw_field;
    end;
  end;
END.