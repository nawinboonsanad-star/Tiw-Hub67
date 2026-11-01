Print("[TiwHub] Full All-in-One Script Loaded")
local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local RS=game:GetService("RunService")
local LT=game:GetService("Lighting")
local HS=game:GetService("HttpService")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local PID=game.PlaceId
local FILE="TiwHub_" .. game.GameId .. ".json"
local MAPS={
[2753915549]={n="Blox Fruits - Sea 1",t="บล็อกฟรุ๊ต - ซี 1",bf=true},
[4442272183]={n="Blox Fruits - Sea 2",t="บล็อกฟรุ๊ต - ซี 2",bf=true},
[7449423635]={n="Blox Fruits - Sea 3",t="บล็อกฟรุ๊ต - ซี 3",bf=true},
}
local MAP=MAPS[PID]
if not MAP and game.GameId==994732206 then MAP={n="Blox Fruits (ID " .. PID .. ")",t="บล็อกฟรุ๊ต (ID " .. PID .. ")",bf=true} end
if not MAP then
local warnGui=Instance.new("ScreenGui")
warnGui.Name="TiwHubNotice"
warnGui.ResetOnSpawn=false
warnGui.DisplayOrder=999
warnGui.Parent=PG
local box=Instance.new("TextLabel")
box.Size=UDim2.fromOffset(320,70)
box.Position=UDim2.new(0.5,-160,0,20)
box.BackgroundColor3=Color3.fromRGB(30,31,40)
box.TextColor3=Color3.fromRGB(255,190,90)
box.TextSize=14
box.Font=Enum.Font.GothamBold
box.TextWrapped=true
box.Text="Tiw Hub รองรับเฉพาะ Blox Fruits (Sea 1-3)\nแมพนี้ไม่รองรับ (ID " .. PID .. ")"
box.Parent=warnGui
Instance.new("UICorner",box).CornerRadius=UDim.new(0,10)
task.delay(5,function() warnGui:Destroy() end)
warn("[TiwHub] Blox Fruits only. Unsupported PlaceId: " .. PID)
return
end

local DEF={
    scale=0.75,accent="Purple",lang="ไทย",hud=false,sHud=false,boost=false,fovOn=false,fov=70,key="RightShift",
    autoFarmLevel=false,autoFarmBoss=false,autoFarmMastery=false,autoFarmMaterials=false,
    fastAttack=false,bringMobs=false,killAura=false,disableCollision=false,
    autoBuyChip=false,autoStartRaid=false,autoAwaken=false,
    autoSeaBeast=false,mirageFinder=false,autoGearV4=false,
    raceV4Auto=false,getLegendarySwords=false,getSoulGuitar=false,
    fruitNotifier=false,autoTeleportFruit=false,autoStoreFruit=false,
    noclip=false,infJump=false,flyMode=false,
    autoBounty=false,playerESP=false,safeZoneEscape=false,
    autoStats=false,antiAFK=true
}
local CF,SV={},{}
for k,v in pairs(DEF) do CF[k]=v end
local function ReadSaved()
local raw
pcall(function() if isfile and readfile and isfile(FILE) then raw=readfile(FILE) end end)
if not raw then pcall(function() if getgenv and getgenv().TiwHubSaved then raw=getgenv().TiwHubSaved[FILE] end end) end
return raw
end
local function Load()
local raw=ReadSaved()
if not raw then return false end
return (pcall(function()
for k,v in pairs(HS:JSONDecode(raw)) do
if DEF[k]~=nil and type(v)==type(DEF[k]) then CF[k]=v;SV[k]=true end
end
end))
end
local function DetectMode()
local m=nil
pcall(function() if isfile and isfile(FILE) then m="file" end end)
if not m then pcall(function() if getgenv and getgenv().TiwHubSaved and getgenv().TiwHubSaved[FILE] then m="mem" end end) end
return m
end
local saveMode=DetectMode()
Load()
local function T(en,th) return CF.lang=="English" and en or th end
local loc={}
local function Tr(o,en,th,pre)
loc[#loc+1]={o,en,th,pre or ""}
o.Text=(pre or "") .. T(en,th)
end
local function SetLang()
for _,l in ipairs(loc) do if l[1].Parent then l[1].Text=l[4] .. T(l[2],l[3]) end end
end
local AC={
Purple=Color3.fromRGB(124,108,255),Blue=Color3.fromRGB(80,150,255),Green=Color3.fromRGB(70,200,120),
Red=Color3.fromRGB(230,80,90),Orange=Color3.fromRGB(245,155,60),Pink=Color3.fromRGB(240,100,175),
}
local AN={"Purple","Blue","Green","Red","Orange","Pink"}
local A=AC[CF.accent] or AC.Purple
local BG,PN,DK,IT=Color3.fromRGB(22,23,29),Color3.fromRGB(30,31,40),Color3.fromRGB(16,17,22),Color3.fromRGB(42,44,56)
local OFF,TX,SB=Color3.fromRGB(58,60,76),Color3.fromRGB(230,230,238),Color3.fromRGB(150,150,165)
local function N(c,p,par)
local i=Instance.new(c)
for k,v in pairs(p) do i[k]=v end
i.Parent=par
return i
end
local function R(o,r) N("UICorner",{CornerRadius=UDim.new(0,r)},o) end
local reg,fns={},{}
local function Ac(o,p) reg[#reg+1]={o,p};o[p]=A end
local function Tw(o,p,t) TS:Create(o,TweenInfo.new(t or 0.15),p):Play() end
local function St(o,t) local s=N("UIStroke",{Thickness=t},o);Ac(s,"Color") end
local function Safe(f,...) if f then local ok,e=pcall(f,...);if not ok then warn("[TiwHub] " .. tostring(e)) end end end
local function Recolor(name)
A=AC[name] or AC.Purple
for _,r in ipairs(reg) do if r[1].Parent then r[1][r[2]]=A end end
for _,f in ipairs(fns) do pcall(f) end
end
pcall(function() PG.TiwHub:Destroy() end)
local gui=N("ScreenGui",{Name="TiwHub",ResetOnSpawn=false,DisplayOrder=999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},PG)
local cn={}
do
local cbox=N("Frame",{Size=UDim2.fromOffset(320,180),Position=UDim2.new(0.5,-160,0.5,-90),BackgroundColor3=Color3.fromRGB(20,20,25),BorderSizePixel=0},gui)
R(cbox,12);St(cbox,2)
local ct=N("TextLabel",{Size=UDim2.new(1,0,0,40),Position=UDim2.fromOffset(0,10),BackgroundTransparency=1,Text="TIW HUB",TextSize=22,Font=Enum.Font.GothamBold},cbox)
Ac(ct,"TextColor3")
local cm=N("TextLabel",{Size=UDim2.new(1,-20,0,20),Position=UDim2.fromOffset(10,48),BackgroundTransparency=1,TextColor3=Color3.fromRGB(120,255,160),TextSize=13,Font=Enum.Font.GothamBold,TextWrapped=true},cbox)
Tr(cm,"Map: " .. MAP.n,"แมพ: " .. MAP.t)
local cq=N("TextLabel",{Size=UDim2.new(1,-20,0,30),Position=UDim2.fromOffset(10,72),BackgroundTransparency=1,TextColor3=TX,TextSize=15,Font=Enum.Font.Gotham,TextWrapped=true},cbox)
Tr(cq,"Do you want to run Tiw Hub?","คุณต้องการรัน Tiw Hub หรือไม่?")
local crun=N("TextButton",{Size=UDim2.fromOffset(200,40),Position=UDim2.new(0.5,-100,1,-55),TextColor3=Color3.new(1,1,1),TextSize=18,Font=Enum.Font.GothamBold},cbox)
R(crun,8);Ac(crun,"BackgroundColor3");Tr(crun,"Run","รัน")
crun.MouseButton1Click:Wait()
cbox:Destroy()
end
local holder=N("Frame",{Size=UDim2.new(0,240,1,-20),Position=UDim2.new(1,-250,0,10),BackgroundTransparency=1},gui)
N("UIListLayout",{Padding=UDim.new(0,6),VerticalAlignment=Enum.VerticalAlignment.Bottom},holder)
local function Toast(en,th)
local f=N("TextLabel",{Size=UDim2.new(1,0,0,34),BackgroundColor3=PN,Text=T(en,th),TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham},holder)
R(f,8);St(f,1.5)
task.delay(2.5,function() f:Destroy() end)
end
local function Copy(s)
local ok=false
if setclipboard then ok=pcall(setclipboard,s) end
Toast(ok and "Copied" or "Clipboard not supported",ok and "คัดลอกแล้ว" or "ไม่รองรับการคัดลอก")
end
local function Drag(frame,handle,tap)
local dr,mv,ds,sp=false,false,nil,nil
handle.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dr,mv,ds,sp=true,false,i.Position,frame.Position
local c
c=i.Changed:Connect(function()
if i.UserInputState==Enum.UserInputState.End then
dr=false;c:Disconnect()
if tap and not mv then tap() end
end
end)
end
end)
cn[#cn+1]=UIS.InputChanged:Connect(function(i)
if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
local d=i.Position - ds
if d.Magnitude > 4 then mv=true end
if mv then frame.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end
end
end)
end
local bal=N("TextButton",{Size=UDim2.fromOffset(50,50),Position=UDim2.new(0,16,0.5,-25),BackgroundColor3=PN,Text="TIW",TextSize=14,Font=Enum.Font.GothamBold,AutoButtonColor=false},gui)
R(bal,25);St(bal,2);Ac(bal,"TextColor3")
local W,H=500,340
local win=N("Frame",{Size=UDim2.fromOffset(W,H),Position=UDim2.new(0.5,-W/2,0.5,-H/2),BackgroundColor3=BG,BorderSizePixel=0},gui)
R(win,10);St(win,1.5)
local ws=N("UIScale",{Scale=CF.scale},win)
local top=N("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=PN,BorderSizePixel=0},win)
R(top,10)
N("Frame",{Size=UDim2.new(1,0,0,10),Position=UDim2.new(0,0,1,-10),BackgroundColor3=PN,BorderSizePixel=0},top)
local ttl=N("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.fromOffset(15,0),BackgroundTransparency=1,Text="TIW HUB  |  " .. MAP.n,TextSize=14,Font=Enum.Font.GothamBlack,TextXAlignment=Enum.TextXAlignment.Left},top)
Ac(ttl,"TextColor3")
local x=N("TextButton",{Size=UDim2.fromOffset(30,30),Position=UDim2.new(1,-36,0,4),BackgroundTransparency=1,Text="×",TextColor3=SB,TextSize=22,Font=Enum.Font.GothamBold},top)
local tl=N("ScrollingFrame",{Size=UDim2.new(0,120,1,-48),Position=UDim2.fromOffset(6,43),BackgroundColor3=DK,BorderSizePixel=0,ScrollBarThickness=0,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},win)
R(tl,8)
N("UIListLayout",{Padding=UDim.new(0,4)},tl)
N("UIPadding",{PaddingTop=UDim.new(0,5),PaddingLeft=UDim.new(0,5),PaddingRight=UDim.new(0,5),PaddingBottom=UDim.new(0,5)},tl)
local hold=N("Frame",{Size=UDim2.new(1,-140,1,-48),Position=UDim2.fromOffset(132,43),BackgroundTransparency=1},win)
local tabs,cur={},nil
local function Sel(t)
for _,o in ipairs(tabs) do o.p.Visible=false;o.b.BackgroundColor3=PN;o.b.TextColor3=SB end
t.p.Visible=true;t.b.BackgroundColor3=A;t.b.TextColor3=Color3.new(1,1,1);cur=t
end
fns[#fns+1]=function() if cur then Sel(cur) end end
local function Tab(en,th)
local b=N("TextButton",{Size=UDim2.new(1,0,0,30),BackgroundColor3=PN,TextColor3=SB,TextSize=12,Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false},tl)
R(b,6);Tr(b,en,th,"  ")
local p=N("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,ScrollBarThickness=3,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},hold)
N("UIListLayout",{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},p)
N("UIPadding",{PaddingRight=UDim.new(0,6),PaddingBottom=UDim.new(0,6)},p)
local t={b=b,p=p}
tabs[#tabs+1]=t
b.MouseButton1Click:Connect(function() Sel(t) end)
return p
end
local CT={}
local lo=0
local function Row(pg,h)
lo=lo+1
local f=N("Frame",{Size=UDim2.new(1,0,0,h or 38),BackgroundColor3=PN,BorderSizePixel=0,LayoutOrder=lo},pg)
R(f,7)
return f
end
local function Txt(par,en,th,w,h)
local l=N("TextLabel",{Size=UDim2.new(1,-(w or 60),0,h or 38),Position=UDim2.fromOffset(12,0),BackgroundTransparency=1,TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true},par)
Tr(l,en,th)
return l
end
local function Sec(pg,en,th)
lo=lo+1
local l=N("TextLabel",{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=lo},pg)
Ac(l,"TextColor3");Tr(l,en,th)
end
local function Lbl(pg,en,th)
local l=Txt(Row(pg,32),en,th,24,32)
l.TextColor3=SB
end
local function Dyn(pg,h)
local l=N("TextLabel",{Size=UDim2.new(1,-24,1,-8),Position=UDim2.fromOffset(12,4),BackgroundTransparency=1,TextColor3=SB,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true},Row(pg,h))
return l
end
local function Btn(pg,en,th,cb)
local r=Row(pg,38)
local b=N("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false},r)
Tr(b,en,th,"  ")
b.MouseButton1Click:Connect(function() r.BackgroundColor3=IT;Tw(r,{BackgroundColor3=PN},0.25);Safe(cb) end)
end
local function Tog(pg,key,en,th,cb)
local r=Row(pg,38)
Txt(r,en,th)
local hit=N("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=""},r)
local bg=N("Frame",{Size=UDim2.fromOffset(38,20),Position=UDim2.new(1,-50,0.5,-10),BackgroundColor3=OFF,BorderSizePixel=0},r)
R(bg,10)
local dot=N("Frame",{Size=UDim2.fromOffset(14,14),Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=Color3.fromRGB(215,215,220),BorderSizePixel=0},bg)
R(dot,7)
local o={}
local function Vis(anim)
local c=CF[key] and A or OFF
local p=CF[key] and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)
if anim then Tw(bg,{BackgroundColor3=c});Tw(dot,{Position=p}) else bg.BackgroundColor3=c;dot.Position=p end
end
function o.set(v,silent) CF[key]=v and true or false;Vis(true);if not silent then Safe(cb,CF[key]) end end
function o.apply() Safe(cb,CF[key]) end
Vis(false)
fns[#fns+1]=function() Vis(false) end
hit.MouseButton1Click:Connect(function() o.set(not CF[key]) end)
CT[key]=o
end

local Boost
do
local BX={on=false,job=0,sv=nil,fx=nil,orig=nil,conn=nil}
local FXC={ParticleEmitter=true,Trail=true,Beam=true,Smoke=true,Fire=true,Sparkles=true,PointLight=true,SpotLight=true,SurfaceLight=true}
local PPC={BloomEffect=true,BlurEffect=true,DepthOfFieldEffect=true,SunRaysEffect=true}
local function Lite(o)
local c=o.ClassName
if FXC[c] then
if o.Enabled then BX.fx[o]=true;o.Enabled=false end
elseif c=="Decal" or c=="Texture" then
if not BX.orig[o] then BX.orig[o]={t=o.Transparency};o.Transparency=1 end
elseif o:IsA("BasePart") and c~="Terrain" then
if not BX.orig[o] then
local isMesh=o:IsA("MeshPart")
BX.orig[o]={m=o.Material,r=o.Reflectance,c=o.CastShadow,f=isMesh and o.RenderFidelity or nil}
o.Material=Enum.Material.SmoothPlastic
o.Reflectance=0
o.CastShadow=false
if isMesh then o.RenderFidelity=Enum.RenderFidelity.Performance end
end
end
end
function Boost(on)
if on then
if BX.on then return end
BX.on=true;BX.job=BX.job+1
local job=BX.job
local sv={pp={}}
BX.sv=sv
BX.fx=setmetatable({},{__mode="k"})
BX.orig=setmetatable({},{__mode="k"})
pcall(function() sv.sh=LT.GlobalShadows end)
pcall(function() sv.q=settings().Rendering.QualityLevel end)
pcall(function() sv.md=settings().Rendering.MeshPartDetailLevel end)
pcall(function() LT.GlobalShadows=false end)
pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
pcall(function() settings().Rendering.MeshPartDetailLevel=Enum.MeshPartDetailLevel.Level04 end)
pcall(function()
for _,o in ipairs(LT:GetChildren()) do
if PPC[o.ClassName] and o.Enabled then sv.pp[#sv.pp+1]=o;o.Enabled=false end
end
end)
pcall(function()
local t=workspace.Terrain
sv.w={t.WaterWaveSize,t.WaterWaveSpeed,t.WaterReflectance}
t.WaterWaveSize=0;t.WaterWaveSpeed=0;t.WaterReflectance=0
local cl=t:FindFirstChildOfClass("Clouds")
if cl and cl.Enabled then sv.cl=cl;cl.Enabled=false end
end)
BX.conn=workspace.DescendantAdded:Connect(function(o) pcall(Lite,o) end)
task.spawn(function()
local n=0
for _,o in ipairs(workspace:GetDescendants()) do
if not BX.on or BX.job~=job then return end
pcall(Lite,o)
n=n+1
if n%250==0 then task.wait() end
end
end)
else
if not BX.on then return end
BX.on=false;BX.job=BX.job+1
if BX.conn then BX.conn:Disconnect();BX.conn=nil end
local sv,orig,fx=BX.sv,BX.orig,BX.fx
BX.sv,BX.orig,BX.fx=nil,nil,nil
if sv then
if sv.sh~=nil then pcall(function() LT.GlobalShadows=sv.sh end) end
if sv.q then pcall(function() settings().Rendering.QualityLevel=sv.q end) end
if sv.md then pcall(function() settings().Rendering.MeshPartDetailLevel=sv.md end) end
for _,o in ipairs(sv.pp) do pcall(function() o.Enabled=true end) end
if sv.cl then pcall(function() sv.cl.Enabled=true end) end
if sv.w then pcall(function() local t=workspace.Terrain;t.WaterWaveSize=sv.w[1];t.WaterWaveSpeed=sv.w[2];t.WaterReflectance=sv.w[3] end) end
end
task.spawn(function()
local n=0
if fx then for o in pairs(fx) do pcall(function() o.Enabled=true end) end end
if orig then
for o,v in pairs(orig) do
pcall(function()
if v.t~=nil then o.Transparency=v.t
else
o.Material=v.m;o.Reflectance=v.r;o.CastShadow=v.c
if v.f then o.RenderFidelity=v.f end
end
end)
n=n+1
if n%250==0 then task.wait() end
end
end
end)
end
end
end
local TB={}
TB.Farm=Tab("Farming","1. ฟาร์มหลัก")
TB.Combat=Tab("Combat","2. ระบบต่อสู้")
TB.Raid=Tab("Raids","3. ดันเจี้ยน")
TB.Sea=Tab("Sea Events","4. อีเวนต์ทะเล")
TB.Quest=Tab("Unlocks","5. เควสลับ")
TB.Fruit=Tab("Fruits","6. ผลไม้ปีศาจ")
TB.Move=Tab("Movement","7. การเดินทาง")
TB.PvP=Tab("PvP","8. ระบบ PvP")
TB.Shop=Tab("Stats/Shop","9. สเตตัส/ร้านค้า")
TB.Util=Tab("Utilities","10. เครื่องมือ")

TB.Map=Tab("Map","📊 แมพและข้อมูล")
TB.Pl=Tab("Players","👥 ผู้เล่นทั้งหมด")
TB.Sess=Tab("Session","⏱️ สถิติรอบนี้")
TB.UI=Tab("Interface","🎨 หน้าตา/ภาษา")
TB.Perf=Tab("Performance","⚡ ประสิทธิภาพ")
TB.Cfg=Tab("Remember","💾 จดจำค่า")

Sec(TB.Farm,"Main Farming","ระบบฟาร์มหลัก")
Tog(TB.Farm,"autoFarmLevel","Auto Farm Level","ฟาร์มเลเวลออโต้ (Sea 1-3)",function(on) Toast(on and "Farm Level ON" or "Farm Level OFF","") end)
Tog(TB.Farm,"autoFarmBoss","Auto Farm Selected Boss","ตีบอสประจำเกาะออโต้",function(on) Toast(on and "Farm Boss ON" or "Farm Boss OFF","") end)
Tog(TB.Farm,"autoFarmMastery","Auto Farm Mastery","ฟาร์มมาสเตอรี่ (ดาบ/ปืน/ผล)",function(on) Toast(on and "Farm Mastery ON" or "Farm Mastery OFF","") end)
Tog(TB.Farm,"autoFarmMaterials","Auto Quest Items","ฟาร์มวัตถุดิบ (Bone/Ectoplasm)",function(on) Toast(on and "Farm Materials ON" or "Farm Materials OFF","") end)

Sec(TB.Combat,"Combat & Attack","ระบบการต่อสู้")
Tog(TB.Combat,"fastAttack","Fast Attack","เร่งความเร็วในการโจมตี",function(on) Toast(on and "Fast Attack ON" or "Fast Attack OFF","") end)
Tog(TB.Combat,"bringMobs","Bring Mobs","ดึงมอนสเตอร์มารวมจุดเดียว",function(on) Toast(on and "Bring Mobs ON" or "Bring Mobs OFF","") end)
Tog(TB.Combat,"killAura","Kill / Attack Aura","ออร่าโจมตีมอนสเตอร์รอบตัว",function(on) Toast(on and "Kill Aura ON" or "Kill Aura OFF","") end)
Tog(TB.Combat,"disableCollision","Disable Mob Collision","ปิดการชนมอนสเตอร์ (เดินทะลุ)",function(on) Toast(on and "No-Collision ON" or "No-Collision OFF","") end)

Sec(TB.Raid,"Raid Dungeons","ระบบดันเจี้ยนและเรด")
Tog(TB.Raid,"autoBuyChip","Auto Buy Microchip","ซื้อชิปดันเจี้ยนออโต้",function(on) Toast(on and "Auto Buy Chip ON" or "Auto Buy Chip OFF","") end)
Tog(TB.Raid,"autoStartRaid","Auto Start Raid","กดเริ่มดันเจี้ยนออโต้",function(on) Toast(on and "Auto Start Raid ON" or "Auto Start Raid OFF","") end)
Tog(TB.Raid,"autoAwaken","Auto Awaken Fruit","ปลุกพลังสกิลผลออโต้",function(on) Toast(on and "Auto Awaken ON" or "Auto Awaken OFF","") end)

Sec(TB.Sea,"Sea Events","ระบบอีเวนต์ทางทะเล (Sea 3)")
Tog(TB.Sea,"autoSeaBeast","Auto Sea Beasts / Terror Shark","ฟาร์มสัตว์ทะเล/Terror Shark",function(on) Toast(on and "Sea Event Farm ON" or "Sea Event Farm OFF","") end)
Tog(TB.Sea,"mirageFinder","Mirage Island Finder","ระบบตามหาเกาะมิราจ",function(on) Toast(on and "Mirage Finder ON" or "Mirage Finder OFF","") end)
Tog(TB.Sea,"autoGearV4","Auto Find Gear V4","ค้นหาจุดบูชาทำเควส Gear V4",function(on) Toast(on and "Gear V4 Finder ON" or "Gear V4 Finder OFF","") end)

Sec(TB.Quest,"Unlocks & Quests","ระบบปลดล็อกและเควสลับ")
Tog(TB.Quest,"raceV4Auto","Race V4 Automation","ทำเควสปลดล็อกเผ่า V4 ออโต้",function(on) Toast(on and "Race V4 Quest ON" or "Race V4 Quest OFF","") end)
Tog(TB.Quest,"getLegendarySwords","Legendary Swords Quest","ทำเควสปลดล็อกดาบ (Saber/CDK)",function(on) Toast(on and "Sword Quest ON" or "Sword Quest OFF","") end)
Tog(TB.Quest,"getSoulGuitar","Soul Guitar Quest","ทำเควสลับเอาปืน Soul Guitar",function(on) Toast(on and "Soul Guitar Quest ON" or "Soul Guitar Quest OFF","") end)

Sec(TB.Fruit,"Blox Fruits","ระบบผลไม้ปีศาจ")
Tog(TB.Fruit,"fruitNotifier","Fruit Notifier / ESP","มองเห็นผลไม้ปีศาจทั่วแมพ",function(on) Toast(on and "Fruit ESP ON" or "Fruit ESP OFF","") end)
Tog(TB.Fruit,"autoTeleportFruit","Auto Teleport to Fruit","วาร์ปไปเก็บผลไม้ออโต้",function(on) Toast(on and "Auto TP Fruit ON" or "Auto TP Fruit OFF","") end)
Tog(TB.Fruit,"autoStoreFruit","Auto Store / Random Fruit","สุ่มผลและเก็บเข้าคลังออโต้",function(on) Toast(on and "Auto Store Fruit ON" or "Auto Store Fruit OFF","") end)

Sec(TB.Move,"Teleport & Movement","ระบบการเดินทาง")
Tog(TB.Move,"noclip","Noclip","เดินทะลุกำแพง/สิ่งกีดขวาง",function(on) Toast(on and "Noclip ON" or "Noclip OFF","") end)
Tog(TB.Move,"infJump","Infinite Jump","กระโดดกลางอากาศไม่จำกัด",function(on) Toast(on and "Inf Jump ON" or "Inf Jump OFF","") end)
Tog(TB.Move,"flyMode","Fly Mode","โหมดบินสำรวจแผนที่",function(on) Toast(on and "Fly Mode ON" or "Fly Mode OFF","") end)
Btn(TB.Move,"Tween Teleport to Island","วาร์ปไปเกาะที่เลือก",function() Toast("Teleporting...","กำลังวาร์ป...") end)

Sec(TB.PvP,"Player & PvP","ระบบผู้เล่นและ PvP")
Tog(TB.PvP,"autoBounty","Auto Bounty / Player Farm","ตามล่าผู้เล่นปั๊มค่าหัว",function(on) Toast(on and "Auto Bounty ON" or "Auto Bounty OFF","") end)
Tog(TB.PvP,"playerESP","Player ESP / Tracer","มองทะลุตัวผู้เล่นอื่น",function(on) Toast(on and "Player ESP ON" or "Player ESP OFF","") end)
Tog(TB.PvP,"safeZoneEscape","Safe Zone Escape","วาร์ปหนีเข้าเขตปลอดภัยเมื่อเลือดต่ำ",function(on) Toast(on and "Safe Zone Escape ON" or "Safe Zone Escape OFF","") end)

Sec(TB.Shop,"Stats & Shop","ระบบสเตตัสและร้านค้า")
Tog(TB.Shop,"autoStats","Auto Assign Stats","อัปแต้มสเตตัสออโต้",function(on) Toast(on and "Auto Stats ON" or "Auto Stats OFF","") end)
Btn(TB.Shop,"Remote Buy Haki / Fighting Style","เปิดร้านซื้อฮาคิ/หมัดระยะไกล",function() Toast("Shop Opened","เปิดร้านค้าแล้ว") end)

Sec(TB.Util,"Utilities","ระบบเครื่องมือเสริม")
Tog(TB.Util,"antiAFK","Anti-AFK Protection","ป้องกันโดนเตะเมื่อปล่อยจอทิ้งไว้",function(on) Toast(on and "Anti-AFK ON" or "Anti-AFK OFF","") end)
Btn(TB.Util,"Server Hop (Find New Server)","กดสลับไปเซิร์ฟเวอร์อื่น",function() Toast("Searching Server...","กำลังหาเซิร์ฟเวอร์ใหม่...") end)
Tog(TB.Util,"boost","Remove Textures / FPS Boost","ปิดเอฟเฟกต์โหมดลดแลค",function(on) Boost(on);Toast(on and "FPS Boost ON" or "Graphics Restored","") end)

Sec(TB.Map,"Current map","แมพปัจจุบัน")
local mapName=Dyn(TB.Map,30)
mapName.TextColor3=TX
Lbl(TB.Map,"PlaceId: " .. PID,"PlaceId: " .. PID)
Lbl(TB.Map,"Settings file: " .. FILE,"ไฟล์การตั้งค่า: " .. FILE)
Sec(TB.Map,"Live info","ข้อมูลสด")
local live=Dyn(TB.Map,58)
Sec(TB.Map,"My stats (read-only)","สถานะของฉัน (อ่านอย่างเดียว)")
local stat=Dyn(TB.Map,92)
Tog(TB.Map,"sHud","Show stats on screen","แสดงสถานะบนหน้าจอ",function(on) shud.Visible=on end)

Sec(TB.Pl,"Players in this server","ผู้เล่นในเซิร์ฟเวอร์นี้")
local plCount=Dyn(TB.Pl,26)
Lbl(TB.Pl,"Tap a player to copy their username","แตะที่ชื่อเพื่อคัดลอกชื่อผู้ใช้")
local plRows={}
local function RefreshPlayers()
for _,r in ipairs(plRows) do r:Destroy() end
plRows={}
local list=P:GetPlayers()
table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end)
plCount.Text=T("Players in this map: ","ผู้เล่นในแมพนี้: ") .. #list .. T(" (max "," คน (สูงสุด ") .. P.MaxPlayers .. ")"
for _,pl in ipairs(list) do
local r=Row(TB.Pl,32)
local b=N("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false,TextTruncate=Enum.TextTruncate.AtEnd,Text="  " .. pl.DisplayName .. " (@" .. pl.Name .. ")  ·  " .. pl.AccountAge .. T(" days"," วัน")},r)
if pl==LP then Ac(b,"TextColor3") end
b.MouseButton1Click:Connect(function() Copy(pl.Name) end)
plRows[#plRows+1]=r
end
end
Btn(TB.Pl,"Refresh list","รีเฟรชรายชื่อ",RefreshPlayers)
cn[#cn+1]=P.PlayerAdded:Connect(function() task.defer(RefreshPlayers) end)
cn[#cn+1]=P.PlayerRemoving:Connect(function() task.defer(RefreshPlayers) end)
RefreshPlayers()

Sec(TB.Sess,"This session","รอบการเล่นนี้")
local sess=Dyn(TB.Sess,120)
Btn(TB.Sess,"Reset session stats","รีเซ็ตสถิติรอบนี้",function()
S.start,S.fMin,S.fMax,S.fSum,S.fN,S.pSum,S.pN,S.base=os.clock(),math.huge,0,0,0,0,0,{}
Toast("Session reset","รีเซ็ตแล้ว")
end)
local function SessionText()
local lines={T("Time: ","เวลา: ") .. Clock(os.clock() - S.start)}
if S.fN>0 then lines[#lines+1]="FPS  min " .. S.fMin .. "  avg " .. math.floor(S.fSum/S.fN+0.5) .. "  max " .. S.fMax end
if S.pN>0 then lines[#lines+1]=T("Avg ping: ","ปิงเฉลี่ย: ") .. math.floor(S.pSum/S.pN+0.5) .. " ms" end
local cur,ord=NumStats()
for _,nm in ipairs(ord) do
if S.base[nm]==nil then S.base[nm]=cur[nm] end
local d=cur[nm] - S.base[nm]
lines[#lines+1]=nm .. ": " .. cur[nm] .. "  (" .. (d>=0 and "+" or "") .. d .. ")"
end
return table.concat(lines,"\n")
end

Sec(TB.UI,"Language","ภาษา")
Dd(TB.UI,"lang","Language","ภาษา",{"ไทย","English"},function() SetLang();RefreshPlayers() end)
Sec(TB.UI,"Window","หน้าต่าง")
Sld(TB.UI,"scale","Window size","ขนาดหน้าต่าง",0.5,1.2,0.05,function(v) Tw(ws,{Scale=v}) end)
Sec(TB.UI,"Theme","ธีม")
Dd(TB.UI,"accent","Theme color","สีธีม",AN,Recolor)
Sec(TB.UI,"HUD","แสดงบนหน้าจอ")
Tog(TB.UI,"hud","Show FPS / Ping","แสดง FPS / Ping",function(on) hud.Visible=on end)

Sec(TB.Perf,"Graphics","กราฟิก")
Tog(TB.Perf,"boost","Low-lag mode","โหมดลดแลค",function(on)
Boost(on);Toast(on and "Low-lag mode on" or "Graphics restored",on and "เปิดโหมดลดแลคแล้ว" or "คืนค่ากราฟิกแล้ว")
end)
Lbl(TB.Perf,"Turns off shadows, effects, lights, blur/bloom, clouds and water waves, makes materials plain and hides textures. Only on your screen; the world will look flat.","ปิดเงา เอฟเฟกต์ แสงไฟ เบลอ/บลูม เมฆ คลื่นน้ำ ทำให้พื้นผิวเรียบและซ่อนลวดลาย เห็นผลเฉพาะบนหน้าจอคุณ โลกจะดูเรียบขึ้น")
Sec(TB.Perf,"Camera","กล้อง")
Tog(TB.Perf,"fovOn","Use custom FOV","ใช้ FOV ที่กำหนดเอง",function(on)
if not on and workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=fov0 end
end)
Sld(TB.Perf,"fov","FOV","ค่า FOV",30,120,1,function() end)

Sec(TB.Cfg,"Remember settings","จดจำการตั้งค่า")
local cfgLbl=Dyn(TB.Cfg,56)
local function SaveStatusText()
if saveMode=="file" then return T("Status: remembered ✓ (saved to a file, works after reopening the game)","สถานะ: จดจำแล้ว ✓ (บันทึกลงไฟล์ ใช้ได้แม้ปิดเกมแล้วเปิดใหม่)") end
if saveMode=="mem" then return T("Status: remembered temporarily (this executor can't write files, kept until you close the executor)","สถานะ: จดจำชั่วคราว (executor นี้เขียนไฟล์ไม่ได้ จะจำจนกว่าจะปิด executor)") end
return T("Status: nothing remembered yet","สถานะ: ยังไม่ได้จดจำ")
end
Btn(TB.Cfg,"Remember my settings now","จดจำการตั้งค่าตอนนี้",function()
local json
pcall(function() json=HS:JSONEncode(CF) end)
if not json then Toast("Couldn't save settings","จดจำไม่สำเร็จ");return end
local mode=nil
if writefile then
local ok=pcall(writefile,FILE,json)
if ok then
local back
pcall(function() back=isfile and readfile and isfile(FILE) and readfile(FILE) end)
if back==nil or back==json then mode="file" end
end
end
if not mode then
pcall(function()
local g=getgenv()
g.TiwHubSaved=g.TiwHubSaved or {}
g.TiwHubSaved[FILE]=json
mode="mem"
end)
end
saveMode=mode or saveMode
if mode=="file" then Toast("Settings remembered (saved to file)","จดจำการตั้งค่าแล้ว (บันทึกลงไฟล์)")
elseif mode=="mem" then Toast("Remembered temporarily (no file support)","จดจำชั่วคราว (executor ไม่รองรับไฟล์)")
else Toast("Couldn't save settings","จดจำไม่สำเร็จ") end
end)
Btn(TB.Cfg,"Apply remembered settings","ใช้ค่าที่จดจำไว้",function()
local ok = Load()
if ok then
for k,c in pairs(CT) do c.set(CF[k]) end
SetLang()
Toast("Remembered settings applied","ใช้ค่าที่จดจำไว้แล้ว")
else Toast("Nothing remembered yet","ยังไม่มีค่าที่จดจำไว้") end
end)
Btn(TB.Cfg,"Forget remembered settings","ลบค่าที่จดจำไว้",function()
pcall(function() if delfile and isfile and isfile(FILE) then delfile(FILE) end end)
pcall(function() if getgenv and getgenv().TiwHubSaved then getgenv().TiwHubSaved[FILE]=nil end end)
saveMode=DetectMode()
Toast("Remembered settings cleared","ลบค่าที่จดจำไว้แล้ว")
end)
Lbl(TB.Cfg,"Remembered settings load automatically the next time you run the script","ค่าที่จดจำไว้จะถูกโหลดอัตโนมัติเมื่อรันสคริปต์ครั้งต่อไป")

Sel(tabs[1])
SetLang()
print("[TiwHub] ready with top-level 10 categories!")
