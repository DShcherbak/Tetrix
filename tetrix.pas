//Deniska-sosiska
//Vania loh

uses GraphABC;

const
  M = 19;
  N = 29;
  a = 20;

type
  Ar = array [0..M] of array [-3..N] of boolean;

type
  Ac = array [0..M] of array [0..N] of Color;

type
  Af = array [1..19] of array [1..4] of Point;

var
  colors: Ac;
  field: Ar;
  figures: Af;
  left_tilt, number: integer;
  figure_color: color;

procedure set_figures();
begin
  figures[1][1] := (0, 0);
  figures[1][2] := (0, -1);
  figures[1][3] := (1, 0); //  XX
  figures[1][4] := (1, -1); // XX
  
  figures[2][1] := (0, 0);
  figures[2][2] := (1, 0);
  figures[2][3] := (1, -1); // X
  figures[2][4] := (2, 0); // XXX
  
  figures[3][1] := (0, 0);
  figures[3][2] := (0, -1); // X
  figures[3][3] := (0, -2); // XX
  figures[3][4] := (1, -1); // X 
  
  figures[4][1] := (0, -1);
  figures[4][2] := (1, -1);
  figures[4][3] := (1, 0); // XXX
  figures[4][4] := (2, -1); // X
  
  figures[5][1] := (1, 0);
  figures[5][2] := (0, -1); //  X
  figures[5][3] := (1, -2); // XX
  figures[5][4] := (1, -1); //  X
  
  figures[6][1] := (0, 0); //  X
  figures[6][2] := (0, -1); // X
  figures[6][3] := (0, -2); // X
  figures[6][4] := (0, -3); // X
  
  figures[7][1] := (0, 0); 
  figures[7][2] := (1, 0); 
  figures[7][3] := (2, 0); 
  figures[7][4] := (3, 0); // XXXX 
  
  figures[8][1] := (0, 0);
  figures[8][2] := (1, 0);
  figures[8][3] := (1, -1); //  XX
  figures[8][4] := (2, -1); // XX
  
  figures[9][1] := (0, -1);
  figures[9][2] := (0, -2); // X
  figures[9][3] := (1, -1); // XX
  figures[9][4] := (1, 0); //   X 
  
  figures[10][1] := (0, -1);
  figures[10][2] := (1, -1);
  figures[10][3] := (1, 0); // XX
  figures[10][4] := (2, 0); //  XX
  
  figures[11][1] := (0, 0);
  figures[11][2] := (1, -1); // X
  figures[11][3] := (0, -1); //XX
  figures[11][4] := (1, -2); //X
  
  //  X
  //XXX
  
  figures[12][1] := (0, 0);
  figures[12][2] := (1, 0);
  figures[12][3] := (2, 0); //    X
  figures[12][4] := (2, -1); // XXX
  
  figures[13][1] := (0, 0);
  figures[13][2] := (0, -1); // X
  figures[13][3] := (0, -2); // X
  figures[13][4] := (1, 0); //  XX 
  
  
  figures[14][1] := (0, 0);
  figures[14][2] := (0, -1);
  figures[14][3] := (1, -1);// XXX
  figures[14][4] := (2, -1);//  X
  
  figures[15][1] := (0, -2);
  figures[15][2] := (1, 0);  // XX
  figures[15][3] := (1, -1); //  X
  figures[15][4] := (1, -2); //  X 
  
  
  
  
  figures[16][1] := (0, 0);
  figures[16][2] := (1, 0);
  figures[16][3] := (0, -1); //  X
  figures[16][4] := (2, 0); // XXX
  
  figures[17][1] := (0, 0);
  figures[17][2] := (0, -1);  //XX
  figures[17][3] := (0, -2); // X
  figures[17][4] := (1, -2); // X 
  
  figures[18][1] := (0, -1);
  figures[18][2] := (1, -1);
  figures[18][3] := (2, -1); // XXX
  figures[18][4] := (2, 0); //   X
  
  figures[19][1] := (1, -2);
  figures[19][2] := (1, -1); //X
  figures[19][3] := (0, 0); // X
  figures[19][4] := (1, 0); //XX 
  
end;

procedure square(x, y: integer; c: Color);
begin
  setBrushColor(c);
  fillrectangle(a * x + 1, a * y + 1, a * (x + 1) - 1, a * (y + 1) - 1);
  // colors[x][y]:=c;
  
end;


procedure redraw_field();
var
  i, j: integer;
begin
  for i := 0 to M do
    for j := 0 to N do
    begin
      square(i, j, colors[i][j]);
    end;
  redraw;
end;


function check_row(j: integer): boolean;
var
  i: integer;
  flag: boolean;
begin
  flag := true;
  for i := 0 to M do
    if(field[i][j] = false) then flag := false;
  check_row := flag;
end;


function check_field(): boolean;
var
  x, y, i, j: integer;
  flag: boolean;
begin
  flag := false;
  for y := N downto 0 do 
  begin
    if(check_row(y)) then 
    begin
      for j := y downto 1 do
      begin
        for i := 0 to M do 
        begin
          colors[i][j] := colors[i][j - 1];
          field[i][j] := field[i][j - 1];
        end;
      end;
      for i := 0 to M do 
      begin
        colors[i][0] := clWhite;
        field[i][0] := false;
      end;
      flag := true; 
    end;
    // redraw_field;
    //  sleep(300);
  end;
  check_field := flag;
end;


procedure draw_figure(x, y: integer; c: Color);
begin
 // for var i := 1 to 4 do
 //   square(x + figures[number][i].x, y + figures[number][i].y - 1, clWhite);
  for var i := 1 to 4 do
    square(x + figures[number][i].x, y + figures[number][i].y, c);
  redraw;
end;

function move_figure(var level: integer): boolean;
var
  flag: boolean;
begin
  flag := true;
  for var i := 1 to 4 do
  begin
    if((level = N) or (field[left_tilt + figures[number][i].x][level + figures[number][i].y] = true)) then flag := false;
  end; 
  if(flag) then
  begin
    draw_figure(left_tilt, level, figure_color);
    level := level + 1;
  end
  else
  begin
    for var t := 1 to 4 do
    begin
      field[left_tilt + figures[number][t].x][level-1 + figures[number][t].y] := true;
      colors[left_tilt + figures[number][t].x][level-1 + figures[number][t].y] := figure_color;
    end;
  end;
  move_figure := flag;
end;


procedure tilt(vk: integer);
var
  poss: boolean;
begin
  if((vk = vk_left) and (left_tilt > 0)) then
    left_tilt := left_tilt - 1;
  if((vk = vk_right) and (left_tilt + figures[number][4].x + 1 < M)) then
    left_tilt := left_tilt + 1;
end;



var
  x, y: integer;
  need_check, go_down: boolean;
  level: integer;

begin
  LockDrawing;
  setWindowSize(a * M, a * N);
  onKeyDown := tilt;
  set_figures;
  for x := 0 to M do
    for y := 0 to N do
    begin
      field[x][y] := false;
      colors[x][y] := clwhite;
      rectangle(a * x, a * y, a * (x + 1), a * (y + 1));
    end;
  redraw_field;
  { for var t:=1 to 19 do
   begin
     draw_figure(t,5,5);
     sleep(2000);
   end;
  } while(true) do
  begin
    level := 3;
    left_tilt := 9;
    number := random(1, 19);
    figure_color := clRandom;
    go_down := true;
    while(go_down) do
    begin
      go_down := move_figure(level);
      sleep(300);
      redraw_field;
    end;
    need_check := true;
    while(need_check) do
    begin
      need_check := check_field;
   //   circle(100, 100, 100);
      // sleep(500);
      redraw_field;
    end;
  end;
end.
