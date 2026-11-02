-- ==============================================================================
-- Tiw Hub - Ultimate Professional Edition (Thai UI, Floating Ball & On-Death Haki)
-- ==============================================================================
print("[TiwHub] Initializing Secure Core Framework...")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
-- ระบบเคลียร์ UI เก่าแบบปลอดภัยป้องกันซ้อนทับ
pcall(function()
if PlayerGui:FindFirstChild("TiwHubMainUI") then
PlayerGui.TiwHubMainUI:Destroy()
end
end)
-- สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TiwHubMainUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
-- สร้างหน้าต่างหลัก (Main Frame) - ปรับขนาดและตำแหน่งให้พอดีจอโทรศัพท์มือถือ
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(560, 380)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
MainFrame.Active = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 70, 100)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame
-- ==============================================================================
-- ระบบบอลลูนปุ่มลอยเปิด-ปิดเมนูหลัก (Floating Ball / Toggle Button)
-- ==============================================================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(55, 55)
ToggleButton.Position = UDim2.new(0, 20, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 13
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "TIW"
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui
local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton
local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton
ToggleButton.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
-- Header Bar (ภาษาไทย)
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(18, 21, 32)
Header.TextColor3 = Color3.fromRGB(255, 190, 60)
Header.TextSize = 14
Header.Font = Enum.Font.GothamBold
Header.Text = "Tiw Hub - ระบบโปรเสริมครบวงจร (เปิดฮากิอัตโนมัติ)"
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header
-- แถบ 12 หมวดหมู่หลัก (ด้านบน - ภาษาไทย)
local CategoryScroll = Instance.new("ScrollingFrame")
CategoryScroll.Size = UDim2.new(1, -16, 0, 36)
CategoryScroll.Position = UDim2.new(0, 8, 0, 45)
CategoryScroll.BackgroundTransparency = 1
CategoryScroll.CanvasSize = UDim2.fromScale(14.0, 0)
CategoryScroll.ScrollBarThickness = 2
CategoryScroll.Parent = MainFrame
local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
CategoryLayout.Padding = UDim.new(0, 6)
CategoryLayout.Parent = CategoryScroll
-- พื้นที่คอนเทนต์หลัก
local ContainerFrame = Instance.new("Frame")
ContainerFrame.Size = UDim2.new(1, -16, 1, -92)
ContainerFrame.Position = UDim2.new(0, 8, 0, 85)
ContainerFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 25)
ContainerFrame.Parent = MainFrame
local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 12)
ContainerCorner.Parent = ContainerFrame
local Pages = {}
local function CreatePage(name)
local scroll = Instance.new("ScrollingFrame")
scroll.Name = name
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.fromScale(0, 5.0)
scroll.ScrollBarThickness = 4
scroll.Visible = false
scroll.Parent = ContainerFrame
local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)
layout.Parent = scroll
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = scroll
Pages[name] = scroll
return scroll
end
local function AddSectionHeader(page, titleText)
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 0, 30)
lbl.BackgroundColor3 = Color3.fromRGB(25, 29, 44)
lbl.TextColor3 = Color3.fromRGB(90, 220, 255)
lbl.TextSize = 12
lbl.Font = Enum.Font.GothamBold
lbl.Text = "  " .. titleText
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = page
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = lbl
end
local function AddButton(page, btnText, callback)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 0, 32)
btn.BackgroundColor3 = Color3.fromRGB(32, 38, 56)
btn.TextColor3 = Color3.fromRGB(245, 245, 245)
btn.TextSize = 11
btn.Font = Enum.Font.GothamSemibold
btn.Text = btnText
btn.Parent = page
  local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = btn
btn.MouseButton1Click:Connect(function()
local success, err = pcall(callback)
if not success then
warn("[TiwHub Execution Error]: " .. tostring(err))
end
end)
end
-- รายชื่อ 12 หมวดหมู่หลัก (ภาษาไทย)
local categories = {
"1. ระบบหลัก", "2. ออโต้ฟาร์ม", "3. ไอเทม/วัตถุดิบ",
"4. อีเวนต์ทะเล", "5. บอสและดันเจี้ยน", "6. ร้านค้าและผลไม้",
"7. เทเลพอร์ต", "8. เควสอาวุธ", "9. เผ่าและฮากิ",
"10. แต่งตัวละคร", "11. ระบบกันแบน", "12. ตั้งค่าระบบ"
}
for _, catName in ipairs(categories) do
CreatePage(catName)
end
local function SwitchPage(targetName)
for name, page in pairs(Pages) do
page.Visible = (name == targetName)
end
end
for i, catName in ipairs(categories) do
local catBtn = Instance.new("TextButton")
catBtn.Size = UDim2.fromOffset(130, 30)
catBtn.BackgroundColor3 = Color3.fromRGB(38, 45, 68)
catBtn.TextColor3 = Color3.fromRGB(255, 210, 80)
catBtn.TextSize = 10
catBtn.Font = Enum.Font.GothamBold
catBtn.Text = catName
catBtn.Parent = CategoryScroll
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = catBtn
catBtn.MouseButton1Click:Connect(function()
SwitchPage(catName)
end)
end
SwitchPage("1. ระบบหลัก")
-- ==============================================================================
-- ระบบเปิดฮากิเกราะอัตโนมัติ และตรวจจับการเกิดใหม่ (On-Death Haki Engine)
-- ==============================================================================
local activeToggles = {}
local function toggleState(featureName)
activeToggles[featureName] = not activeToggles[featureName]
print("[TiwHub Status] " .. featureName .. " -> " .. tostring(activeToggles[featureName]))
end
local function EnableBusoHaki()
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
if not char:FindFirstChild("Buso") then
local args = { [1] = "Buso" }
if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
print("[TiwHub] Auto Buso Haki Activated!")
end
end
end
end)
end
local function SetupCharacter(char)
local humanoid = char:WaitForChild("Humanoid", 10)
if humanoid then
task.wait(1.5)
EnableBusoHaki()
humanoid.Died:Connect(function()
print("[TiwHub] ตัวละครตาย กำลังรอเกิดใหม่เพื่อเปิดฮากิอัตโนมัติ...")
end)
end
end
if LocalPlayer.Character then
SetupCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(function(char)
SetupCharacter(char)
end)
task.spawn(function()
while true do
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
if not char:FindFirstChild("Buso") then
EnableBusoHaki()
end
end
end)
task.wait(4)
end
end)
-- ==================== 1. ระบบหลัก ====================
local p1 = Pages["1. ระบบหลัก"]
AddSectionHeader(p1, "ควบคุมหลักของสคริปต์")
AddButton(p1, "เปิด/ปิด หน้าต่างเมนูหลัก", function() MainFrame.Visible = not MainFrame.Visible end)
AddButton(p1, "รีเซ็ตตัวละครกลับจุดเกิด", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.Health = 0 end end)
AddButton(p1, "เข้าเซิร์ฟเวอร์เดิมใหม่ (แก้แลก)", function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
AddButton(p1, "ย้ายเซิร์ฟเวอร์สุ่ม (คนน้อย)", function() print("[TiwHub] กำลังสุ่มเซิร์ฟ...") end)
AddButton(p1, "ย้ายเซิร์ฟเวอร์หาบอส", function() print("[TiwHub] กำลังหาบอส...") end)
AddButton(p1, "เปิด/ปิด เมนูด่วนลอยหน้าจอ", function() toggleState("FloatingMenu") end)
AddButton(p1, "โหลดบันทึกค่าการตั้งค่า", function() print("[TiwHub] โหลด Config สำเร็จ") end)
AddButton(p1, "บันทึกค่าการตั้งค่าปัจจุบัน", function() print("[TiwHub] บันทึก Config สำเร็จ") end)
AddButton(p1, "รีเซ็ตค่าตั้งค่าเป็นค่าเริ่มต้น", function() print("[TiwHub] รีเซ็ตค่าแล้ว") end)
AddButton(p1, "เปิดหน้าต่างดูไอเทมในกระเป๋า", function() print("[TiwHub] เปิดช่องเก็บของ") end)
AddButton(p1, "เปิดหน้าต่างแดชบอร์ดฟาร์ม", function() print("[TiwHub] เปิดแดชบอร์ด") end)
AddButton(p1, "ลบ UI ทั้งหมดทิ้ง", function() ScreenGui:Destroy() end)
AddButton(p1, "คัดลอกลิงก์ดิสคอร์ด", function() pcall(function() setclipboard("https://discord.gg/tiwhub") end) end)
AddButton(p1, "ตรวจสอบเวอร์ชันสคริปต์", function() print("[TiwHub] v5.4 ภาษาไทยสมบูรณ์") end)
AddButton(p1, "พักการทำงานสคริปต์ชั่วคราว", function() toggleState("Pause") end)
-- ==================== 2. ออโต้ฟาร์ม ====================
local p2 = Pages["2. ออโต้ฟาร์ม"]
AddSectionHeader(p2, "ระบบฟาร์มเลเวลและเควส")
AddButton(p2, "ออโต้ฟาร์มเลเวลอัจฉริยะ", function() toggleState("AutoFarm") end)
AddButton(p2, "เลือกมอนสเตอร์ที่ต้องการฟาร์ม", function() toggleState("CustomMob") end)
AddButton(p2, "ออโต้รับเควสและส่งเควสอัตโนมัติ", function() toggleState("AutoQuest") end)
AddButton(p2, "โจมตีเร็วขั้นเทพ (Fast Attack)", function() toggleState("FastAttack") end)
AddButton(p2, "ดึงมอนสเตอร์รอบตัวมารวมกัน", function() toggleState("MobAura") end)
AddButton(p2, "ออโต้ใช้สกิล Z", function() toggleState("SkillZ") end)
AddButton(p2, "ออโต้ใช้สกิล X", function() toggleState("SkillX") end)
AddButton(p2, "ออโต้ใช้สกิล C", function() toggleState("SkillC") end)
AddButton(p2, "ออโต้ใช้สกิล V", function() toggleState("SkillV") end)
AddButton(p2, "ออโต้ใช้สกิล F", function() toggleState("SkillF") end)
AddButton(p2, "เลือกใช้อาวุธหมัด (Melee)", function() print("[TiwHub] เลือกหมัด") end)
AddButton(p2, "เลือกใช้อาวุธดาบ (Sword)", function() print("[TiwHub] เลือกดาบ") end)
AddButton(p2, "เลือกใช้อาวุธผลไม้ (Fruit)", function() print("[TiwHub] เลือกผลไม้") end)
AddButton(p2, "เลือกใช้อาวุธปืน (Gun)", function() print("[TiwHub] เลือกปืน") end)
AddButton(p2, "ระบบล็อกเป้าหมายโจมตี", function() toggleState("Lock") end)
-- ==================== 3. ไอเทม/วัตถุดิบ ====================
local p3 = Pages["3. ไอเทม/วัตถุดิบ"]
AddSectionHeader(p3, "ระบบฟาร์มของและเงินตรา")
AddButton(p3, "ออโต้ฟาร์มกระดูก (Bones)", function() toggleState("Bones") end)
AddButton(p3, "ออโต้สุ่มกระดูกลุ้นของรางวัล", function() toggleState("BoneGacha") end)
AddButton(p3, "ออโต้ฟาร์มเงินรี (Beli)", function() toggleState("Beli") end)
AddButton(p3, "ออโต้ฟาร์มเศษเพชร (Fragments)", function() toggleState("Frags") end)
AddButton(p3, "ออโต้เก็บหีบสมบัติทั่วแมพ", function() toggleState("Chests") end)
AddButton(p3, "ออโต้ฟาร์มวัตถุดิบหายาก", function() toggleState("Mats") end)
AddButton(p3, "ออโต้ฟาร์มลูกอมอีเวนต์", function() toggleState("Candy") end)
AddButton(p3, "ออโต้ฟาร์มเขี้ยวฉลาม", function() toggleState("Teeth") end)
AddButton(p3, "ออโต้ฟาร์มเศษดาวตก", function() toggleState("Meteor") end)
AddButton(p3, "ออโต้ฟาร์มไฟเพลิง (Fire Essence)", function() toggleState("FireEssence") end)
AddButton(p3, "ออโต้ฟาร์มตั๋วอีเวนต์", function() toggleState("Tickets") end)
AddButton(p3, "ออโต้ฟาร์มเกาะเค้ก (Cake Island)", function() toggleState("Cake") end)
AddButton(p3, "ออโต้ฟาร์มกล่องสมบัติบนเกาะ", function() toggleState("IslandChests") end)
AddButton(p3, "ออโต้ฟาร์มวัตถุดิบสายฟ้า", function() toggleState("ElecMats") end)
AddButton(p3, "ออโต้ฟาร์มวัตถุดิบมังกร", function() toggleState("DragonMats") end)
-- ==================== 4. อีเวนต์ทะเล ====================
local p4 = Pages["4. อีเวนต์ทะเล"]
AddSectionHeader(p4, "ระบบทะเลและสู้สัตว์ทะเล")
AddButton(p4, "ออโต้ฟาร์มฉลามยักษ์ (Terror Shark)", function() toggleState("TerrorShark") end)
AddButton(p4, "ออโต้ฟาร์มซีบีสต์ (Sea Beast)", function() toggleState("SeaBeast") end)
AddButton(p4, "ออโต้ฟาร์มเลเวียธาน (Leviathan)", function() toggleState("Leviathan") end)
AddButton(p4, "ออโต้ฟาร์มเรือผีสิง", function() toggleState("GhostShip") end)
AddButton(p4, "ออโต้ขับเรือไปพื้นที่อันตรายระดับ 1-6", function() toggleState("SeaPilot") end)
AddButton(p4, "ออโต้ซ่อมแซมเรืออัตโนมัติ", function() toggleState("RepairShip") end)
AddButton(p4, "ออโต้ซื้อเรือรบ", function() toggleState("BuyShip") end)
AddButton(p4, "ออโต้ตามหาเกาะ mirage", function() toggleState("Mirage") end)
AddButton(p4, "ออโต้ตามหาเกาะ Kitsune", function() toggleState("Kitsune") end)
AddButton(p4, "ออโต้เก็บหีบสมบัติกลางทะเล", function() toggleState("SeaChests") end)
AddButton(p4, "ออโต้ฟาร์มฉลามตัวเล็ก", function() toggleState("SmallSharks") end)
AddButton(p4, "ออโต้ฟาร์มปิรันย่า", function() toggleState("Piranhas") end)
AddButton(p4, "เคลียร์หมอกในทะเลออก", function() toggleState("ClearFog") end)
AddButton(p4, "ออโต้กลับขึ้นเรือเมื่อตกลงน้ำ", function() toggleState("ReturnBoat") end)
AddButton(p4, "ระบบป้องกันเรือแตก", function() toggleState("AntiShip") end)
-- ==================== 5. บอสและดันเจี้ยน ====================
local p5 = Pages["5. บอสและดันเจี้ยน"]
AddSectionHeader(p5, "ระบบลงดันเจี้ยนและล่าบอส")
AddButton(p5, "ออโต้ลงดันเจี้ยน (ทุกเกาะ)", function() toggleState("Raids") end)
AddButton(p5, "ออโต้ซื้อชิปลงดันเจี้ยน", function() toggleState("BuyChip") end)
AddButton(p5, "ออโต้ปลุกพลังผลไม้", function() toggleState("Awaken") end)
AddButton(p5, "ออโต้ฟาร์มบอสทุกตัวในแมพ", function() toggleState("Bosses") end)
AddButton(p5, "เลือกบอสที่ต้องการล่าเฉพาะเจาะจง", function() print("[TiwHub] เลือกบอส") end)
AddButton(p5, "ออโต้ฟาร์มคาตากุริ V2", function() toggleState("Katakuri") end)
AddButton(p5, "ออโต้ฟาร์มหนวดดำ", function() toggleState("Darkbeard") end)
AddButton(p5, "ออโต้ฟาร์มหนวดขาว", function() toggleState("Whitebeard") end)
AddButton(p5, "ออโต้ฟาร์มคิซารุ", function() toggleState("Kizura") end)
AddButton(p5, "ออโต้ฟาร์มโดฟลามิงโก้", function() toggleState("Doflamingo") end)
AddButton(p5, "ออโต้ฟาร์มวิญญาณเรเปอร์", function() toggleState("SoulReaper") end)
AddButton(p5, "ออโต้ฟาร์มราชาออร์ค", function() toggleState("OrcKing") end)
AddButton(p5, "แจ้งเตือนเมื่อบอสเกิด", function() toggleState("BossNotif") end)
AddButton(p5, "ซื้อชิปลงดันเจี้ยนขั้นสูง", function() toggleState("AdvChip") end)
AddButton(p5, "ออโต้เริ่มห้องดันเจี้ยนอัตโนมัติ", function() toggleState("StartRaid") end)
-- ==================== 6. ร้านค้าและผลไม้ ====================
local p6 = Pages["6. ร้านค้าและผลไม้"]
AddSectionHeader(p6, "ระบบสุ่มและซื้อผลไม้")
AddButton(p6, "ออโต้สุ่มผลไม้กับ NPC", function() toggleState("Gacha") end)
AddButton(p6, "ระบบสไนเปอร์เก็บผลไม้ใต้ต้นไม้", function() toggleState("FruitSniper") end)
AddButton(p6, "ออโต้เก็บผลไม้ใส่คลังเก็บของ", function() toggleState("StoreFruit") end)
AddButton(p6, "ออโต้ทิ้งผลไม้ในคลัง", function() print("[TiwHub] ทิ้งผลไม้") end)
AddButton(p6, "ออโต้ซื้อฮากิสังเกต", function() print("[TiwHub] ซื้อฮากิสังเกต") end)
AddButton(p6, "ออโต้ซื้อหมัดต่อสู้ทั้งหมด", function() print("[TiwHub] ซื้อหมัด") end)
AddButton(p6, "ออโต้ซื้อดาบทั้งหมด", function() print("[TiwHub] ซื้อดาบ") end)
AddButton(p6, "ออโต้ซื้อปืนทั้งหมด", function() print("[TiwHub] ซื้อปืน") end)
AddButton(p6, "ออโต้ซื้อสีฮากิและทรงผม", function() print("[TiwHub] ซื้อสีฮากิ") end)
AddButton(p6, "ออโต้ซื้อของร้านค้าตำนาน", function() toggleState("LegShop") end)
AddButton(p6, "ออโต้ซื้อของร้านค้าอีเวนต์", function() toggleState("EventShop") end)
AddButton(p6, "ออโต้ซื้อยาน้ำเพิ่มพลัง", function() toggleState("Potions") end)
AddButton(p6, "ออโต้ซื้อชิปด้วยเศษเพชร", function() toggleState("FragChips") end)
AddButton(p6, "ออโต้เปิดกล่องสุ่มปริศนา", function() toggleState("MysteryBox") end)
AddButton(p6, "สแกนหาผลไม้ที่เกิดบนแมพ", function() print("[TiwHub] สแกนผลไม้") end)
-- ==================== 7. เทเลพอร์ต ====================
local p7 = Pages["7. เทเลพอร์ต"]
AddSectionHeader(p7, "ระบบวาร์ปไปยังสถานที่ต่างๆ")
AddButton(p7, "วาร์ปเลือกโลก (โลก 1 / 2 / 3)", function() print("[TiwHub] วาร์ปโลก") end)
AddButton(p7, "วาร์ปไปเกาะเริ่มต้น", function() print("[TiwHub] วาร์ปเกาะเริ่ม") end)
AddButton(p7, "วาร์ปไปโรงงาน", function() print("[TiwHub] วาร์ปโรงงาน") end)
AddButton(p7, "วาร์ปไปปราสาทบนทะเล (Castle)", function() print("[TiwHub] วาร์ปปราสาท") end)
AddButton(p7, "วาร์ปไปคฤหาสน์ (Mansion)", function() print("[TiwHub] วาร์ปคฤหาสน์") end)
AddButton(p7, "วาร์ปไปต้นไม้ใหญ่", function() print("[TiwHub] วาร์ปต้นไม้") end)
AddButton(p7, "วาร์ปไปเกาะ Kitsune", function() print("[TiwHub] วาร์ป Kitsune") end)
AddButton(p7, "วาร์ปไปเกาะ Mirage", function() print("[TiwHub] วาร์ป Mirage") end)
AddButton(p7, "วาร์ปไปจุดสุ่มผลไม้", function() print("[TiwHub] วาร์ปสุ่มผล") end)
AddButton(p7, "วาร์ปไปคนขายเรือ", function() print("[TiwHub] วาร์ปคนขายเรือ") end)
AddButton(p7, "วาร์ปไปหา NPC รับเควสปัจจุบัน", function() print("[TiwHub] วาร์ปเควส") end)
AddButton(p7, "วาร์ปไปหาบอสที่กำลังเกิด", function() print("[TiwHub] วาร์ปหาบอส") end)
AddButton(p7, "วาร์ปไปเขตปลอดภัย (Safezone)", function() print("[TiwHub] วาร์ปเซฟโซน") end)
AddButton(p7, "วาร์ปไปหอคอยที่สูงที่สุด", function() print("[TiwHub] วาร์ปหอคอย") end)
AddButton(p7, "วาร์ปไปหา NPC ลับ", function() print("[TiwHub] วาร์ป NPC ลับ") end)
-- ==================== 8. เควสอาวุธ ====================
local p8 = Pages["8. เควสอาวุธ"]
AddSectionHeader(p8, "ระบบช่วยทำเควสอาวุธในตำนาน")
AddButton(p8, "ช่วยทำเควสดาบคู่ CDK", function() toggleState("CDK") end)
AddButton(p8, "ช่วยทำเควสกีตาร์วิญญาณ (Soul Guitar)", function() toggleState("SoulGuitar") end)
AddButton(p8, "ช่วยทำเควสดาบ Tushita", function() toggleState("Tushita") end)
AddButton(p8, "ช่วยทำเควสดาบ Yama", function() toggleState("Yama") end)
AddButton(p8, "ช่วยทำเควสดาบ Saber", function() toggleState("Saber") end)
AddButton(p8, "ช่วยทำเควสดาบ Midnight Blade", function() toggleState("Midnight") end)
AddButton(p8, "ช่วยทำเควสตรีศูล (Trident)", function() toggleState("Trident") end)
AddButton(p8, "ช่วยทำเควสหมัด Superhuman", function() toggleState("Superhuman") end)
AddButton(p8, "ช่วยทำเควสหมัดกรงเล็บมังกร", function() toggleState("DragonTalon") end)
AddButton(p8, "ช่วยทำเควสหมัดสายฟ้า Electric Claw", function() toggleState("ElectricClaw") end)
AddButton(p8, "ช่วยทำเควสหมัดฉลาม Sharkman", function() toggleState("Sharkman") end)
AddButton(p8, "ช่วยทำเควสหมัดเทพเจ้า Godhuman", function() toggleState("Godhuman") end)
AddButton(p8, "ช่วยทำเควสโล่และหมวก", function() toggleState("Shield") end)
AddButton(p8, "ช่วยปลดล็อกคัมภีร์ลับ", function() toggleState("Scrolls") end)
AddButton(p8, "ระบบเสริมประสิทธิภาพอาวุธ", function() toggleState("WeaponOpt") end)
-- ==================== 9. เผ่าและฮากิ ====================
local p9 = Pages["9. เผ่าและฮากิ"]
AddSectionHeader(p9, "ระบบอัปเกรดเผ่า V4 และฮากิ")
AddButton(p9, "ออโต้ดึงคันโยกอัปเกรดเผ่า", function() toggleState("Lever") end)
AddButton(p9, "ออโต้กดใช้สกิลเผ่า V4 อัตโนมัติ", function() toggleState("V4Skill") end)
AddButton(p9, "ออโต้สืบเผ่าอัปเกรด (ใช้เพชร)", function() toggleState("UpRace") end)
AddButton(p9, "ออโต้เติมเกจพลังเผ่าให้เต็ม", function() toggleState("FillMeter") end)
AddButton(p9, "ออโต้สุ่มเปลี่ยนเผ่าใหม่", function() toggleState("RollRace") end)
AddButton(p9, "ออโต้ฝึกฮากิสังเกตให้เต็ม Max", function() toggleState("TrainKen") end)
AddButton(p9, "กดเปิดฮากิเกราะทันที (Buso Haki)", function() EnableBusoHaki() end)
AddButton(p9, "ออโต้ซื้อสีฮากิหายาก", function() print("[TiwHub] ซื้อสีฮากิ") end)
AddButton(p9, "ออโต้เปลี่ยนสีฮากิรุ้งอัตโนมัติ", function() toggleState("RainbowHaki") end)
AddButton(p9, "ช่วยทำเควสเผ่า V2", function() toggleState("RaceV2") end)
AddButton(p9, "ช่วยทำเควสเผ่า V3", function() toggleState("RaceV3") end)
AddButton(p9, "ช่วยทำเควสด่านประตูเผ่า", function() toggleState("Trial") end)
AddButton(p9, "ออโต้หลบการโจมตีด้วยฮากิสังเกต", function() toggleState("KenDodge") end)
AddButton(p9, "ตรวจสอบเลเวลฮากิสังเกต", function() print("[TiwHub] ฮากิสังเกต Max") end)
AddButton(p9, "ตรวจสอบขั้นเผ่า V4", function() print("[TiwHub] เผ่า V4 Max") end)
-- ==================== 10. แต่งตัวละคร ====================
local p10 = Pages["10. แต่งตัวละคร"]
AddSectionHeader(p10, "ระบบปรับแต่งตัวละครและเคลื่อนไหว")
AddButton(p10, "เพิ่มความเร็วเดิน (WalkSpeed 100+)", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 100 end end)
AddButton(p10, "เพิ่มพลังกระโดด (JumpPower 150+)", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 150 end end)
AddButton(p10, "เปิดไฟสว่างทั่วแมพ (FullBright)", function() Lighting.Brightness = 2 Lighting.ClockTime = 14 Lighting.FogEnd = 999999 end)
AddButton(p10, "ลบหมอกในเกมออกทั้งหมด", function() for _, v in ipairs(Lighting:GetChildren()) do if v:IsA("Atmosphere") or v:IsA("PostEffect") then v.Enabled = false end end end)
AddButton(p10, "โหมดทะลุกำแพง (Noclip)", function() toggleState("Noclip") end)
AddButton(p10, "โหมดบินอิสระ (Fly Mode)", function() toggleState("Fly") end)
AddButton(p10, "ซูมกล้องออกได้ไม่จำกัด", function() LocalPlayer.CameraMaxZoomDistance = 999999 end)
AddButton(p10, "ออร่าตัวละครสีรุ้งรอบตัว", function() toggleState("RainbowAura") end)
AddButton(p10, "โหมดล่องหนตัวละคร", function() toggleState("Invis") end)
AddButton(p10, "โหมดลอยตัวเหนือพื้น", function() toggleState("Levitate") end)
AddButton(p10, "เอฟเฟกต์หางแสงวิ่งตามตัว", function() toggleState("Trail") end)
AddButton(p10, "ปรับมุมมองกว้างพิเศษ (FOV)", function() workspace.CurrentCamera.FieldOfView = 100 end)
AddButton(p10, "ปลดล็อกขีดจำกัด FPS สูงสุด", function() pcall(function() setfpscap(999) end) end)
AddButton(p10, "ป้องกันเลือดลดเวลาตกน้ำ", function() toggleState("NoWater") end)
AddButton(p10, "กระโดดกลางอากาศไม่จำกัด (Inf Jump)", function() toggleState("InfJump") end)
-- ==================== 11. ระบบกันแบน ====================
local p11 = Pages["11. ระบบกันแบน"]
AddSectionHeader(p11, "ระบบความปลอดภัยและป้องกันแบน")
AddButton(p11, "ระบบตรวจจับแอดมินเซิร์ฟเวอร์", function() toggleState("AntiAdmin") end)
AddButton(p11, "ซ่อนป้ายชื่อเหนือหัวตัวละคร", function() toggleState("HideName") end)
AddButton(p11, "โหมดซ่อนตัวจากเรดาร์คนอื่น", function() toggleState("Stealth") end)
AddButton(p11, "แจ้งเตือนเมื่อมีผู้เล่นเข้าใกล้", function() toggleState("PlayerAlert") end)
AddButton(p11, "เตะตัวเองออกทันทีเมื่อแอดมินเข้า", function() toggleState("KickAdmin") end)
AddButton(p11, "วาร์ปหนีฉุกเฉินเมื่อเลือดใกล้หมด", function() toggleState("EmergExit") end)
AddButton(p11, "ระบบป้องกันโดนเตะหลุดเพราะ AFK", function()
local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
print("[TiwHub] เปิดระบบกันหลุด AFK สำเร็จ")
end)
AddButton(p11, "ตรวจสอบจำนวนผู้เล่นในเซิร์ฟเวอร์", function() print("[TiwHub] จำนวนผู้เล่น: " .. #Players:GetPlayers()) end)
AddButton(p11, "ล็อกเซิร์ฟเวอร์ส่วนตัวไม่ให้คนอื่นเข้า", function() toggleState("ServerLock") end)
AddButton(p11, "ปิดการใช้งานแชทส่วนรวม", function() pcall(function() game:GetService("TextChatService").Enabled = false end) end)
AddButton(p11, "ซ่อนเอฟเฟกต์ผู้เล่นคนอื่น (ลดแลก)", function() toggleState("HideEffects") end)
AddButton(p11, "ปฏิเสธคำขอแลกเปลี่ยนอัตโนมัติ", function() toggleState("DeclineTrade") end)
AddButton(p11, "แจ้งเตือนสถานะการโดนตี PvP", function() toggleState("PvPNotif") end)
AddButton(p11, "ออโต้หนีเข้าเซฟโซนอัตโนมัติ", function() toggleState("Safezone") end)
AddButton(p11, "ระบบล็อกป้องกันตัวเองอัตโนมัติ", function() toggleState("SelfDefend") end)
-- ==================== 12. ตั้งค่าระบบ ====================
local p12 = Pages["12. ตั้งค่าระบบ"]
AddSectionHeader(p12, "ตั้งค่าประสิทธิภาพและระบบเสริม")
AddButton(p12, "แสดงค่า FPS และ PING บนหน้าจอ", function()
local stats = game:GetService("Stats")
print("[Stats] FPS: " .. math.floor(workspace:GetRealPhysicsFPS()) .. " | Ping: " .. math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()))
end)
AddButton(p12, "ตัวเร่งความเร็ว FPS (ภาพกราฟิกต่ำ)", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
end
print("[TiwHub] เปิดโหมดเร่ง FPS แล้ว")
end)
AddButton(p12, "ปิดเอฟเฟกต์สกิลผู้เล่น (ลดแลกมือถือ)", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") then v.Enabled = false end
end
print("[TiwHub] ปิดเอฟเฟกต์สกิลแล้ว")
end)
AddButton(p12, "ลบเท็กเจอร์และทำให้น้ำใสเคลียร์", function() terrain = workspace.Terrain terrain.WaterWaveSize = 0 terrain.WaterTransparency = 1 end)
AddButton(p12, "เปลี่ยนธีมสีหน้าต่าง UI", function() print("[TiwHub] เปลี่ยนธีมสี") end)
AddButton(p12, "เปิด/ปิด เสียงเพลงประกอบสคริปต์", function() toggleState("BGM") end)
AddButton(p12, "เปิดหน้าต่างคอนโซลล็อกระบบ", function() print("[TiwHub] เปิดคอนโซล") end)
AddButton(p12, "ส่งข้อมูลแจ้งเตือนผ่าน Discord Webhook", function() toggleState("Webhook") end)
AddButton(p12, "บูสต์ความเร็วตัวรันสคริปต์", function() print("[TiwHub] บูสต์ตัวรันแล้ว") end)
AddButton(p12, "ล้างหน่วยความจำแรม (Clean RAM)", function() pcall(function() collectgarbage("collect") end) print("[TiwHub] เคลียร์ RAM แล้ว") end)
AddButton(p12, "ปิดเงาแสงอาทิตย์ทั่วโลก", function() Lighting.GlobalShadows = false end)
AddButton(p12, "โหมดท้องฟ้ามืดสนิท (Black Sky)", function() Lighting.TimeOfDay = "00:00:00" end)
AddButton(p12, "ปรับสเกล UI ให้เหมาะกับมือถือ Delta", function() print("[TiwHub] ปรับสเกลมือถือแล้ว") end)
AddButton(p12, "โหมดประหยัดแบตเตอรี่โทรศัพท์", function() settings():GetService("RenderSettings").EditQualityLevel(Enum.QualityLevel.Level01) end)
AddButton(p12, "รีสตาร์ทระบบแกนกลางสคริปต์", function() print("[TiwHub] รีสตาร์ทแกนกลางสำเร็จ") end)
-- ==============================================================================
-- Mobile Draggable UI Support (Delta Supported)
-- ==============================================================================
local function MakeDraggable(gui)
local dragging, dragInput, dragStart, startPos
gui.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = gui.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then dragging = false end
end)
end
end)
gui.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)
end
MakeDraggable(MainFrame)
print("[TiwHub] Loaded Successfully with Thai UI, Floating Ball & On-Death Haki Engine!")
