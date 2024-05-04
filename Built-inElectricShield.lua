local params = Style.GetParameterValues().General
local w=params.Width
local h=params.Height
local t=params.Thickness
local n=10
local s=(w-100)/(n-1)
local offsetConn = params.OffsetConnectionPoints

local case = CreateBlock(w,h,t):Shift(0,0,-t)
local frameContour = CreateRectangle2D(Point2D(0,0),0,w-4,h-4)
local frameExtrParam = ExtrusionParameters(3)
frameExtrParam.OutwardOffset = 22
local framePlac = Placement3D(Point3D(0,0,0),Vector3D(0,0,1),Vector3D(1,0,0))
local frame = Extrude(frameContour,frameExtrParam,framePlac)
local door = CreateBlock(w-5,h-5,3)
local keyhole = CreateRightCircularCylinder(15,6):Shift(-w/2+25,0,0)
local solid = Unite({case,frame,door,keyhole})

Style.SetDetailedGeometry(ModelGeometry():AddSolid(solid))
for i=1,n do
    local placOut = Placement3D(Point3D(-w/2+50+s*(i-1),h/2,-t+offsetConn),Vector3D(0,1,0),Vector3D(1,0,0))
    Style.GetPort("Outlet"..i):SetPlacement(placOut)
end
for i=1,2 do
    local placIn = Placement3D(Point3D(-25+50*(i-1),-h/2,-t+offsetConn),Vector3D(0,-1,0),Vector3D(1,0,0))
    Style.GetPort("Inlet"..i):SetPlacement(placIn)
end