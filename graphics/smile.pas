uses ptcgraph, ptccrt;
const
	delayTime = 20;
	hahaDelay = 200;
	{ arc angles }
	frawnStart = 0;
	frawnEnd = 180;
	smileStart = 180;
	smileEnd = 360;

	xRadius = 100;
	faceRadius = 200;
	eyeRadius = 40;
	eyePosition = 70;
	mouthPosition = 120;
	msgText = 'Ha-ha-ha!';
	msgDead = 'xxxxxxxxx';
function rgbTo16BitColor(rb, gb, bb : byte) : word;
const { bit depth }
	rd = 5;
	gd = 6;
	bd = 5;
var
	r, g, b : double;
	rBits, gBits, bBits : word;
begin
	r := rb;
	g := gb;
	b := bb;
	{ RRRRRggggggBBBBB }
	rBits := trunc(r / 256.0 * (1 shl rd)) shl (bd + gd);
	gBits := trunc(g / 256.0 * (1 shl gd)) shl bd;
	bBits := trunc(b / 256.0 * (1 shl bd));
	rgbTo16BitColor := rBits or gBits or bBits;
end;
var
	gDriver, gMode : integer;
	centerX, centerY : integer;
	msgX, msgY : integer;
	yRadius : integer;
	graphError : longint;
	faceColor, lineColor, eyeColor : word;
	msgColor : word;
procedure drawMouth(yRadius, arcStart, arcEnd : integer);
begin
	ellipse(centerX, centerY+mouthPosition, arcStart, arcEnd, xRadius, yRadius);
end;
procedure animateFrameMouth(yRadius, arcStart, arcEnd : integer);
begin
	setColor(lineColor);
	drawMouth(yRadius, arcStart, arcEnd);
	setColor(faceColor);
	delay(delayTime);
	drawMouth(yRadius, arcStart, arcEnd);
end;
procedure animateMouth(startRadius, endRadius, arcStart, arcEnd : integer);
var yRadius, c : integer;
begin
	if endRadius < startRadius then
		c := -1
	else
		c := 1;
	yRadius := startRadius;
	while yRadius <> endRadius do
	begin
		animateFrameMouth(yRadius, arcStart, arcEnd);
		yRadius := yRadius + c;
	end;
end;
procedure drawFace;
begin
	setColor(lineColor); { lineColor }
	setLineStyle(SolidLn, 0, ThickWidth);
	setFillStyle(SolidFill, faceColor);
	fillEllipse(centerX, centerY, faceRadius, faceRadius); { face }
	line(centerX, centerY-30, centerX, centerY+20); { nose }
	setFillStyle(SolidFill, eyeColor);
	fillEllipse(centerX - eyePosition, centerY - eyePosition, eyeRadius, eyeRadius); { left eye }
	fillEllipse(centerX + eyePosition, centerY - eyePosition, eyeRadius, eyeRadius); { right eye }
	setColor(lineColor);
	drawMouth(1, frawnStart, frawnEnd);
end;
begin
	gDriver := D8bit;
	gMode := m640x480;
	initGraph (gDriver, gMode, '');

	graphError := graphResult;
	if (graphError <> grOk) Then
	begin
		writeln('requested graph mode is not supported!');
		writeln(graphError);
		halt(1)
	end;

	writeln('mode = ', gMode);
	writeln('[', getMaxX + 1, '×', getMaxY + 1, ']');

	centerX := (getMaxX+1) div 2;
	centerY := (getMaxY+1) div 2;
	msgX := getMaxX div 2 -80;
	msgY := getMaxY * 5 div 6;
	msgColor := rgbTo16BitColor($FF,$FF,$FF);
	lineColor := rgbTo16BitColor($FF, $7F, 0);
	faceColor := rgbTo16BitColor($F5, $DE, $B3);
	eyeColor := rgbTo16BitColor(0, $7F, $FF);

	setTextStyle(7, 0, 2);
	drawFace;
	repeat
		setColor(msgColor);
		outtextxy(msgX, msgY, msgDead);
		animateMouth(0, 35, frawnStart, frawnEnd); { frawn up }
		animateMouth(35, 0, frawnStart, frawnEnd); { frawn down }
		setColor(0);
		outtextxy(msgX, msgY, msgDead);
		setColor(msgColor);
		outtextxy(msgX, msgY, msgText);
		animateMouth(0, 50, smileStart, smileEnd); { smile down }
		animateMouth(50, 0, smileStart, smileEnd); { smile up }
		setColor(0);
		outtextxy(msgX, msgY, msgText);
	until keypressed;
	clearDevice;
	closeGraph;
	restoreCrtMode;
	writeln('Hello, World!');
end.
