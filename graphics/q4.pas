uses ptcgraph, ptccrt;

const
	boxSize = 8;
var
	gDriver, gMode : integer;
	i, j : integer;
	width, height : integer;
	c : word;
	ch : char;
	maxColorReached : boolean;

begin
	gDriver := detect;
	fullScreenGraph := true;
	initGraph (gDriver, gMode, '');
	width := (getMaxX + 1) div boxSize;
	height := (getMaxY + 1) div boxSize;
	width := width - (width mod 32);
	height := height - (height mod 32);
	width := 64;
	height := 64;

	c := 0;
	maxColorReached := false;
	repeat
		write('[', c);
		for i := 0 to height - 1 do
		begin
			for j := 0 to width - 1 do
			begin
				setFillStyle(SolidFill, c);
				bar(j * boxSize, i * boxSize, (j+1)*boxSize-1, (i+1)*boxSize-1);
				inc(c);
				if c = getMaxColor then
					maxColorReached := true;
			end;
		end;
		write(', ', c, ']');
		if maxColorReached then
		begin
			writeln;
			writeln('maxColor reached');
			break;
		end;
		ch := 'Q';
		repeat
			if keypressed then
				ch := readKey;
		until (ch = #32) or (ch = #13);
	until ch = #13;
	repeat
		if keypressed then
			ch := readKey;
	until (ch = #32) or (ch = #13) or (ch = 'q') or (ch = 'Q');
	closeGraph;
end.
