uses ptcgraph, ptccrt;
var g, x, y, mode : integer;
		i, j, k : longint;
	begin
	g := detect;
	initGraph (g, mode, '');
	setbkcolor(white);
	x := 320;
	y := 240;
	setColor(0);
	setLineStyle(0, 0, 3);
	setFillStyle(1, 14);
	Fillellipse (x, y, 100, 100);
	readln;
	closeGraph;
	end.
