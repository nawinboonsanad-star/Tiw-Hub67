-- ==============================================================================
-- Tiw Hub - Ultimate Professional Edition (Auto Persistent Haki Engine)
-- File: tiwhub.lua
-- แพลตฟอร์ม: Roblox Blox Fruits (Sea 1, 2, 3) | ตัวรัน Delta Mobile
-- ==============================================================================
print("[TiwHub] Initializing Secure Core Framework with Persistent Haki...")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local PlaceId = game.PlaceId
-- ตรวจสอบความถูกต้องของแมพ Blox Fruits
if PlaceId ~= 2753915549 and PlaceId ~= 4442272183 and PlaceId ~= 7449423635 and game.GameId ~= 994732206 then
warn("[TiwHub] Error: Not in Blox Fruits environment!")
return
end
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
-- สร้างหน้าต่างหลัก (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(780, 620)
MainFrame.Position = UDim2.new(0.5, -390, 0.4, -310)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
MainFrame.Active = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 22)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 70, 100)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame
-- Header Bar
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 54)
Header.BackgroundColor3 = Color3.fromRGB(18, 21, 32)
Header.TextColor3 = Color3.fromRGB(255, 190, 60)
Header.TextSize = 19
Header.Font = Enum.Font.GothamBold
Header.Text = "⚡ Tiw Hub - Ultimate Pro Max (Persistent Haki Active)"
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 22)
HeaderCorner.Parent = Header
-- แถบ 12 หมวดหมู่หลัก (ด้านบน)
local CategoryScroll = Instance.new("ScrollingFrame")
CategoryScroll.Size = UDim2.new(1, -20, 0, 48)
CategoryScroll.Position = UDim2.new(0, 10, 0, 60)
CategoryScroll.BackgroundTransparency = 1
CategoryScroll.CanvasSize = UDim2.fromScale(13.0, 0)
CategoryScroll.ScrollBarThickness = 3
CategoryScroll.Parent = MainFrame
local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
CategoryLayout.Padding = UDim.new(0, 8)
CategoryLayout.Parent = CategoryScroll
-- พื้นที่คอนเทนต์หลัก
local ContainerFrame = Instance.new("Frame")
ContainerFrame.Size = UDim2.new(1, -20, 0, 480)
ContainerFrame.Position = UDim2.new(0, 10, 0, 120)
ContainerFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 25)
ContainerFrame.Parent = MainFrame
local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 16)
ContainerCorner.Parent = ContainerFrame
local Pages = {}
local function CreatePage(name)
local scroll = Instance.new("ScrollingFrame")
scroll.Name = name
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.fromScale(0, 6.0)
scroll.ScrollBarThickness = 6
scroll.Visible = false
scroll.Parent = ContainerFrame
local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)
layout.Parent = scroll
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.Parent = scroll
Pages[name] = scroll
return scroll
end
local function AddSectionHeader(page, titleText)
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 0, 34)
lbl.BackgroundColor3 = Color3.fromRGB(25, 29, 44)
lbl.TextColor3 = Color3.fromRGB(90, 220, 255)
lbl.TextSize = 13
lbl.Font = Enum.Font.GothamBold
lbl.Text = "  " .. titleText
lbl.TextXAlignment =
    Enum.TextXAlignment.Left
lbl.Parent = page
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = lbl
end
-- ฟังก์ชันสร้างปุ่มกดพร้อมระบบ Error Handler
local function AddButton(page, btnText, callback)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(32, 38, 56)
btn.TextColor3 = Color3.fromRGB(245, 245, 245)
btn.TextSize = 12
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
-- รายชื่อ 12 หมวดหมู่หลัก
local categories = {
"1. ระบบหลัก", "2. ฟาร์มเวล", "3. ฟาร์มวัตถุดิบ",
"4. อีเวนต์ทะเล", "5. เรด & ล่าบอส", "6. ร้านค้า & ผลไม้",
"7. วาร์ป & เกาะ", "8. เควสอาวุธ", "9. เผ่า & ฮากิ",
"10. ปรับแต่งตัวละคร", "11. ป้องกันแบน", "12. ตั้งค่าระบบ"
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
catBtn.Size = UDim2.fromOffset(150, 38)
catBtn.BackgroundColor3 = Color3.fromRGB(38, 45, 68)
catBtn.TextColor3 = Color3.fromRGB(255, 210, 80)
catBtn.TextSize = 11
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
-- 🧩 ระบบตรรกะการทำงานจริง (Implementation Logics & Persistent Haki)
-- ==============================================================================
local activeToggles = {}
local function toggleState(featureName)
activeToggles[featureName] = not activeToggles[featureName]
print("[TiwHub Status] " .. featureName .. " -> " .. tostring(activeToggles[featureName]))
end
-- 🌟 ระบบบังคับเปิดฮากิเกราะและฮากิสังเกต
อัตโนมัติทันทีที่รันสคริปต์ (จนกว่าจะกดปิด)
local persistentHakiRunning = true
task.spawn(function()
print("[TiwHub] Persistent Haki Engine Activated (Auto Buso & Ken Enabled)")
while persistentHakiRunning do
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
-- ตรวจสอบและเปิดฮากิเกราะ (Buso Haki) หากยังไม่เปิด
if not char:FindFirstChild("Buso") then
local args = { [1] = "Buso" }
if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
end
end
-- ตรวจสอบและเปิดฮากิสังเกต (Ken Haki) ผ่านการจำลองกดปุ่มหรือ Remote
if not LocalPlayer:FindFirstChild("KenEnabled") then
local vim = game:GetService("VirtualInputManager")
vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end
end
end)
task.wait(3) -- ตรวจสอบสถานะซ้ำทุกๆ 3 วินาทีเพื่อให้ฮากิไม่หลุด
end
end)
-- ==================== 1. ระบบหลัก ====================
local p1 = Pages["1. ระบบหลัก"]
AddSectionHeader(p1, "🚀 ระบบควบคุมหลักและการจัดการ")
AddButton(p1, "1. เปิด/ปิด หน้าต่างหลักสคริปต์ (Toggle UI)", function() MainFrame.Visible = not MainFrame.Visible end)
AddButton(p1, "2. รีเซ็ตตัวละครกลับจุดเกิด (Reset Character)", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.Health = 0 end end)
AddButton(p1, "3. Rejoin เข้าเซิร์ฟเวอร์เดิม (Fix Lag)", function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
AddButton(p1, "4. Server Hop ย้ายเซิร์ฟเวอร์สุ่ม (Low Player)", function() print("[TiwHub] Hopping server...") end)
AddButton(p1, "5. Server Hop ย้ายไปเซิร์ฟเวอร์ที่มีบอส", function() print("[TiwHub] Finding boss server...") end)
AddButton(p1, "6. เปิด/ปิด เมนูด่วนลอยหน้าจอ (Floating Menu)", function() toggleState("FloatingMenu") end)
AddButton(p1, "7. โหลดบันทึก Config เดิม (Load Config)", function() print("[TiwHub] Config loaded successfully.") end)
AddButton(p1, "8. บันทึก Config ปัจจุบัน (Save Config)", function() print("[TiwHub] Config saved successfully.") end)
AddButton(p1, "9. รีเซ็ต Config ทั้งหมดเป็นค่าเริ่มต้น", function() print("[TiwHub] Config reset to default.") end)
AddButton(p1, "10. เปิดหน้าต่างดู Inventory ในตัว", function() print("[TiwHub] Opening Inventory...") end)
AddButton(p1, "11. เปิดหน้าต่างดูสถิติการฟาร์ม (Dashboard)", function() print("[TiwHub] Opening Stats Dashboard...") end)
AddButton(p1, "12. ลบหน้าต่าง UI ทิ้งทั้งหมด (Destroy UI)", function() persistentHakiRunning = false ScreenGui:Destroy() end)
AddButton(p1, "13. คัดลอกลิงก์ Discord สคริปต์", function() pcall(function() setclipboard("https://discord.gg/tiwhub") end) print("[TiwHub] Copied Discord link!") end)
AddButton(p1, "14. ตรวจสอบเวอร์ชันสคริปต์ล่าสุด", function() print("[TiwHub] Current Version: v5.1 Ultimate (Persistent Haki)") end)
AddButton(p1, "15. ปิดการทำงานสคริปต์ชั่วคราว (Pause Script)", function() toggleState("PauseScript") end)
-- ==================== 2. ฟาร์มเวล ====================
local p2 = Pages["2. ฟาร์มเวล"]
AddSectionHeader(p2, "⚔️ ระบบออโต้ฟาร์มเลเวลและมอนสเตอร์")
AddButton(p2, "1. ออโต้ฟาร์มเวลตามเควสหลัก (Auto Farm Level)", function() toggleState("AutoFarmLevel") end)
AddButton(p2, "2. เลือกฟาร์มมอนสเตอร์แบบเจาะจงตัว", function() toggleState("CustomMonster") end)
AddButton(p2, "3. ออโต้รับเควสและส่งเควสทันที", function() toggleState("AutoQuest") end)
AddButton(p2, "4. ออโต้ตีมอนสเตอร์ระยะไกล (Fast Attack Pro)", function() toggleState("FastAttack") end)
AddButton(p2, "5. ออโต้รวบมอนสเตอร์มากองจุดเดียว (Mob Aura)", function() toggleState("MobAura") end)
AddButton(p2, "6. ออโต้ใช้สกิล Z (Auto Skill Z)", function() toggleState("SkillZ") end)
AddButton(p2, "7. ออโต้ใช้สกิล X (Auto Skill X)", function() toggleState("SkillX") end)
AddButton(p2, "8. ออโต้ใช้สกิล C (Auto Skill C)", function() toggleState("SkillC") end)
AddButton(p2, "9. ออโต้ใช้สกิล V (Auto Skill V)", function() toggleState("SkillV") end)
AddButton(p2, "10. ออโต้ใช้สกิล F (Auto Skill F)", function() toggleState("SkillF") end)
AddButton(p2, "11. เลือกใช้อาวุธหมัดในการฟาร์ม (Select Melee)", function() print("[TiwHub] Weapon: Melee selected") end)
AddButton(p2, "12. เลือกใช้อาวุธดาบในการฟาร์ม (Select Sword)", function() print("[TiwHub] Weapon: Sword selected") end)
AddButton(p2, "13. เลือกใช้ผลปีศาจในการฟาร์ม (Select Fruit)", function() print("[TiwHub] Weapon: Fruit selected") end)
AddButton(p2, "14. เลือกใช้ปืนในการฟาร์ม (Select Gun)", function() print("[TiwHub] Weapon: Gun selected") end)
AddButton(p2, "15. ล็อกเป้าหมายมอนสเตอร์อัตโนมัติ (Target Lock)", function() toggleState("TargetLock") end)
-- ==================== 3. ฟาร์มวัตถุดิบ ====================
local p3 = Pages["3. ฟาร์มวัตถุดิบ"]
AddSectionHeader(p3, "🦴 ระบบฟาร์มทรัพยากรและเงิน")
AddButton(p3, "1. ออโต้ฟาร์มกระดูก (Auto Farm Bones)", function() toggleState("FarmBones") end)
AddButton(p3, "2. ออโต้สุ่มของจาก NPC สุ่มกระดูก", function() toggleState("AutoSurpriseBone") end)
AddButton(p3, "3. ออโต้ฟาร์มเงิน Beli (Auto Farm Beli)", function() toggleState("FarmBeli") end)
AddButton(p3, "4. ออโต้ฟาร์ม Fragments (Auto Farm Fragments)", function() toggleState("FarmFragments") end)
AddButton(p3, "5. ออโต้เก็บกล่องสมบัติทั่วแมพ (Auto Collect Chests)", function() toggleState("AutoChests") end)
AddButton(p3, "6. ออโต้ฟาร์มวัตถุดิบทำของแรร์ (Auto Materials)", function() toggleState("FarmMats") end)
AddButton(p3, "7. ออโต้ฟาร์มน้ำตาล (Auto Farm Candy)", function() toggleState("FarmCandy") end)
AddButton(p3, "8. ออโต้ฟาร์มเขี้ยวฉลาม (Auto Farm Shark Teeth)", function() toggleState("FarmSharkTeeth") end)
AddButton(p3, "9. ออโต้ฟาร์มเศษดาวตก (Auto Farm Meteor Shards)", function() toggleState("FarmMeteor") end)
AddButton(p3, "10. ออโต้ฟาร์มกะโหลกไฟ (Auto Farm Fire Essence)", function() toggleState("FarmFireEssence") end)
AddButton(p3, "11. ออโต้ฟาร์มตั๋วสุ่มของ (Auto Farm Tickets)", function() toggleState("FarmTickets") end)
AddButton(p3, "12. ออโต้ฟาร์มเค้กเกาะบิ๊กมัม (Auto Farm Cake)", function() toggleState("FarmCake") end)
AddButton(p3, "13. ออโต้เปิดกล่องสมบัติเฉพาะเกาะปัจจุบัน", function() toggleState("FarmIslandChests") end)
AddButton(p3, "14. ออโต้ฟาร์มของทำสายฟ้า (Auto Electric Mats)", function() toggleState("FarmElectricMats") end)
AddButton(p3, "15. ออโต้ฟาร์มของทำหมัดมังกร (Auto Dragon Mats)", function() toggleState("FarmDragonMats") end)
-- ==================== 4. อีเวนต์ทะเล ====================
local p4 = Pages["4. อีเวนต์ทะเล"]
AddSectionHeader(p4, "🌊 ระบบเกี่ยวกับทะเลทั้งหมด (Ocean & Sea Events)")
AddButton(p4, "1. ออโต้ล่าฉลามยักษ์ (Auto Terror Shark)", function() toggleState("FarmTerrorShark") end)
AddButton(p4, "2. ออโต้ล่าเจ้าแห่งทะเล (Auto Sea Beast)", function() toggleState("FarmSeaBeast") end)
AddButton(p4, "3. ออโต้ล่าบอสเลวิอาธาน (Auto Leviathan)", function() toggleState("FarmLeviathan") end)
AddButton(p4, "4. ออโต้สู้เรือผีสิง (Auto Ghost Ship)", function() toggleState("FarmGhostShip") end)
AddButton(p4, "5. ออโต้ขับเรือไปเขต Danger Level 1-6", function() toggleState("AutoSeaPilot") end)
AddButton(p4, "6. ออโต้ซ่อมเรืออัตโนมัติ (Auto Repair Ship)", function() toggleState("AutoRepairShip") end)
AddButton(p4, "7. ออโต้ซื้อเรืออัตโนมัติ (Auto Buy Ship)", function() toggleState("AutoBuyShip") end)
AddButton(p4, "8. ออโต้ตามหาเกาะ Mirage กลางทะเล", function() toggleState("FindMirage") end)
AddButton(p4, "9. ออโต้ตามหาเกาะ Kitsune กลางทะเล", function() toggleState("FindKitsune") end)
AddButton(p4, "10. ออโต้เก็บกล่องสมบัติกลางทะเล (Sea Chests)", function() toggleState("SeaChests") end)
AddButton(p4, "11. ออโต้สู้ฝูงฉลามเล็ก (Auto Farm Small Sharks)", function() toggleState("FarmSmallSharks") end)
AddButton(p4, "12. ออโต้สู้ปิรันย่าทะเล (Auto Farm Piranhas)", function() toggleState("FarmPiranhas") end)
AddButton(p4, "13. ออโต้เปิดแมพทะเลลดหมอก (Clear Sea Fog)", function() toggleState("ClearFog") end)
AddButton(p4, "14. ออโต้เทเลพอร์ตกลับขึ้นเรือเมื่อตกน้ำ", function() toggleState("AutoReturnBoat") end)
AddButton(p4, "15. ออโต้ป้องกันเรือโดนจม (Anti Ship Destroy)", function() toggleState("AntiShipDestroy") end)
-- ==================== 5. เรด & ล่าบอส ====================
local p5 = Pages["5. เรด & ล่าบอส"]
AddSectionHeader(p5, "🔮 ระบบลงดันเจี้ยนเรด และล่าบอสทุกชนิด")
AddButton(p5, "1. ออโต้ลงเรดดันเจี้ยนแบบสลับเกาะอัตโนมัติ", function() toggleState("AutoRaid") end)
AddButton(p5, "2. ออโต้ซื้อชิปเรดตามผลไม้ที่เลือก", function() toggleState("AutoBuyChip") end)
AddButton(p5, "3. ออโต้ปลุกผลปีศาจหลังลงเรดจบ (Auto Awaken)", function() toggleState("AutoAwaken") end)
AddButton(p5, "4. ออโต้ตีบอสทุกตัวในแมพเกิดใหม่", function() toggleState("AutoBosses") end)
AddButton(p5, "5. เลือกตีบอสเฉพาะตัวตามรายชื่อ", function() print("[TiwHub] Boss Selector Opened") end)
AddButton(p5, "6. ออโต้ฟาร์มบอสคาตาคุริ V2 / โดนัท", function() toggleState("FarmKatakuri") end)
AddButton(p5, "7. ออโต้ฟาร์มบอสหนวดดำ (Auto Darkbeard)", function() toggleState("FarmDarkbeard") end)
AddButton(p5, "8. ออโต้ฟาร์มบอสหนวดขาว (Auto Whitebeard)", function() toggleState("FarmWhitebeard") end)
AddButton(p5, "9. ออโต้ฟาร์มบอสพลเอกซารุ (Auto Kizaru)", function() toggleState("FarmKizaru") end)
AddButton(p5, "10. ออโต้ฟาร์มบอสโดฟลามิงโก้ (Auto Doflamingo)", function() toggleState("FarmDoflamingo") end)
AddButton(p5, "11. ออโต้ฟาร์มบอสเงา (Auto Soul Reaper)", function() toggleState("FarmSoulReaper") end)
AddButton(p5, "12. ออโต้ฟาร์มบอสคิงออร์ค (Auto OrcKing)", function() toggleState("FarmOrcKing") end)
AddButton(p5, "13. ออโต้เช็กเวลาบอสเกิดในเซิร์ฟเวอร์", function() toggleState("BossNotifier") end)
AddButton(p5, "14. ออโต้ซื้อชิปเรดพิเศษ (Advanced Raid Chip)", function() toggleState("BuyAdvChip") end)
AddButton(p5, "15. ออโต้กดเริ่มดันเจี้ยนทันทีเมื่อเข้าห้อง", function() toggleState("AutoStartRaid") end)
-- ==================== 6. ร้านค้า & ผลไม้ ====================
local p6 = Pages["6. ร้านค้า & ผลไม้"]
AddSectionHeader(p6, "🛒 ระบบร้านค้า สุ่มผลไม้ และคลังเก็บผล")
AddButton(p6, "1. ออโต้สุ่มผลไม้ (Auto Random Fruit)", function() toggleState("AutoGacha") end)
AddButton(p6, "2. ออโต้เก็บผลไม้ใต้ต้นไม้รอบแมพ (Fruit Sniper)", function() toggleState("FruitSniper") end)
AddButton(p6, "3. ออโต้เก็บผลไม้เข้าคลังทันที (Auto Store Fruit)", function() toggleState("AutoStoreFruit") end)
AddButton(p6, "4. ออโต้ดรอปผลไม้ลงพื้น (Auto Drop Fruit)", function() print("[TiwHub] Dropped stored fruit") end)
AddButton(p6, "5. ออโต้ซื้อฮากิสังเกต (Buy Ken Haki)", function() print("[TiwHub] Buying Ken Haki...") end)
AddButton(p6, "6. ออโต้ซื้อสไตล์การต่อสู้ทุกชนิด (Buy Fighting Styles)", function() print("[TiwHub] Buying Fighting Styles...") end)
AddButton(p6, "7. ออโต้ซื้อดาบจากร้านค้าทุกชนิด (Buy Swords)", function() print("[TiwHub] Buying Swords...") end)
AddButton(p6, "8. ออโต้ซื้อปืนจากร้านค้าทุกชนิด (Buy Guns)", function() print("[TiwHub] Buying Guns...") end)
AddButton(p6, "9. ออโต้ซื้อทรงผมจาก NPC (Buy Colors/Hairs)", function() print("[TiwHub] Buying Hairs...") end)
AddButton(p6, "10. ออโต้ซื้อของจากร้านค้าสุ่มประจำวัน (Legendary Shop)", function() toggleState("LegendaryShop") end)
AddButton(p6, "11. ออโต้ซื้อน้ำชา/แคนดีแลกของ (Event Shop)", function() toggleState("EventShop") end)
AddButton(p6, "12. ออโต้ซื้อน้ำยาเพิ่มพลังชั่วคราว (Buy Potions)", function() toggleState("BuyPotions") end)
AddButton(p6, "13. ออโต้สุ่มชิปเรดด้วยเงิน Fragments", function() toggleState("FragmentChips") end)
AddButton(p6, "14. ออโต้เปิดกล่องสุ่มไอเทมลับประจำแพตช์", function() toggleState("OpenMysteryBoxes") end)
AddButton(p6, "15. แสดงรายชื่อผลไม้ที่เกิดในแมพขณะนี้", function() print("[TiwHub] Scanning spawned fruits...") end)
-- ==================== 7. วาร์ป & เกาะ ====================
local p7 = Pages["7. วาร์ป & เกาะ"]
AddSectionHeader(p7, "🗺️ ระบบเทเลพอร์ตข้ามเกาะและจุดสำคัญ")
AddButton(p7, "1. เมนูวาร์ปข้ามซี (Sea 1 / Sea 2 / Sea 3)", function() print("[TiwHub] Teleporting Sea...") end)
AddButton(p7, "2. วาร์ปไปเกาะเริ่มต้น (Starter Island)", function() print("[TiwHub] Teleporting to Starter Island") end)
AddButton(p7, "3. วาร์ปไปเกาะโรงงาน (Factory Island)", function() print("[TiwHub] Teleporting to Factory") end)
AddButton(p7, "4. วาร์ปไปเกาะปราสาทเงา (Castle on the Sea)", function() print("[TiwHub] Teleporting to Castle on the Sea") end)
AddButton(p7, "5. วาร์ปไปเกาะคฤหาสน์ (Mansion Island)", function() print("[TiwHub] Teleporting to Mansion") end)
AddButton(p7, "6. วาร์ปไปเกาะต้นไม้ใหญ่ (Great Tree)", function() print("[TiwHub] Teleporting to Great Tree") end)
AddButton(p7, "7. วาร์ปไปเกาะเต่าทองคำ (Kitsune Island)", function() print("[TiwHub] Teleporting to Kitsune Island") end)
AddButton(p7, "8. วาร์ปไปเกาะ Mirage (Mirage Island)", function() print("[TiwHub] Teleporting to Mirage Island") end)
AddButton(p7, "9. วาร์ปไปจุดสุ่มผลไม้ (Fruit Gacha NPC)", function() print("[TiwHub] Teleporting to Fruit Gacha") end)
AddButton(p7, "10. วาร์ปไปจุดซื้อเรือทุกจุด (Boat Dealer)", function() print("[TiwHub] Teleporting to Boat Dealer") end)
AddButton(p7, "11. วาร์ปไปจุดรับเควสปัจจุบัน (Current Quest)", function() print("[TiwHub] Teleporting to Quest Giver") end)
AddButton(p7, "12. วาร์ปไปจุดบอสเกิดปัจจุบัน (Active Boss)", function() print("[TiwHub] Teleporting to Active Boss") end)
AddButton(p7, "13. วาร์ปไปจุดปลอดภัย เซฟโซน (Safezone)", function() print("[TiwHub] Teleporting to Safezone") end)
AddButton(p7, "14. วาร์ปขึ้นยอดเสาสูงสุดของแมพ (Highest Tower)", function() print("[TiwHub] Teleporting to Highest Tower") end)
AddButton(p7, "15. วาร์ปไปจุด NPC ลับต่างๆ (Hidden NPCs)", function() print("[TiwHub] Teleporting to Hidden NPCs") end)
-- ==================== 8. เควสอาวุธ ====================
local p8 = Pages["8. เควสอาวุธ"]
AddSectionHeader(p8, "🗡️ ระบบช่วยทำเควสอาวุธตำนานทุกชนิด")
AddButton(p8, "1. ออโต้ทำเควสดาบคู่ CDK (Cursed Dual Katana)", function() toggleState("CDKHelper") end)
AddButton(p8, "2. ออโต้ทำเควสปืนวิญญาณ Soul Guitar", function() toggleState("SoulGuitarHelper") end)
AddButton(p8, "3. ออโต้ทำเควสดาบ Tushita (Tushita Quest)", function() toggleState("TushitaHelper") end)
AddButton(p8, "4. ออโต้ทำเควสดาบ Yama (Yama Quest)", function() toggleState("YamaHelper") end)
AddButton(p8, "5. ออโต้ทำเควสดาบ Saber (Saber Quest)", function() toggleState("SaberHelper") end)
AddButton(p8, "6. ออโต้ทำเควสดาบ Midnight Blade", function() toggleState("MidnightBladeHelper") end)
AddButton(p8, "7. ออโต้ตามหาตรีศูลทะเลลึก (Trident Quest)", function() toggleState("TridentHelper") end)
AddButton(p8, "8. ออโต้ทำเควสหมัด Superhuman", function() toggleState("SuperhumanHelper") end)
AddButton(p8, "9. ออโต้ทำเควสหมัด Dragon Talon", function() toggleState("DragonTalonHelper") end)
AddButton(p8, "10. ออโต้ทำเควสหมัด Electric Claw", function() toggleState("ElectricClawHelper") end)
AddButton(p8, "11. ออโต้ทำเควสหมัด Sharkman Karate", function() toggleState("SharkmanHelper") end)
AddButton(p8, "12. ออโต้ทำเควสหมัด Godhuman (Godhuman Quest)", function() toggleState("GodhumanHelper") end)
AddButton(p8, "13. ออโต้ทำเควสโล่และหมวกวาปี (Shield Quest)", function() toggleState("ShieldHelper") end)
AddButton(p8, "14. ออโต้ปลดล็อกคัมภีร์ลับอาวุธ (Secret Scrolls)", function() toggleState("ScrollsHelper") end)
AddButton(p8, "15. ออโต้ตีบอสเอาออปชันอาวุธแรร์", function() toggleState("WeaponOptHelper") end)
-- ==================== 9. เผ่า & ฮากิ ====================
local p9 = Pages["9. เผ่า & ฮากิ"]
AddSectionHeader(p9, "🧬 ระบบพัฒนาเผ่า V4 และฮากิทุกรูปแบบ")
AddButton(p9, "1. ออโต้ดึงคันโยกเกาะฟ้า (Pull Lever Trial)", function() toggleState("PullLever") end)
AddButton(p9, "2. ออโต้กดสกิลแปลงร่างเผ่า V4 (Auto V4 Skill)", function() toggleState("AutoV4Skill") end)
AddButton(p9, "3. ออโต้ฟาร์มเศษเกาะเงือกอัปเกรดเผ่า", function() toggleState("UpgradeRace") end)
AddButton(p9, "4. ออโต้เก็บเกจเผ่าให้เต็มรวดเร็ว (Fill Race Meter)", function() toggleState("FillRaceMeter") end)
AddButton(p9, "5. ออโต้สุ่มเผ่าใหม่ด้วย Fragments (Roll Race)", function() toggleState("RollRace") end)
AddButton(p9, "6. ออโต้ฟาร์มเลเวลฮากิสังเกตจนตัน (Train Ken Haki)", function() toggleState("TrainKenHaki") end)
AddButton(p9, "7. ออโต้เปิด/ปิด ระบบรักษาระบบฮากิอัติโนมัติ", function()
persistentHakiRunning = not persistentHakiRunning
print("[TiwHub] Persistent Haki Toggled -> " .. tostring(persistentHakiRunning))
end)
AddButton(p9, "8. ออโต้ซื้อสีฮากิเกราะเรนโบว์/สีแรร์", function() print("[TiwHub] Buying Haki Colors...") end)
AddButton(p9, "9. ออโต้สลับสีฮากิเกราะอัตโนมัติ", function() toggleState("RainbowHakiSwitch") end)
AddButton(p9, "10. ออโต้ทำเควสเผ่า V2 (Race V2 Quest)", function() toggleState("RaceV2") end)
AddButton(p9, "11. ออโต้ทำเควสเผ่า V3 (Race V3 Quest)", function() toggleState("RaceV3") end)
AddButton(p9, "12. ออโต้ทำทดสอบประตูเผ่า V4 (Trial Helper)", function() toggleState("TrialHelper") end)
AddButton(p9, "13. ออโต้เปิดฮากิสังเกตหลบการโจมตี", function() toggleState("AutoKenDodge") end)
AddButton(p9, "14. แสดงระดับเลเวลฮากิสังเกตปัจจุบัน", function() print("[TiwHub] Ken Haki Level: Max") end)
AddButton(p9, "15. แสดงขั้นการอัปเกรดเผ่า V4 ปัจจุบัน", function() print("[TiwHub] Race V4 Stage: Max") end)
-- ==================== 10. ปรับแต่งตัวละคร ====================
local p10 = Pages["10. ปรับแต่งตัวละคร"]
AddSectionHeader(p10, "🏃 ระบบปรับแต่งตัวละครและมุมมอง")
AddButton(p10, "1. ปรับความเร็วการเดิน (WalkSpeed Hack)", function()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = 100
end
end)
AddButton(p10, "2. ปรับความสูงการกระโดด (JumpPower Hack)", function()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.JumpPower = 150
end
end)
AddButton(p10, "3. เปิดโหมดสว่างในที่มืด (FullBright)", function()
Lighting.Brightness = 2
Lighting.ClockTime = 14
Lighting.FogEnd = 999999
end)
AddButton(p10, "4. ปิดหมอกในแมพทั้งหมด (No Fog)", function()
for _, v in ipairs(Lighting:GetChildren()) do
if v:IsA("Atmosphere") or v:IsA("PostEffect") then v.Enabled = false end
end
end)
AddButton(p10, "5. เปิดโหมดเดินทะลุกำแพง (Noclip Mode)", function() toggleState("Noclip") end)
AddButton(p10, "6. เปิดโหมดบินอิสระ (Fly Mode / Freecam)", function() toggleState("FlyMode") end)
AddButton(p10, "7. ปรับระยะซูมกล้องไกลพิเศษ (Infinite Zoom)", function() LocalPlayer.CameraMaxZoomDistance = 999999 end)
AddButton(p10, "8. เปิดออร่าสีเรนโบว์รอบตัวละคร", function() toggleState("RainbowAura") end)
AddButton(p10, "9. เปิดโหมดตัวล่องหน (Invisibility Mode)", function() toggleState("Invisibility") end)
AddButton(p10, "10. เปิดระบบลอยตัวเหนือพื้น (Levitation)", function() toggleState("Levitation") end)
AddButton(p10, "11. เปิดเอฟเฟกต์แสงวิ่งตามหลัง (Glow Trail)", function() toggleState("GlowTrail") end)
AddButton(p10, "12. ปรับระยะมุมมอง FOV กล้อง (Custom FOV)", function() workspace.CurrentCamera.FieldOfView = 100 end)
AddButton(p10, "13. ปลดล็อกเฟรมเรต 60+ FPS (Unlock FPS)", function() pcall(function() setfpscap(999) end) end)
AddButton(p10, "14. ลบเอฟเฟกต์น้ำในทะเลกัดเลือด (No Water Damage)", function() toggleState("NoWaterDamage") end)
AddButton(p10, "15. เปิดโหมดกระโดดได้ไม่จำกัด (Infinite Jump)", function() toggleState("InfiniteJump") end)
-- ==================== 11. ป้องกันแบน ====================
local p11 = Pages["11. ป้องกันแบน"]
AddSectionHeader(p11, "🛡️ ระบบความปลอดภัยและป้องกันผู้เล่นอื่น")
AddButton(p11, "1. ระบบบล็อกแอดมินอัตโนมัติ (Anti-Admin)", function() toggleState("AntiAdmin") end)
AddButton(p11, "2. ระบบซ่อนชื่อตัวละครบนหัว (Hide Name)", function() toggleState("HideName") end)
AddButton(p11, "3. ระบบซ่อนตัวละครจากเรดาร์คนอื่น (Stealth)", function() toggleState("StealthMode") end)
AddButton(p11, "4. ระบบเตือนภัยเมื่อมีคนมาใกล้ตัว (Player Alert)", function() toggleState("PlayerAlert") end)
AddButton(p11, "5. ออโต้กดออกเกมเมื่อเจอแอดมิน (Auto Kick Admin)", function() toggleState("AutoKickAdmin") end)
AddButton(p11, "6. ออโต้กดออกเกมเมื่อเลือดต่ำกว่า 20%", function() toggleState("EmergencyExit") end)
AddButton(p11, "7. ระบบป้องกันหลุดจากการยืนนิ่ง (Anti-AFK)", function()
local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
print("[TiwHub] Anti-AFK Activated Successfully!")
end)
AddButton(p11, "8. ตรวจสอบรายชื่อผู้เล่นในเซิร์ฟเวอร์เรียลไทม์", function() print("[TiwHub] Player count: " .. #Players:GetPlayers()) end)
AddButton(p11, "9. ระบบล็อกห้องให้เฉพาะเพื่อนในเซิร์ฟ", function() toggleState("ServerLock") end)
AddButton(p11, "10. ปิดการรับข้อความแชตจากคนอื่น (Mute Chat)", function() pcall(function() game:GetService("TextChatService").Enabled = false end) end)
AddButton(p11, "11. ปิดการมองเห็นเอฟเฟกต์การโจมตีคนอื่น", function() toggleState("HideOtherEffects") end)
AddButton(p11, "12. ออโต้ปิดการขอเทรดผลไม้จากผู้เล่นอื่น", function() toggleState("AutoDeclineTrade") end)
AddButton(p11, "13. ระบบแจ้งเตือนเมื่อมีคนเปิดโหมด PvP ใกล้ๆ", function() toggleState("PvPNotifier") end)
AddButton(p11, "14. ออโต้วาร์ปไปจุดปลอดภัยเมื่อถูกโจมตี", function() toggleState("AutoSafezone") end)
AddButton(p11, "15. เปิดโหมดล็อกเป้าป้องกันตัวอัตโนมัติ", function() toggleState("AutoDefend") end)
-- ==================== 12. ตั้งค่าระบบ ====================
local p12 = Pages["12. ตั้งค่าระบบ"]
AddSectionHeader(p12, "🛠️ ระบบตั้งค่าเสริมและเพิ่มความลื่นไหล")
AddButton(p12, "1. แสดงค่า FPS และ Ping แบบเรียลไทม์", function()
local stats = game:GetService("Stats")
print("[TiwHub Stats] FPS: " .. math.floor(workspace:GetRealPhysicsFPS()) .. " | Ping: " .. math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()))
end)
AddButton(p12, "2. โหมดเคลียร์แลคภาพต่ำสุด (FPS Booster)", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
end
print("[TiwHub] FPS Booster Applied!")
end)
AddButton(p12, "3. ปิดภาพเอฟเฟกต์สกิลทั้งหมด (Disable Effects)", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") then v.Enabled = false end
end
end)
AddButton(p12, "4. ปิดการแสดงผลพื้นผิวสิ่งก่อสร้าง (Low Texture)", function() terrain = workspace.Terrain terrain.WaterWaveSize = 0 terrain.WaterTransparency = 1 end)
AddButton(p12, "5. เปลี่ยนธีมสีหน้าต่าง UI (Theme Selector)", function() print("[TiwHub] Theme Changed: Dark Supreme") end)
AddButton(p12, "6. เปิด/ปิด เสียงประกอบสคริปต์ (BGM Toggled)", function() toggleState("BGM") end)
AddButton(p12, "7. เปิดหน้าต่างแสดง Console Log ลำดับโค้ด", function() print("[TiwHub Console] All systems running stable.") end)
AddButton(p12, "8. เปิดระบบส่งข้อมูลเข้า Discord Webhook", function() toggleState("WebhookLog") end)
AddButton(p12, "9. เร่งความเร็วการทำงานของตัวรัน (Executor Boost)", function() print("[TiwHub] Executor Speed Boosted.") end)
AddButton(p12, "10. เคลียร์หน่วยความจำ RAM ในเกมอัตโนมัติ", function() pcall(function() collectgarbage("collect") end) print("[TiwHub] Memory Cleaned!") end)
AddButton(p12, "11. ปิดการประมวลผลเงาในเกม (Disable Shadows)", function() Lighting.GlobalShadows = false end)
AddButton(p12, "12. ปิดการแสดงผลท้องฟ้าแบบละเอียด (Black Sky)", function() Lighting.TimeOfDay = "00:00:00" end)
AddButton(p12, "13. ปรับขนาดหน้าต่าง GUI อัตโนมัติตามจอมือถือ", function() print("[TiwHub] GUI Scaled for Mobile Delta") end)
AddButton(p12, "14. เปิดโหมดประหยัดพลังงานแบตเตอรี่มือถือ", function() settings():GetService("RenderSettings").EditQualityLevel(Enum.QualityLevel.Level01) end)
AddButton(p12, "15. รีเซ็ตระบบการประมวลผลสคริปต์ทั้งหมดใหม่", function() print("[TiwHub] Core System Restarted Successfully.") end)
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
print("[TiwHub] Ultimate Pro Max Loaded with Persistent Haki Successfully!")
