local image = app.activeSprite
local rect=Rectangle(30,30,30,30)
local imgw = image.width
local imgh= image.height

local info = Dialog()
	info:slider{
		id="cenx",
		label="Center X",
		min=0,
		max=imgw,
		value=imgw/2
	}
	info:slider{
		id="ceny",
		label="Center Y",
		min=0,
		max=imgh,
		value=imgh/2	
	}
	info:slider{id="zgs",label="Z Gridline Count",min=1,max=30,value=5}
	info:slider{id="xgs",label="X/Y Gridline Count",min=1,max=30,value=5}
	info:separator{id="animsep",text="Animation Settings"}
	info:number{id="fcount",label="Frame Count"}
	info:slider{id="mox",label="Move to X",min=0,max=imgw,value=imgw/2}
	info:slider{id="moy",label="Move to Y",min=0,max=imgh,value=imgh/2}
	info:number{id="moz",label="Move by Z"}
	info:check{id="anlin",label="Smooth Animation X/Y"}
	info:check{id="anliz",label="Smooth Animation Z"}
	info:button{id="ok",text="OK"}
	info:show()
	local cx=info.data.cenx --start points
	local cy=info.data.ceny
	local fc=math.max(info.data.fcount,1)
	local xm=info.data.mox
	local ym=info.data.moy
	local zg=info.data.zgs
	local xg=info.data.xgs
	local zm=info.data.moz
	local cz=0

function run()
local nll = image:newLayer()
for q=1,fc do
	app.command.ClearCel()
	local dx=info.data.cenx
	local dy=info.data.ceny
if info.data.fcount>0 then
if info.data.anlin then

	cx=((dx+xm)/2)+(dx-xm)*math.cos(((q-1)/fc)*math.pi)/2
	cy=((dy+ym)/2)+(dy-ym)*math.cos(((q-1)/fc)*math.pi)/2
else
	cx=info.data.cenx+((xm-dx)/fc)*q
	cy=info.data.ceny+((ym-dy)/fc)*q
end
end

for i=0,1,1/xg do for j=0,1 do
app.useTool{
	tool="line",
	brush=Brush(1),
	points={Point(imgw*i,imgh*j),Point(cx,cy)}
} end end
for i=0,1 do for j=0,1,1/xg do
app.useTool{
	tool="line",
	brush=Brush(1),
	points={Point(imgw*i,imgh*j),Point(cx,cy)}
} end end

if info.data.anliz then
cz=zm+(zm)*math.cos(((q-1)/fc)*math.pi)
else
	cz=zm*(q/fc)
end

for i=0,10,10/zg do
local zz=(i+cz)%(10/zg)+i
app.useTool{
	tool="rectangle",
	brush=Brush(1),
	points={Point(cx-cx/zz,cy-cy/zz),Point(cx-(cx-imgw)/(zz),cy-(cy-imgh)/zz)}
}
end
if fc>1 and q<fc then
app.command.NewFrame()	end
end end

if info.data.ok then
	app.transaction(run)
end

