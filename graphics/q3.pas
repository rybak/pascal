uses ptcgraph, ptccrt;

const
	boxSize = 60;
	lineHeight = 20;
function digitToChar(d : integer) : char;
begin
	if d < 0 then halt(1);
	if d > 9 then halt(2);
	digitToChar := chr(ord('0') + d);
end;
function integetToString(x : integer) : string;
var tmp : integer; s : string;
begin
	if x < 0 then
		tmp := -x
	else
		tmp := x;
	s := '';
	while tmp > 0 do
	begin
		s := digitToChar(tmp mod 10) + s;
		tmp := tmp div 10;
	end;
	while length(s) < 6 do
		s := '0' + s;
	integetToString := s;
end;
function digitToHex(d : integer) : char;
begin
	if d < 0 then halt(3);
	if d > 15 then halt(4);
	if d < 10 then
		digitToHex := digitToChar(d)
	else
		digitToHex := chr(ord('A') + d - 10);
end;
function wordToHex(x : word) : string;
var
	s : string;
	tmp : word;
begin
	s := '';
	tmp := x;
	while tmp > 0 do
	begin
		s := digitToHex(tmp mod 16) + s;
		tmp := tmp div 16;
	end;
	while length(s) < 4 do
		s := '0' + s;
	wordToHex := s;
end;
var
	gDriver, gMode : integer;
	colors : array[0..999] of word;
	colorCount, i : integer;
	x, y : integer;
	width, height : integer;

	ch : char;
begin
	gDriver := detect;
	fullScreenGraph := true;
	initGraph(gDriver, gMode, '');
	            {%rrrrrGGGGGGbbbbb}
	colors[0] := %0000000000000000;
	colors[1] := %1111100000000000;
	colors[2] := %0000011111100000;
	colors[3] := %0000000000011111;
	colors[4] := %1111111111100000; { Yellow }
	colors[5] := %0000011111111111; { Cyan }
	colors[6] := %1111100000011111; { Magenta }
	colors[7] := %1111111111111111; { White }
	colorCount := 7;
	width := (getMaxX + 1) div boxSize;
	height := (getMaxY + 1) div boxSize;
	x := 0;
	y := 0;
	for i := 0 to colorCount do
	begin
		setFillStyle(SolidFill, colors[i]);
		bar(x, y, x + boxSize - 1, y + boxSize -1);
		outTextXY(i * boxSize, boxSize + lineHeight, wordToHex(colors[i]));
		outTextXY(i * boxSize, boxSize + 2*lineHeight, integetToString(i));
		x := x + boxSize;
		if x > getMaxX - boxSize then
		begin
			x := 0;
			y := y + boxSize + 2*lineHeight;
		end;
	end;
	repeat
		if keypressed then
			ch := readKey;
	until (ch = #32) or (ch = #13) or (ch = 'q') or (ch = 'Q');
	closeGraph;
end.

