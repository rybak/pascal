uses ptcgraph, ptccrt;
var
	g, x, y, mode : integer;
	c : word;
	i, j, k : longint;
	step : integer;
	begin
	g := detect;
	initGraph (g, mode, '');
	x := getMaxX;
	y := getMaxY;
	write('x = ', x, ' y = ', y);
	c := x;
	step := x div c;
	write('step = ', step);
	for i := 1 to c do
		begin
		setColor(i);
		setLineStyle(solidln, 0, ThickWidth);
		setFillStyle(1, i);
		bar (i*step, 10, i * (step+1), 200);
		end;
	readln;
	closeGraph;
	end.
