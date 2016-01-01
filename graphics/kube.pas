uses ptcgraph, ptccrt;
const
	maxColumnCount = 200;
	cubeSize = 100;
	fallDelay = 1;
	fallDistance = 200;
var
	g, mode : integer;
	i : integer;
	cubeY, maxY : integer;

	columnIndex, columnCount : integer;
	columnHeight : integer;
	cubeCntInCol : array [1..maxColumnCount] of integer;
	cubeCount, maxCubeCount : integer;

	cubeColor : word;
procedure h; begin if keypressed then halt; end;

procedure box(x, y1, y2 : integer);
var y : integer;
begin
	setFillStyle(SolidFill, cubeColor); { `bar` in `box` uses fill color to draw }
	bar(x - cubeSize, y1, x - 1, y1 + cubeSize);
	for y := y1 to y2 do
	begin
		delay(fallDelay);
		setColor(0); { black }
		line(x - cubeSize, y, x - 1, y);
		setColor(cubeColor);
		line(x - cubeSize, y + cubeSize, x - 1, y + cubeSize);
		h;
	end;
end;
function randomColor : word;
var tmp : longint;
begin
	tmp := random(getMaxColor);
	if tmp = 0
	then
		randomColor := 1251 { dice roll => guaranteed to be random }
	else
		randomColor := tmp;
end;
begin
	{init}
	g := detect;
	fullscreengraph := true;
	initGraph (g, mode, '');
	columnHeight := (getMaxY+1) div cubeSize + 1; { +1 to fill the screen on top }
	columnCount := (getMaxX+1) div cubeSize + 1;  { +1 to fill the screen on the right side }
	if columnCount > maxColumnCount then
		columnCount := maxColumnCount;
	cubeCount := 0;
	maxCubeCount := columnCount * columnHeight;
	randomize;
	cubeColor := randomColor;
	setColor(cubeColor);
	setLineStyle(solidLn, 0, normWidth);
	repeat
		setFillStyle(EmptyFill, 0);
		bar(0,0, getMaxX, getMaxY);
		for columnIndex := 1 to columnCount do
		begin
			cubeCntInCol[columnIndex] := 0;
		end;
		for i := 1 to columnCount * columnHeight do
		begin
			while true do
			begin
				columnIndex := random(columnCount) + 1;
				if cubeCntInCol[columnIndex] < columnHeight then
					break;
			end;
			inc(cubeCntInCol[columnIndex]);
			cubeColor := randomColor;
			setColor(cubeColor);
			cubeY := getMaxY - cubeCntInCol[columnIndex] * cubeSize;
			box(columnIndex * cubeSize, cubeY - fallDistance, cubeY);
			inc(cubeCount);
			h;
		end;
	until keypressed;
end.
