print("[TiwHub] start")
local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local RS=game:GetService("RunService")
local LT=game:GetService("Lighting")
local HS=game:GetService("HttpService")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local PID=game.PlaceId
local FILE="TiwHub_" .. PID .. ".json"
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
local DEF={scale=0.75,accent="Purple",lang="ไทย",hud=false,sHud=false,boost=false,fovOn=false,fov=70,key="RightShift",notes="",wish="",c1=false,c2=false,c3=false,c4=false,c5=false,c6=false}
local CF,SV={},{}
for k,v in pairs(DEF) do CF[k]=v end
local function Load()
return (pcall(function()
if not (isfile and readfile and isfile(FILE)) then error("nofile") end
for k,v in pairs(HS:JSONDecode(readfile(FILE))) do
if DEF[k]~=nil and type(v)==type(DEF[k]) then CF[k]=v;SV[k]=true end
end
end))
end
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
print("[TiwHub] waiting for confirm")
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
local function Sld(pg,key,en,th,mn,mx,st,cb)
local r=Row(pg,52)
Txt(r,en,th,80,28)
local val=N("TextLabel",{Size=UDim2.fromOffset(60,28),Position=UDim2.new(1,-72,0,0),BackgroundTransparency=1,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right},r)
Ac(val,"TextColor3")
local tr=N("Frame",{Size=UDim2.new(1,-24,0,6),Position=UDim2.new(0,12,0,36),BackgroundColor3=OFF,BorderSizePixel=0},r)
R(tr,3)
local fl=N("Frame",{Size=UDim2.new(0,0,1,0),BorderSizePixel=0},tr)
R(fl,3);Ac(fl,"BackgroundColor3")
R(N("Frame",{Size=UDim2.fromOffset(14,14),Position=UDim2.new(1,-7,0.5,-7),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},fl),7)
local hit=N("TextButton",{Size=UDim2.new(1,0,0,26),Position=UDim2.new(0,0,0.5,-13),BackgroundTransparency=1,Text=""},tr)
local o={}
function o.set(v,silent)
v=math.clamp(math.floor((v - mn)/st+0.5)*st+mn,mn,mx)
CF[key]=v
fl.Size=UDim2.new((v - mn)/(mx - mn),0,1,0)
val.Text=(st % 1==0) and tostring(v) or string.format("%.2f",v)
if not silent then Safe(cb,v) end
end
function o.apply() Safe(cb,CF[key]) end
o.set(CF[key],true)
local dr=false
local function From(i) o.set(mn+(mx - mn)*math.clamp((i.Position.X - tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)) end
hit.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dr=true;From(i)
local c
c=i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dr=false;c:Disconnect() end end)
end
end)
cn[#cn+1]=UIS.InputChanged:Connect(function(i)
if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then From(i) end
end)
CT[key]=o
end
local function Dd(pg,key,en,th,opts,cb)
local r=Row(pg,38)
Txt(r,en,th,130)
local b=N("TextButton",{Size=UDim2.new(0,120,1,0),Position=UDim2.new(1,-126,0,0),BackgroundTransparency=1,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right},r)
Ac(b,"TextColor3")
local o={}
function o.set(v,silent) CF[key]=v;b.Text=tostring(v) .. "  ›";if not silent then Safe(cb,v) end end
function o.apply() Safe(cb,CF[key]) end
o.set(CF[key],true)
b.MouseButton1Click:Connect(function()
local n=1
for i,v in ipairs(opts) do if v==CF[key] then n=i end end
o.set(opts[n % #opts+1])
end)
CT[key]=o
end
local orig=nil
local function Boost(on)
if on then
if not orig then orig={s=LT.GlobalShadows};pcall(function() orig.q=settings().Rendering.QualityLevel end) end
pcall(function() LT.GlobalShadows=false end)
pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
elseif orig then
pcall(function() LT.GlobalShadows=orig.s end)
if orig.q then pcall(function() settings().Rendering.QualityLevel=orig.q end) end
orig=nil
end
end
local fov0=workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70
local function StatText()
local out={}
pcall(function()
local d=LP:FindFirstChild("Data")
if MAP and MAP.bf and d then
for _,nm in ipairs({"Level","Beli","Fragments"}) do
local o=d:FindFirstChild(nm)
if o then out[#out+1]=nm .. ": " .. tostring(o.Value) end
end
end
local ls=LP:FindFirstChild("leaderstats")
if ls then
for _,o in ipairs(ls:GetChildren()) do
if o:IsA("ValueBase") then out[#out+1]=o.Name .. ": " .. tostring(o.Value) end
end
end
end)
if #out==0 then return T("No stats found in this map","ไม่พบข้อมูลสถานะในแมพนี้") end
return table.concat(out,"\n")
end
local function NumStats()
local out,ord={},{}
pcall(function()
local d=LP:FindFirstChild("Data")
if MAP and MAP.bf and d then
for _,nm in ipairs({"Level","Beli","Fragments"}) do
local o=d:FindFirstChild(nm)
if o and type(o.Value)=="number" then out[nm]=o.Value;ord[#ord+1]=nm end
end
end
local ls=LP:FindFirstChild("leaderstats")
if ls then
for _,o in ipairs(ls:GetChildren()) do
if o:IsA("ValueBase") and type(o.Value)=="number" and out[o.Name]==nil then out[o.Name]=o.Value;ord[#ord+1]=o.Name end
end
end
end)
return out,ord
end
local function Clock(s) s=math.floor(s);return string.format("%02d:%02d:%02d",math.floor(s/3600),math.floor(s % 3600/60),s % 60) end
local function GetPing()
local p=0
pcall(function() p=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
return p
end
local S={start=os.clock(),fMin=math.huge,fMax=0,fSum=0,fN=0,pSum=0,pN=0,base={}}
local hud=N("TextLabel",{Size=UDim2.fromOffset(150,26),Position=UDim2.fromOffset(10,10),BackgroundColor3=PN,BackgroundTransparency=0.15,Text="FPS --",TextColor3=TX,TextSize=12,Font=Enum.Font.GothamBold,Visible=false},gui)
R(hud,6);St(hud,1)
local shud=N("TextLabel",{Size=UDim2.fromOffset(170,0),AutomaticSize=Enum.AutomaticSize.Y,Position=UDim2.fromOffset(10,42),BackgroundColor3=PN,BackgroundTransparency=0.15,Text="",TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham,TextWrapped=true,Visible=false},gui)
R(shud,6);St(shud,1)
local TB={}
TB.Map,TB.Pl,TB.Sess,TB.Srv,TB.Maps,TB.UI,TB.Perf,TB.Cfg,TB.Tool,TB.Note,TB.Chk,TB.Tmr,TB.Wish=Tab("Map","แมพนี้"),Tab("Players","ผู้เล่น"),Tab("Session","สถิติรอบนี้"),Tab("Server","เซิร์ฟเวอร์"),Tab("Supported Maps","แมพที่รองรับ"),Tab("Interface","หน้าตา/ภาษา"),Tab("Performance","ประสิทธิภาพ"),Tab("Config","ตั้งค่า"),Tab("Tools","เครื่องมือ"),Tab("Notes","โน้ต"),Tab("Checklist","เช็คลิสต์"),Tab("Timer","จับเวลา"),Tab("Wishlist","อยากได้")
Sec(TB.Map,"Current map","แมพปัจจุบัน")
local mapName=Dyn(TB.Map,30)
mapName.TextColor3=TX
Lbl(TB.Map,"PlaceId: " .. PID,"PlaceId: " .. PID)
Lbl(TB.Map,"Settings are saved per map: " .. FILE,"การตั้งค่าบันทึกแยกตามแมพ: " .. FILE)
Sec(TB.Map,"Live info","ข้อมูลสด")
local live=Dyn(TB.Map,58)
Sec(TB.Map,"My stats (read-only)","สถานะของฉัน (อ่านอย่างเดียว)")
local stat=Dyn(TB.Map,92)
Tog(TB.Map,"sHud","Show stats on screen","แสดงสถานะบนหน้าจอ",function(on) shud.Visible=on end)

-- NEW: Players tab
Sec(TB.Pl,"Players in this server","ผู้เล่นในเซิร์ฟเวอร์นี้")
local plCount=Dyn(TB.Pl,26)
Lbl(TB.Pl,"Tap a player to copy their username","แตะที่ชื่อเพื่อคัดลอกชื่อผู้ใช้")
local plRows={}
local function RefreshPlayers()
for _,r in ipairs(plRows) do r:Destroy() end
plRows={}
local list=P:GetPlayers()
table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end)
plCount.Text=T("Total: ","ทั้งหมด: ") .. #list .. "/" .. P.MaxPlayers
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

-- NEW: Session tab
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

-- NEW: Server tab
Sec(TB.Srv,"Server info","ข้อมูลเซิร์ฟเวอร์")
local srv=Dyn(TB.Srv,160)
local placeName=MAP and MAP.n or "-"
task.spawn(function()
local ok,info=pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(PID) end)
if ok and info and info.Name then placeName=info.Name end
end)
local function ServerText()
local jid=game.JobId~="" and game.JobId or "-"
return T("Game: ","เกม: ") .. placeName .. "\nPlaceId: " .. PID .. "\nJobId: " .. jid .. "\n" .. T("Players: ","ผู้เล่น: ") .. #P:GetPlayers() .. "/" .. P.MaxPlayers .. "\n" .. T("Server time: ","เวลาเซิร์ฟเวอร์: ") .. Clock(workspace.DistributedGameTime) .. "\nPing: " .. GetPing() .. " ms\n" .. T("Account age: ","อายุบัญชี: ") .. LP.AccountAge .. T(" days"," วัน")
end
Btn(TB.Srv,"Copy JobId","คัดลอก JobId",function() Copy(game.JobId) end)
Btn(TB.Srv,"Copy PlaceId","คัดลอก PlaceId",function() Copy(tostring(PID)) end)

Sec(TB.Maps,"What each map menu provides","แต่ละแมพมีเมนูอะไรให้ปรับบ้าง")
do
local ids={}
for id in pairs(MAPS) do ids[#ids+1]=id end
table.sort(ids)
for _,id in ipairs(ids) do
local m=MAPS[id]
local mark=(id==PID) and "▶ " or "• "
local extra=m.bf and "Level/Beli/Fragments" or "leaderstats"
Lbl(TB.Maps,mark .. m.n .. "  [" .. extra .. "]",mark .. m.t .. "  [" .. extra .. "]")
end
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
Tog(TB.Perf,"boost","Low-lag mode (no shadows, lowest quality)","โหมดลดแลค (ปิดเงา + กราฟิกต่ำสุด)",function(on)
Boost(on);Toast(on and "Low-lag mode on" or "Graphics restored",on and "เปิดโหมดลดแลค" or "คืนค่ากราฟิกแล้ว")
end)
Sec(TB.Perf,"Camera","กล้อง")
Tog(TB.Perf,"fovOn","Use custom FOV","ใช้ FOV ที่กำหนดเอง",function(on)
if not on and workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=fov0 end
end)
Sld(TB.Perf,"fov","FOV","ค่า FOV",30,120,1,function() end)
Sec(TB.Cfg,"Config (this map)","การตั้งค่า (แมพนี้)")
Btn(TB.Cfg,"Save settings","บันทึกการตั้งค่า",function()
local ok=writefile and pcall(function() writefile(FILE,HS:JSONEncode(CF)) end)
Toast(ok and "Saved" or "Can't save (no writefile)",ok and "บันทึกเรียบร้อย" or "บันทึกไม่ได้ (ไม่รองรับ writefile)")
end)
Btn(TB.Cfg,"Load settings","โหลดการตั้งค่า",function()
if Load() then for k,c in pairs(CT) do c.set(CF[k]) end;SetLang();Toast("Loaded","โหลดเรียบร้อย")
else Toast("No saved file","ไม่พบไฟล์ที่บันทึกไว้") end
end)
Sec(TB.Tool,"Server","เซิร์ฟเวอร์")
Btn(TB.Tool,"Rejoin (same server)","Rejoin (เซิร์ฟเวอร์เดิม)",function() pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(PID,game.JobId,LP) end) end)
Sec(TB.Tool,"Script","สคริปต์")
Btn(TB.Tool,"Unload script","ปิดสคริปต์ (Unload)",function()
for _,c in ipairs(cn) do c:Disconnect() end
Boost(false)
if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=fov0 end
gui:Destroy()
end)

-- NEW: Notes tab
Sec(TB.Note,"My notes (saved with settings)","โน้ตของฉัน (บันทึกพร้อมการตั้งค่า)")
do
local nr=Row(TB.Note,180)
local nb=N("TextBox",{Size=UDim2.new(1,-16,1,-16),Position=UDim2.fromOffset(8,8),BackgroundColor3=DK,BorderSizePixel=0,Text=CF.notes,PlaceholderText=T("Type here...","พิมพ์ที่นี่..."),PlaceholderColor3=SB,TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham,TextWrapped=true,MultiLine=true,ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top},nr)
R(nb,6)
N("UIPadding",{PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8),PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6)},nb)
nb:GetPropertyChangedSignal("Text"):Connect(function() CF.notes=nb.Text end)
CT.notes={set=function(v) CF.notes=v;nb.Text=v end,apply=function() end}
Btn(TB.Note,"Clear notes","ล้างโน้ต",function() nb.Text="" end)
end

-- NEW: Checklist tab (edit CHECKLIST to rename items; keys c1..c6 are saved in settings)
do
Sec(TB.Chk,"Daily checklist","เช็คลิสต์ประจำวัน")
local CHECKLIST={
{"c1","Daily quests","เควสประจำวัน"},
{"c2","Boss hunt","ล่าบอส"},
{"c3","Raid","ลงเรด"},
{"c4","Weapon / fruit mastery","มาสเตอรี่อาวุธ / ผลไม้"},
{"c5","Check fruit stock","เช็คร้านผลไม้"},
{"c6","Sea events","อีเวนต์ทะเล"},
}
for _,c in ipairs(CHECKLIST) do Tog(TB.Chk,c[1],c[2],c[3],function() end) end
Btn(TB.Chk,"Reset checklist","รีเซ็ตเช็คลิสต์",function()
for _,c in ipairs(CHECKLIST) do CT[c[1]].set(false,true) end
end)
Lbl(TB.Chk,"Rename items in the CHECKLIST table in the script","แก้ชื่อรายการได้ที่ตาราง CHECKLIST ในสคริปต์")
end

-- NEW: Timer tab
Sec(TB.Tmr,"Reminder timer","ตัวจับเวลาเตือน")
local tmr=Dyn(TB.Tmr,34)
local tEnd,tLen=nil,0
local function StartTimer(m)
tEnd=os.clock()+m*60;tLen=m
Toast("Timer started: " .. m .. " min","เริ่มจับเวลา " .. m .. " นาที")
end
local function TimerText()
if not tEnd then return T("No timer running","ไม่มีตัวจับเวลา") end
local left=tEnd - os.clock()
if left<=0 then
tEnd=nil
Toast("Time's up! (" .. tLen .. " min)","หมดเวลา! (" .. tLen .. " นาที)")
return T("Time's up!","หมดเวลาแล้ว!")
end
return T("Remaining: ","เหลือ: ") .. Clock(left)
end
Btn(TB.Tmr,"Start 5 minutes","เริ่ม 5 นาที",function() StartTimer(5) end)
Btn(TB.Tmr,"Start 10 minutes","เริ่ม 10 นาที",function() StartTimer(10) end)
Btn(TB.Tmr,"Start 30 minutes","เริ่ม 30 นาที",function() StartTimer(30) end)
Btn(TB.Tmr,"Stop timer","หยุดจับเวลา",function() tEnd=nil end)

-- NEW: Wishlist tab
Sec(TB.Wish,"Fruits / swords I want","ผลไม้ / ดาบที่อยากได้")
do
local wr=Row(TB.Wish,180)
local wb=N("TextBox",{Size=UDim2.new(1,-16,1,-16),Position=UDim2.fromOffset(8,8),BackgroundColor3=DK,BorderSizePixel=0,Text=CF.wish,PlaceholderText=T("One item per line...","หนึ่งบรรทัดต่อหนึ่งรายการ..."),PlaceholderColor3=SB,TextColor3=TX,TextSize=12,Font=Enum.Font.Gotham,TextWrapped=true,MultiLine=true,ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top},wr)
R(wb,6)
N("UIPadding",{PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8),PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6)},wb)
wb:GetPropertyChangedSignal("Text"):Connect(function() CF.wish=wb.Text end)
CT.wish={set=function(v) CF.wish=v;wb.Text=v end,apply=function() end}
end

local ac,fr,a2=0,0,1
cn[#cn+1]=RS.RenderStepped:Connect(function(dt)
if CF.fovOn and workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=CF.fov end
ac=ac+dt;fr=fr+1;a2=a2+dt
if ac>=0.5 then
local ping=GetPing()
local f=math.floor(fr/ac+0.5)
hud.Text="FPS " .. f .. "  |  " .. ping .. " ms"
S.fSum=S.fSum+f;S.fN=S.fN+1
if f<S.fMin then S.fMin=f end
if f>S.fMax then S.fMax=f end
S.pSum=S.pSum+ping;S.pN=S.pN+1
ac,fr=0,0
end
if a2>=1 then
a2=0
mapName.Text=T(MAP.n,MAP.t)
live.Text=T("Players: ","ผู้เล่น: ") .. #P:GetPlayers() .. "/" .. P.MaxPlayers .. "\n" .. T("Server time: ","เวลาเซิร์ฟเวอร์: ") .. Clock(workspace.DistributedGameTime)
local s=StatText()
stat.Text=s
shud.Text=" " .. s:gsub("\n","\n ")
sess.Text=SessionText()
srv.Text=ServerText()
tmr.Text=TimerText()
end
end)
local function Toggle() win.Visible=not win.Visible end
Drag(win,top);Drag(bal,bal,Toggle)
x.MouseButton1Click:Connect(Toggle)
cn[#cn+1]=UIS.InputBegan:Connect(function(i,gp)
if not gp and i.UserInputType==Enum.UserInputType.Keyboard and i.KeyCode.Name==CF.key then Toggle() end
end)
Sel(tabs[1])
for k,c in pairs(CT) do if SV[k] then c.apply() end end
hud.Visible=CF.hud
shud.Visible=CF.sHud
SetLang()
Toast("Loaded! Tap TIW or press " .. CF.key,"โหลดสำเร็จ! แตะ TIW หรือกด " .. CF.key)
print("[TiwHub] ready")
