uses GraphABC;

const
  M = 9;
  N = 15;
  a = 30;
  T = 200;

type
  Ar = array [-3..N, 0..M] of boolean;

type
  Ac = array [0..N, 0..M] of Color;

type
  Af = array [1..19, 1..4] of Point;

var
  colors: Ac;
  field: Ar;
  figures: Af;
  left_tilt, number: integer;
  figure_color: color;
  level: integer;
  endgame: boolean;

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
  figures[14][4] := (2, -1);// X
  
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
  for i := 0 to N do
    for j := 0 to M do
    begin
      if(field[i][j] = true) then
        square(j, i, clBlack)
      else
        square(j, i, colors[i][j]);
    end;
  //redraw;
end;


function check_row(i: integer): boolean;
var
  j: integer;
  flag: boolean;
begin
  flag := true;
  for j := 0 to M do
    if(field[i][j] = false) then flag := false;
  check_row := flag;
end;

function can_fit(x, y, this_number: integer): boolean;
var
  can: boolean;
begin
  if (level = N + 1) then
    can_fit := false
  else 
  begin
    can := true;
    for var i := 1 to 4 do
    begin
      if ((y + figures[this_number][i].y > N) or (x + figures[this_number][i].x > M) or (x + figures[this_number][i].x < 0)) then
        can := false;
      can := can and (field[y + figures[this_number][i].y][x + figures[this_number][i].x] = false);
    end;
    can_fit := can;
  end;
end;



function check_field(): boolean;
var
  x, y, i, j: integer;
  flag: boolean;
begin
  flag := false;
  for y := 1 to N do 
  begin
    if(check_row(y)) then 
    begin
      for i := y downto 1 do
      begin
        for j := 0 to M do 
        begin
          colors[i][j] := colors[i - 1][j];
          field[i][j] := field[i - 1][j];
        end;
      end;
      for i := 0 to M do 
      begin
        colors[0][i] := clWhite;
        field[0][i] := false;
      end;
      flag := true; 
    end
    else
    //  writeln(y);
    //    circle(0,0,10);
    // //redraw_field;
    //    sleep(30);
      //redraw;
  end;
  check_field := flag;
end;

function get_height(): integer;
var res : integer;
begin
  res := figures[number][1].y;
  for var i := 2 to 4 do
    if (res > figures[number][i].y) then
      res := figures[number][i].y;
  get_height := res;
end;

procedure draw_figure(x, y: integer; c: Color);
begin
  // for var i := 1 to 4 do
  //   square(x + figures[number][i].x, y + figures[number][i].y - 1, clWhite);
  for var i := 1 to 4 do
    square(x + figures[number][i].x, y + figures[number][i].y, c);
end;

function move_figure(): boolean;
var
  flag: boolean;
begin
  flag := true;
    if(can_fit(left_tilt, level + 1, number)) then
    begin
      draw_figure(left_tilt, level, clwhite);
      draw_figure(left_tilt, level + 1, figure_color);
      //redraw;
      level := level + 1;
    end
    else
    begin
      flag := false;
      if(level + get_height <= 0) then
        endgame := true
      else
      begin
        for var t := 1 to 4 do
        begin
          field[level + figures[number][t].y][left_tilt + figures[number][t].x] := true;
          colors[level + figures[number][t].y][left_tilt + figures[number][t].x] := figure_color;
        end;
      end;
    end;
  move_figure := flag;
end;

procedure left();
begin 
  if (can_fit(left_tilt - 1, level, number)) then 
     dec(left_tilt);
end;

procedure right();
begin
    if (can_fit(left_tilt + 1, level, number)) then 
     inc(left_tilt);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
end;

function turn(clockwise: boolean):integer;
var res:integer;
begin
  if(clockwise) then
  begin
    if(number = 5) or (number = 15) or (number = 19) then
      res := number - 3
    else if (number = 7) or (number = 9) or (number = 11) then
      res := number - 1
    else if(number = 1) then 
      res := 1
    else 
      res := number + 1;
  end
  else
  begin
    if(number = 2) or (number = 12) or (number = 16) then
      res := number + 3
    else if (number = 6) or (number = 8) or (number = 10) then
      res := number + 1
    else if(number = 1) then 
      res := 1
    else 
      res := number - 1;
  end;
  turn:=res;
end;

procedure turn_right();
begin
  while (not(can_fit(left_tilt, level, turn(true)))) and(can_fit(left_tilt - 1, level, number)) do
    dec(left_tilt);
  if (can_fit(left_tilt, level, turn(true))) then
    number := turn(true);
end;
 
procedure turn_left();
begin
  while (not(can_fit(left_tilt, level, turn(false)))) and(can_fit(left_tilt - 1, level, number)) do
    dec(left_tilt);
  if (can_fit(left_tilt, level, turn(false))) then
    number := turn(false);
end;


function can_fit_down(): boolean;
var
  can: boolean;
begin
  if (level = N) then 
    can_fit_down := false
  else 
  begin
    can := true;
    for var i := 1 to 4 do
    begin
      can := can and (field[level + 1 + figures[number][i].y][left_tilt + figures[number][i].x] = false);
    end;
    can_fit_down := can;
  end;
end;

procedure tilt(vk: integer);
var
  poss: boolean;
begin
  draw_figure(left_tilt, level, clwhite);
  if ((vk = vk_down) and (level <= N))then
    while (can_fit_down) do 
      inc(level);
  if(vk = vk_left) then
    left;
  if(vk = vk_right) then
    right;
  if(vk = vk_z) then
    turn_left;
  if(vk = vk_x) then
    turn_right;
  draw_figure(left_tilt, level, figure_color);
  //redraw;
end;



var
  x, y: integer;
  need_check, go_down: boolean;

begin
  //LockDrawing;
  setWindowSize(a * (M + 1), a * (N + 1));
  endgame := false;
  set_figures;
  for x := 0 to M do
    for y := 0 to N do
    begin
      field[y][x] := false;
      colors[y][x] := clwhite;
      rectangle(a * x, a * y, a * (x + 1), a * (y + 1));
    end;
  redraw_field;
  while not (endgame) do
  begin
    onKeyDown := tilt;
    level := 0;
    left_tilt := M div 2;
    number := random(1, 19);
    figure_color := clRandom;
    go_down := true;
    while(go_down) do
    begin
      go_down := move_figure();
      if (go_down) then
        {for var i := 1 to 200000000 do
        begin
        
        end;}
        sleep(300);
    end;
    redraw_field;
    need_check := check_field;
    if(need_check) then redraw_field;
  end;
  clearWindow(clBlack);
  onKeyDown := nil;
  Write('Game Over');
  //redraw;
end.
