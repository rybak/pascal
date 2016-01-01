uses ptcgraph, ptccrt;

const
	recolorCount = 100;
	delayTime = 10;
var
	gDriver, gMode : integer;

	maxX, maxY : integer;
	x1, y1, x2, y2 : integer;
	c, maxColor : word;

	ch : char;
	count : longint;
begin
gDriver := detect;
FullScreenGraph := true;
initGraph (gDriver, gMode, '');

c := 1;
setLineStyle(SolidLn, 0, ThickWidth);
count := 0;
setColor(c);
randomize;
maxX := GetMaxX;
maxY := GetMaxY;
maxColor := GetMaxColor;
writeln('maxColor = ', maxColor);
x1 := random(maxX);
y1 := random(maxY);
repeat
	if count = recolorCount then
	begin
		count := 0;
		setColor(random(maxColor));
	end;
	x2 := random(maxX);
	y2 := random(maxY);
	line(x1, y1, x2, y2);
	inc(count);
	delay(delayTime);
	x1 := x2;
	y1 := y2;
	if keypressed then
		ch := readkey;
	if ch = 'a' then
	begin
		c := c + 1;
		setColor(c);
	end;
	if ch = #13 then
	begin
		c := 0;
		setColor(0);
	end;
until ch = #32;
closeGraph;
end.

