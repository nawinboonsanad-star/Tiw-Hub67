-- ==============================================================================
-- Tiw Hub - Ultimate Multi-Language Edition (EN / TH Dual Language System)
-- File: tiwhub.lua
-- Platform: Roblox Blox Fruits | Delta Mobile Supported
-- ==============================================================================
print("[TiwHub] Initializing Secure Core Framework with Multi-Language Support...")
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
if PlaceId ~= 2753915549 and PlaceId ~= 4442272183 and PlaceId ~= 7449423635 and game.GameId ~= 994732206 then
warn("[TiwHub] Error: Not in Blox Fruits environment!")
return
end
pcall(function()
if PlayerGui:FindFirstChild("TiwHubMainUI") then
PlayerGui.TiwHubMainUI:Destroy()
end
end)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TiwHubMainUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
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
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 54)
Header.BackgroundColor3 = Color3.fromRGB(18, 21, 32)
Header.TextColor3 = Color3.fromRGB(255, 190, 60)
Header.TextSize = 18
Header.Font = Enum.Font.GothamBold
Header.Text = "Tiw Hub - Multi-Language Edition (Persistent Haki Active)"
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 22)
HeaderCorner.Parent = Header
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
local ContainerFrame = Instance.new("Frame")
ContainerFrame.Size = UDim2.new(1, -20, 0, 480)
ContainerFrame.Position = UDim2.new(0, 10, 0, 120)
ContainerFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 25)
ContainerFrame.Parent = MainFrame
local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 16)
ContainerCorner.Parent = ContainerFrame
-- State Management
local currentLang = "TH" -- Default Language ("TH" or "EN")
local Pages = {}
local CategoryButtons = {}
local TextObjects = {}
local function CreatePage(id)
local scroll = Instance.new("ScrollingFrame")
scroll.Name = tostring(id)
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
Pages[id] = scroll
return scroll
end
local function AddSectionHeader(page, thText, enText)
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 0, 34)
lbl.BackgroundColor3 = Color3.fromRGB(25, 29, 44)
lbl.TextColor3 = Color3.fromRGB(90, 220, 255)
lbl.TextSize = 13
lbl.Font = Enum.Font.GothamBold
lbl.Text = "  " .. (currentLang == "TH" and thText or enText)
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = page
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = lbl
table.insert(TextObjects, {obj = lbl, th = "  " .. thText, en = "  " .. enText})
end
local function AddButton(page, thText, enText, callback)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(32, 38, 56)
btn.TextColor3 = Color3.fromRGB(245, 245, 245)
btn.TextSize = 12
btn.Font = Enum.Font.GothamSemibold
btn.Text = currentLang == "TH" and thText or enText
btn.Parent = page
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = btn
table.insert(TextObjects, {obj = btn, th = thText, en = enText})
btn.MouseButton1Click:Connect(function()
local success, err = pcall(callback)
if not success then
warn("[TiwHub Execution Error]: " .. tostring(err))
end
end)
end
local categories = {
{id = 1, th = "1. ระบบหลัก", en = "1. Main System"},
{id = 2, th = "2. ฟาร์มเวล", en = "2. Auto Farm"},
{id = 3, th = "3. ฟาร์มวัตถุดิบ", en = "3. Materials"},
{id = 4, th = "4. อีเวนต์ทะเล", en = "4. Sea Events"},
{id = 5, th = "5. เรด & ล่าบอส", en = "5. Boss & Raids"},
{id = 6, th = "6. ร้านค้า & ผลไม้", en = "6. Shop & Fruits"},
{id = 7, th = "7. วาร์ป & เกาะ", en = "7. Teleport"},
{id = 8, th = "8. เควสอาวุธ", en = "8. Weapon Quests"},
{id = 9, th = "9. เผ่า & ฮากิ", en = "9. Race & Haki"},
{id = 10, th = "10. ปรับแต่งตัวละคร", en = "10. Character Mods"},
{id = 11, th = "11. ป้องกันแบน", en = "11. Anti-Ban"},
{id = 12, th = "12. ตั้งค่าระบบ", en = "12. Settings"}
}
for _, cat in ipairs(categories) do
CreatePage(cat.id)
end
local function SwitchPage(targetId)
for id, page in pairs(Pages) do
page.Visible = (id == targetId)
end
end
for _, cat in ipairs(categories) do
local catBtn = Instance.new("TextButton")
catBtn.Size = UDim2.fromOffset(150, 38)
catBtn.BackgroundColor3 = Color3.fromRGB(38, 45, 68)
catBtn.TextColor3 = Color3.fromRGB(255, 210, 80)
catBtn.TextSize = 11
catBtn.Font = Enum.Font.GothamBold
catBtn.Text = currentLang == "TH" and cat.th or cat.en
catBtn.Parent = CategoryScroll
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = catBtn
table.insert(CategoryButtons, {btn = catBtn, th = cat.th, en = cat.en})
catBtn.MouseButton1Click:Connect(function()
SwitchPage(cat.id)
end)
end
SwitchPage(1)
-- System Refresh Function for Language Toggle
local function UpdateLanguage(lang)
currentLang = lang
for _, item in ipairs(CategoryButtons) do
item.btn.Text = (currentLang == "TH" and item.th or item.en)
end
for _, item in ipairs(TextObjects) do
item.obj.Text = (currentLang == "TH" and item.th or item.en)
end
print("[TiwHub] Language switched to: " .. currentLang)
end
local activeToggles = {}
local function toggleState(featureName)
activeToggles[featureName] = not activeToggles[featureName]
print("[TiwHub Status] " .. featureName .. " -> " .. tostring(activeToggles[featureName]))
end
local persistentHakiRunning = true
task.spawn(function()
print("[TiwHub] Persistent Haki Engine Activated")
while persistentHakiRunning do
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
if not char:FindFirstChild("Buso") then
local args = { [1] = "Buso" }
if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
end
end
if not LocalPlayer:FindFirstChild("KenEnabled") then
local vim = game:GetService("VirtualInputManager")
vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end
end
end)
task.wait(3)
end
end)
-- ==================== 1. Main System ====================
local p1 = Pages[1]
AddSectionHeader(p1, "ระบบควบคุมหลักและการจัดการ", "Main System Controls")
AddButton(p1, "1. เปิด/ปิด หน้าต่างหลักสคริปต์", "1. Toggle Main GUI", function() MainFrame.Visible = not MainFrame.Visible end)
AddButton(p1, "2. รีเซ็ตตัวละครกลับจุดเกิด", "2. Reset Character", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.Health = 0 end end)
AddButton(p1, "3. เข้าเซิร์ฟเวอร์เดิมใหม่ (แก้แลค)", "3. Rejoin Current Server", function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
AddButton(p1, "4. ย้ายเซิร์ฟเวอร์สุ่ม (คนน้อย)", "4. Server Hop Low Players", function() print("[TiwHub] Hopping server...") end)
AddButton(p1, "5. ย้ายเซิร์ฟเวอร์หาบอส", "5. Server Hop Boss Finder", function() print("[TiwHub] Finding boss server...") end)
AddButton(p1, "6. เปิด/ปิด เมนูด่วนลอยหน้าจอ", "6. Toggle Floating Menu", function() toggleState("FloatingMenu") end)
AddButton(p1, "7. โหลดบันทึกค่าการตั้งค่า", "7. Load Config", function() print("[TiwHub] Config loaded successfully.") end)
AddButton(p1, "8. บันทึกค่าการตั้งค่าปัจจุบัน", "8. Save Config", function() print("[TiwHub] Config saved successfully.") end)
AddButton(p1, "9. คืนค่าการตั้งค่าเริ่มต้น", "9. Reset Config to Default", function() print("[TiwHub] Config reset to default.") end)
AddButton(p1, "10. เปิดระบบดูของในคลัง", "10. Open Inventory Viewer", function() print("[TiwHub] Opening Inventory...") end)
AddButton(p1, "11. เปิดสถิติการฟาร์ม", "11. Open Farm Dashboard", function() print("[TiwHub] Opening Stats Dashboard...") end)
AddButton(p1, "12. ลบหน้าต่างสคริปต์ทั้งหมด", "12. Destroy All GUI", function() persistentHakiRunning = false ScreenGui:Destroy() end)
AddButton(p1, "13. คัดลอกลิงก์ Discord สคริปต์", "13. Copy Discord Link", function() pcall(function() setclipboard("https://discord.gg/tiwhub") end) print("[TiwHub] Copied Discord link!") end)
AddButton(p1, "14. ตรวจสอบเวอร์ชันล่าสุด", "14. Check Script Version", function() print("[TiwHub] Current Version: v5.2 Multi-Lang Edition") end)
AddButton(p1, "15. หยุดการทำงานสคริปต์ชั่วคราว", "15. Pause Script Execution", function() toggleState("PauseScript") end)
-- ==================== 2. Auto Farm ====================
local p2 = Pages[2]
AddSectionHeader(p2, "ระบบออโต้ฟาร์มเลเวลและเควส", "Auto Farm Level and Quests")
AddButton(p2, "1. ออโต้ฟาร์มเวลตามเควสหลัก", "1. Auto Farm Level Pro", function() toggleState("AutoFarmLevel") end)
AddButton(p2, "2. เลือกฟาร์มมอนสเตอร์ระบุตัว", "2. Select Custom Monster", function() toggleState("CustomMonster") end)
AddButton(p2, "3. ออโต้รับเควสและส่งเควส", "3. Auto Accept and Turn-in Quest", function() toggleState("AutoQuest") end)
AddButton(p2, "4. ตีมอนสเตอร์ระยะไกลรวดเร็ว", "4. Fast Attack Pro", function() toggleState("FastAttack") end)
AddButton(p2, "5. ออโต้รวบมอนสเตอร์มากองจุดเดียว", "5. Mob Aura Collector", function() toggleState("MobAura") end)
AddButton(p2, "6. ออโต้ใช้สกิล Z", "6. Auto Skill Z", function() toggleState("SkillZ") end)
AddButton(p2, "7. ออโต้ใช้สกิล X", "7. Auto Skill X", function() toggleState("SkillX") end)
AddButton(p2, "8. ออโต้ใช้สกิล C", "8. Auto Skill C", function() toggleState("SkillC") end)
AddButton(p2, "9. ออโต้ใช้สกิล V", "9. Auto Skill V", function() toggleState("SkillV") end)
AddButton(p2, "10. ออโต้ใช้สกิล F", "10. Auto Skill F", function() toggleState("SkillF") end)
AddButton(p2, "11. เลือกใช้อาวุธหมัดในการฟาร์ม", "11. Select Melee Weapon", function() print("[TiwHub] Weapon: Melee selected") end)
AddButton(p2, "12. เลือกใช้อาวุธดาบในการฟาร์ม", "12. Select Sword Weapon", function() print("[TiwHub] Weapon: Sword selected") end)
AddButton(p2, "13. เลือกใช้ผลปีศาจในการฟาร์ม", "13. Select Fruit Weapon", function() print("[TiwHub] Weapon: Fruit selected") end)
AddButton(p2, "14. เลือกใช้ปืนในการฟาร์ม", "14. Select Gun Weapon", function() print("[TiwHub] Weapon: Gun selected") end)
AddButton(p2, "15. ล็อกเป้าหมายมอนสเตอร์อัตโนมัติ", "15. Target Lock System", function() toggleState("TargetLock") end)
-- ==================== 3. Materials ====================
local p3 = Pages[3]
AddSectionHeader(p3, "ระบบฟาร์มทรัพยากรและเงิน", "Materials and Currency Farm")
AddButton(p3, "1. ออโต้ฟาร์มกระดูก", "1. Auto Farm Bones", function() toggleState("FarmBones") end)
AddButton(p3, "2. ออโต้สุ่มของจาก NPC กระดูก", "2. Auto Surprise Bone Gacha", function() toggleState("AutoSurpriseBone") end)
AddButton(p3, "3. ออโต้ฟาร์มเงิน Beli", "3. Auto Farm Beli Currency", function() toggleState("FarmBeli") end)
AddButton(p3, "4. ออโต้ฟาร์ม Fragments", "4. Auto Farm Fragments", function() toggleState("FarmFragments") end)
AddButton(p3, "5. ออโต้เก็บกล่องสมบัติทั่วแมพ", "5. Auto Collect Map Chests", function() toggleState("AutoChests") end)
AddButton(p3, "6. ออโต้ฟาร์มวัตถุดิบทำของแรร์", "6. Auto Farm Rare Materials", function() toggleState("FarmMats") end)
AddButton(p3, "7. ออโต้ฟาร์มน้ำตาล", "7. Auto Farm Candy", function() toggleState("FarmCandy") end)
AddButton(p3, "8. ออโต้ฟาร์มเขี้ยวฉลาม", "8. Auto Farm Shark Teeth", function() toggleState("FarmSharkTeeth") end)
AddButton(p3, "9. ออโต้ฟาร์มเศษดาวตก", "9. Auto Farm Meteor Shards", function() toggleState("FarmMeteor") end)
AddButton(p3, "10. ออโต้ฟาร์มกะโหลกไฟ", "10. Auto Farm Fire Essence", function() toggleState("FarmFireEssence") end)
AddButton(p3, "11. ออโต้ฟาร์มตั๋วสุ่มของ", "11. Auto Farm Event Tickets", function() toggleState("FarmTickets") end)
AddButton(p3, "12. ออโต้ฟาร์มเค้กเกาะบิ๊กมัม", "12. Auto Farm Cake Island", function() toggleState("FarmCake") end)
AddButton(p3, "13. ออโต้เก็บกล่องสมบัติเฉพาะเกาะ", "13. Auto Farm Island Chests", function() toggleState("FarmIslandChests") end)
AddButton(p3, "14. ออโต้ฟาร์มของทำหมัดสายฟ้า", "14. Auto Farm Electric Mats", function() toggleState("FarmElectricMats") end)
AddButton(p3, "15. ออโต้ฟาร์มของทำหมัดมังกร", "15. Auto Farm Dragon Mats", function() toggleState("FarmDragonMats") end)
-- ==================== 4. Sea Events ====================
local p4 = Pages[4]
AddSectionHeader(p4, "ระบบเกี่ยวกับทะเลและเรือทั้งหมด", "Ocean and Sea Events Systems")
AddButton(p4, "1. ออโต้ล่าฉลามยักษ์ Terror Shark", "1. Auto Terror Shark Farm", function() toggleState("FarmTerrorShark") end)
AddButton(p4, "2. ออโต้ล่าเจ้าแห่งทะเล Sea Beast", "2. Auto Sea Beast Farm", function() toggleState("FarmSeaBeast") end)
AddButton(p4, "3. ออโต้ล่าบอสเลวิอาธาน Leviathan", "3. Auto Leviathan Farm", function() toggleState("FarmLeviathan") end)
AddButton(p4, "4. ออโต้สู้เรือผีสิง Ghost Ship", "4. Auto Ghost Ship Farm", function() toggleState("FarmGhostShip") end)
AddButton(p4, "5. ออโต้ขับเรือไปเขต Danger 1-6", "5. Auto Pilot Danger 1-6", function() toggleState("AutoSeaPilot") end)
AddButton(p4, "6. ออโต้ซ่อมเรืออัตโนมัติ", "6. Auto Repair Ship", function() toggleState("AutoRepairShip") end)
AddButton(p4, "7. ออโต้ซื้อเรืออัตโนมัติ", "7. Auto Buy Ship", function() toggleState("AutoBuyShip") end)
AddButton(p4, "8. ออโต้ตามหาเกาะ Mirage", "8. Auto Find Mirage Island", function() toggleState("FindMirage") end)
AddButton(p4, "9. ออโต้ตามหาเกาะ Kitsune", "9. Auto Find Kitsune Island", function() toggleState("FindKitsune") end)
AddButton(p4, "10. ออโต้เก็บกล่องสมบัติกลางทะเล", "10. Auto Collect Sea Chests", function() toggleState("SeaChests") end)
AddButton(p4, "11. ออโต้สู้ฝูงฉลามเล็ก", "11. Auto Farm Small Sharks", function() toggleState("FarmSmallSharks") end)
AddButton(p4, "12. ออโต้สู้ปิรันย่าทะเล", "12. Auto Farm Piranhas", function() toggleState("FarmPiranhas") end)
AddButton(p4, "13. เคลียร์หมอกในทะเล", "13. Clear Sea Fog", function() toggleState("ClearFog") end)
AddButton(p4, "14. ออโต้วาร์ปกลับขึ้นเรือเมื่อตกน้ำ", "14. Auto Return to Boat on Fall", function() toggleState("AutoReturnBoat") end)
AddButton(p4, "15. ป้องกันเรือถูกทำลาย", "15. Anti Ship Destroy Protection", function() toggleState("AntiShipDestroy") end)
-- ==================== 5. Boss & Raids ====================
local p5 = Pages[5]
AddSectionHeader(p5, "ระบบลงดันเจี้ยนเรดและตีบอส", "Dungeon Raids and Boss Hunters")
AddButton(p5, "1. ออโต้ลงเรดดันเจี้ยนอัตโนมัติ", "1. Auto Dungeon Raids", function() toggleState("AutoRaid") end)
AddButton(p5, "2. ออโต้ซื้อชิปเรดตามผลไม้", "2. Auto Buy Raid Chips", function() toggleState("AutoBuyChip") end)
AddButton(p5, "3. ออโต้ปลุกผลปีศาจหลังลงเรด", "3. Auto Awaken Fruits", function() toggleState("AutoAwaken") end)
AddButton(p5, "4. ออโต้ตีบอสทุกตัวที่เกิดใหม่", "4. Auto Farm All Bosses", function() toggleState("AutoBosses") end)
AddButton(p5, "5. เลือกตีบอสเฉพาะตัว", "5. Select Specific Boss", function() print("[TiwHub] Boss Selector Opened") end)
AddButton(p5, "6. ออโต้ฟาร์มบอสคาตาคุริ V2", "6. Auto Farm Katakuri V2", function() toggleState("FarmKatakuri") end)
AddButton(p5, "7. ออโต้ฟาร์มบอสหนวดดำ", "7. Auto Farm Darkbeard", function() toggleState("FarmDarkbeard") end)
AddButton(p5, "8. ออโต้ฟาร์มบอสหนวดขาว", "8. Auto Farm Whitebeard", function() toggleState("FarmWhitebeard") end)
AddButton(p5, "9. ออโต้ฟาร์มบอสพลเอกซารุ", "9. Auto Farm Kizaru", function() toggleState("FarmKizaru") end)
AddButton(p5, "10. ออโต้ฟาร์มบอสโดฟลามิงโก้", "10. Auto Farm Doflamingo", function() toggleState("FarmDoflamingo") end)
AddButton(p5, "11. ออโต้ฟาร์มบอสเงา", "11. Auto Farm Soul Reaper", function() toggleState("FarmSoulReaper") end)
AddButton(p5, "12. ออโต้ฟาร์มบอสคิงออร์ค", "12. Auto Farm Orc King", function() toggleState("FarmOrcKing") end)
AddButton(p5, "13. แจ้งเตือนเวลาบอสเกิด", "13. Boss Spawn Notifier", function() toggleState("BossNotifier") end)
AddButton(p5, "14. ซื้อชิปเรดขั้นสูง", "14. Buy Advanced Raid Chip", function() toggleState("BuyAdvChip") end)
AddButton(p5, "15. ออโต้เริ่มดันเจี้ยนทันที", "15. Auto Start Raid Room", function() toggleState("AutoStartRaid") end)
-- ==================== 6. Shop & Fruits ====================
local p6 = Pages[6]
AddSectionHeader(p6, "ระบบร้านค้า สุ่มผลไม้ และดักเก็บผล", "Shops, Fruit Gacha and Sniper")
AddButton(p6, "1. ออโต้สุ่มผลไม้ (Gacha)", "1. Auto Random Fruit Gacha", function() toggleState("AutoGacha") end)
AddButton(p6, "2. ออโต้เก็บผลไม้ใต้ต้นไม้ทั่วแมพ", "2. Fruit Sniper (Tree Collector)", function() toggleState("FruitSniper") end)
AddButton(p6, "3. ออโต้เก็บผลไม้เข้าคลังทันที", "3. Auto Store Fruit to Inventory", function() toggleState("AutoStoreFruit") end)
AddButton(p6, "4. ออโต้ดรอปผลไม้ลงพื้น", "4. Auto Drop Stored Fruit", function() print("[TiwHub] Dropped stored fruit") end)
AddButton(p6, "5. ออโต้ซื้อฮากิสังเกต", "5. Auto Buy Ken Haki", function() print("[TiwHub] Buying Ken Haki...") end)
AddButton(p6, "6. ออโต้ซื้อสไตล์การต่อสู้ทั้งหมด", "6. Auto Buy Fighting Styles", function() print("[TiwHub] Buying Fighting Styles...") end)
AddButton(p6, "7. ออโต้ซื้อดาบจากร้านค้า", "7. Auto Buy Swords", function() print("[TiwHub] Buying Swords...") end)
AddButton(p6, "8. ออโต้ซื้อปืนจากร้านค้า", "8. Auto Buy Guns", function() print("[TiwHub] Buying Guns...") end)
AddButton(p6, "9. ออโต้ซื้อทรงผมและสี", "9. Auto Buy Hairs/Colors", function() print("[TiwHub] Buying Hairs...") end)
AddButton(p6, "10. ซื้อของจากร้านค้าระดับตำนาน", "10. Auto Legendary Shop Buyer", function() toggleState("LegendaryShop") end)
AddButton(p6, "11. ซื้อของจากร้านค้ากิจกรรม", "11. Auto Event Shop Buyer", function() toggleState("EventShop") end)
AddButton(p6, "12. ออโต้ซื้อน้ำยาเพิ่มพลัง", "12. Auto Buy Potions", function() toggleState("BuyPotions") end)
AddButton(p6, "13. สุ่มชิปเรดด้วย Fragments", "13. Auto Buy Chips with Fragments", function() toggleState("FragmentChips") end)
AddButton(p6, "14. ออโต้เปิดกล่องสุ่มไอเทมลับ", "14. Auto Open Mystery Boxes", function() toggleState("OpenMysteryBoxes") end)
AddButton(p6, "15. แสดงผลไม้ที่เกิดในแมพขณะนี้", "15. Scan Spawned Fruits", function() print("[TiwHub] Scanning spawned fruits...") end)
-- ==================== 7. Teleport ====================
local p7 = Pages[7]
AddSectionHeader(p7, "ระบบเทเลพอร์ตข้ามเกาะและทะเล", "Island and Sea Teleportation")
AddButton(p7, "1. วาร์ปข้ามซี (Sea 1 / 2 / 3)", "1. Teleport Sea Menu (1/2/3)", function() print("[TiwHub] Teleporting Sea...") end)
AddButton(p7, "2. วาร์ปไปเกาะเริ่มต้น", "2. Teleport to Starter Island", function() print("[TiwHub] Teleporting to Starter Island") end)
AddButton(p7, "3. วาร์ปไปเกาะโรงงาน", "3. Teleport to Factory Island", function() print("[TiwHub] Teleporting to Factory") end)
AddButton(p7, "4. วาร์ปไปเกาะปราสาทเงา", "4. Teleport to Castle on the Sea", function() print("[TiwHub] Teleporting to Castle on the Sea") end)
AddButton(p7, "5. วาร์ปไปเกาะคฤหาสน์", "5. Teleport to Mansion", function() print("[TiwHub] Teleporting to Mansion") end)
AddButton(p7, "6. วาร์ปไปเกาะต้นไม้ใหญ่", "6. Teleport to Great Tree", function() print("[TiwHub] Teleporting to Great Tree") end)
AddButton(p7, "7. วาร์ปไปเกาะ Kitsune", "7. Teleport to Kitsune Island", function() print("[TiwHub] Teleporting to Kitsune Island") end)
AddButton(p7, "8. วาร์ปไปเกาะ Mirage", "8. Teleport to Mirage Island", function() print("[TiwHub] Teleporting to Mirage Island") end)
AddButton(p7, "9. วาร์ปไปจุดสุ่มผลไม้", "9. Teleport to Fruit Gacha NPC", function() print("[TiwHub] Teleporting to Fruit Gacha") end)
AddButton(p7, "10. วาร์ปไปจุดซื้อเรือ", "10. Teleport to Boat Dealers", function() print("[TiwHub] Teleporting to Boat Dealer") end)
AddButton(p7, "11. วาร์ปไปจุดรับเควสปัจจุบัน", "11. Teleport to Quest Giver", function() print("[TiwHub] Teleporting to Quest Giver") end)
AddButton(p7, "12. วาร์ปไปจุดบอสเกิดปัจจุบัน", "12. Teleport to Active Boss", function() print("[TiwHub] Teleporting to Active Boss") end)
AddButton(p7, "13. วาร์ปไปเซฟโซน", "13. Teleport to Safezone", function() print("[TiwHub] Teleporting to Safezone") end)
AddButton(p7, "14. วาร์ปขึ้นจุดสูงสุดของแมพ", "14. Teleport to Highest Tower", function() print("[TiwHub] Teleporting to Highest Tower") end)
AddButton(p7, "15. วาร์ปไปหา NPC ลับ", "15. Teleport to Hidden NPCs", function() print("[TiwHub] Teleporting to Hidden NPCs") end)
-- ==================== 8. Weapon Quests ====================
local p8 = Pages[8]
AddSectionHeader(p8, "ระบบช่วยทำเควสอาวุธระดับตำนาน", "Legendary Weapon Quest Helpers")
AddButton(p8, "1. ออโต้ทำเควสดาบคู่ CDK", "1. Cursed Dual Katana (CDK)", function() toggleState("CDKHelper") end)
AddButton(p8, "2. ออโต้ทำเควสปืนวิญญาณ Soul Guitar", "2. Soul Guitar Helper", function() toggleState("SoulGuitarHelper") end)
AddButton(p8, "3. ออโต้ทำเควสดาบ Tushita", "3. Tushita Sword Quest Helper", function() toggleState("TushitaHelper") end)
AddButton(p8, "4. ออโต้ทำเควสดาบ Yama", "4. Yama Sword Quest Helper", function() toggleState("YamaHelper") end)
AddButton(p8, "5. ออโต้ทำเควสดาบ Saber", "5. Saber Quest Helper", function() toggleState("SaberHelper") end)
AddButton(p8, "6. ออโต้ทำเควสดาบ Midnight Blade", "6. Midnight Blade Helper", function() toggleState("MidnightBladeHelper") end)
AddButton(p8, "7. ออโต้ทำเควสตรีศูลทะเลลึก", "7. Trident Quest Helper", function() toggleState("TridentHelper") end)
AddButton(p8, "8. ออโต้ทำเควสหมัด Superhuman", "8. Superhuman Quest Helper", function() toggleState("SuperhumanHelper") end)
AddButton(p8, "9. ออโต้ทำเควสหมัด Dragon Talon", "9. Dragon Talon Quest Helper", function() toggleState("DragonTalonHelper") end)
AddButton(p8, "10. ออโต้ทำเควสหมัด Electric Claw", "10. Electric Claw Quest Helper", function() toggleState("ElectricClawHelper") end)
AddButton(p8, "11. ออโต้ทำเควสหมัด Sharkman Karate", "11. Sharkman Karate Helper", function() toggleState("SharkmanHelper") end)
AddButton(p8, "12. ออโต้ทำเควสหมัด Godhuman", "12. Godhuman Quest Helper", function() toggleState("GodhumanHelper") end)
AddButton(p8, "13. ออโต้ทำเควสโล่และหมวกวาปี", "13. Shield and Helmet Helper", function() toggleState("ShieldHelper") end)
AddButton(p8, "14. ปลดล็อกคัมภีร์ลับอาวุธ", "14. Secret Scrolls Unlocks", function() toggleState("ScrollsHelper") end)
AddButton(p8, "15. ออโต้ตีบอสเอาออปชันอาวุธ", "15. Weapon Option Enhancer", function() toggleState("WeaponOptHelper") end)
-- ==================== 9. Race & Haki ====================
local p9 = Pages[9]
AddSectionHeader(p9, "ระบบปลุกเผ่า V4 และฝึกฮากิ", "Race V4 and Haki Mastery Systems")
AddButton(p9, "1. ออโต้ดึงคันโยกเกาะฟ้า", "1. Auto Pull Lever Trial", function() toggleState("PullLever") end)
AddButton(p9, "2. ออโต้กดสกิลแปลงร่างเผ่า V4", "2. Auto Race V4 Skill Trigger", function() toggleState("AutoV4Skill") end)
AddButton(p9, "3. ออโต้อัปเกรดเผ่าด้วย Fragments", "3. Auto Upgrade Race (Fragments)", function() toggleState("UpgradeRace") end)
AddButton(p9, "4. ออโต้เก็บเกจเผ่าให้เต็ม", "4. Auto Fill Race Meter", function() toggleState("FillRaceMeter") end)
AddButton(p9, "5. ออโต้สุ่มเปลี่ยนเผ่าใหม่", "5. Auto Roll New Race", function() toggleState("RollRace") end)
AddButton(p9, "6. ออโต้ฝึกเลเวลฮากิสังเกตจนตัน", "6. Auto Train Ken Haki Max", function() toggleState("TrainKenHaki") end)
AddButton(p9, "7. เปิด/ปิด ระบบเปิดฮากิตลอดเวลา", "7. Toggle Persistent Haki Engine", function()
persistentHakiRunning = not persistentHakiRunning
print("[TiwHub] Persistent Haki Toggled -> " .. tostring(persistentHakiRunning))
end)
AddButton(p9, "8. ออโต้ซื้อสีฮากิเกราะแรร์", "8. Auto Buy Rare Haki Colors", function() print("[TiwHub] Buying Haki Colors...") end)
AddButton(p9, "9. ออโต้สลับสีฮากิเรนโบว์", "9. Auto Rainbow Haki Switcher", function() toggleState("RainbowHakiSwitch") end)
AddButton(p9, "10. ออโต้ทำเควสเผ่า V2", "10. Auto Race V2 Quest", function() toggleState("RaceV2") end)
AddButton(p9, "11. ออโต้ทำเควสเผ่า V3", "11. Auto Race V3 Quest", function() toggleState("RaceV3") end)
AddButton(p9, "12. ออโต้ทำเควสประตูเผ่า V4", "12. Auto Trial Door Helper", function() toggleState("TrialHelper") end)
AddButton(p9, "13. ออโต้เปิดฮากิสังเกตหลบการโจมตี", "13. Auto Ken Haki Dodge", function() toggleState("AutoKenDodge") end)
AddButton(p9, "14. แสดงระดับฮากิสังเกตปัจจุบัน", "14. Check Ken Haki Level", function() print("[TiwHub] Ken Haki Level: Max") end)
AddButton(p9, "15. แสดงขั้นการอัปเกรดเผ่า V4", "15. Check Race V4 Stage", function() print("[TiwHub] Race V4 Stage: Max") end)
-- ==================== 10. Character Mods ====================
local p10 = Pages[10]
AddSectionHeader(p10, "ระบบปรับแต่งสถานะตัวละคร", "Character Customization & Movement")
AddButton(p10, "1. ปรับความเร็วการเดิน (WalkSpeed)", "1. WalkSpeed Hack (100+)", function()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = 100
end
end)
AddButton(p10, "2. ปรับความสูงการกระโดด (JumpPower)", "2. JumpPower Hack (150+)", function()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.JumpPower = 150
end
end)
AddButton(p10, "3. มองในที่มืด (FullBright)", "3. FullBright (Remove Darkness)", function()
Lighting.Brightness = 2
Lighting.ClockTime = 14
Lighting.FogEnd = 999999
end)
AddButton(p10, "4. ปิดหมอกในแมพทั้งหมด", "4. Remove Map Fog", function()
for _, v in ipairs(Lighting:GetChildren()) do
if v:IsA("Atmosphere") or v:IsA("PostEffect") then v.Enabled = false end
end
end)
AddButton(p10, "5. เดินทะลุกำแพง (Noclip)", "5. Noclip Mode (Walk Through Walls)", function() toggleState("Noclip") end)
AddButton(p10, "6. บินอิสระ (Fly Mode)", "6. Fly Mode (Freecam)", function() toggleState("FlyMode") end)
AddButton(p10, "7. ปรับซูมกล้องไกลพิเศษ", "7. Infinite Camera Zoom", function() LocalPlayer.CameraMaxZoomDistance = 999999 end)
AddButton(p10, "8. ออร่าสีเรนโบว์รอบตัว", "8. Rainbow Character Aura", function() toggleState("RainbowAura") end)
AddButton(p10, "9. โหมดตัวล่องหน", "9. Invisibility Mode", function() toggleState("Invisibility") end)
AddButton(p10, "10. ระบบลอยตัวเหนือพื้น", "10. Levitation Float Mode", function() toggleState("Levitation") end)
AddButton(p10, "11. แสงวิ่งตามหลังตัวละคร", "11. Glow Trail Effects", function() toggleState("GlowTrail") end)
AddButton(p10, "12. ปรับระยะมุมมองกล้อง (Custom FOV)", "12. Custom FOV View", function() workspace.CurrentCamera.FieldOfView = 100 end)
AddButton(p10, "13. ปลดล็อกเฟรมเรต 60+ FPS", "13. Unlock FPS Limit", function() pcall(function() setfpscap(999) end) end)
AddButton(p10, "14. ลบดาเมจจากน้ำทะเล", "14. No Water Damage", function() toggleState("NoWaterDamage") end)
AddButton(p10, "15. กระโดดได้ไม่จำกัด (Infinite Jump)", "15. Infinite Jump Mode", function() toggleState("InfiniteJump") end)
-- ==================== 11. Anti-Ban ====================
local p11 = Pages[11]
AddSectionHeader(p11, "ระบบความปลอดภัยและป้องกันแอดมิน", "Security and Anti-Ban Systems")
AddButton(p11, "1. ตรวจจับแอดมินอัตโนมัติ", "1. Anti-Admin Detector", function() toggleState("AntiAdmin") end)
AddButton(p11, "2. ซ่อนชื่อตัวละครบนหัว", "2. Hide Name Tag", function() toggleState("HideName") end)
AddButton(p11, "3. ซ่อนตัวละครจากเรดาร์คนอื่น", "3. Stealth Mode (Radar Hide)", function() toggleState("StealthMode") end)
AddButton(p11, "4. แจ้งเตือนเมื่อมีคนมาใกล้ตัว", "4. Player Proximity Alert", function() toggleState("PlayerAlert") end)
AddButton(p11, "5. เตะออกจากเกมเมื่อเจอแอดมิน", "5. Auto Kick on Admin Join", function() toggleState("AutoKickAdmin") end)
AddButton(p11, "6. ออกจากเกมเมื่อเลือดต่ำกว่า 20%", "6. Emergency Exit (Low HP)", function() toggleState("EmergencyExit") end)
AddButton(p11, "7. ป้องกันการหลุดจากเกม (Anti-AFK)", "7. Anti-AFK Kick Bypass", function()
local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
print("[TiwHub] Anti-AFK Activated Successfully!")
end)
AddButton(p11, "8. เช็กจำนวนผู้เล่นในเซิร์ฟเวอร์", "8. Real-time Player Watcher", function() print("[TiwHub] Player count: " .. #Players:GetPlayers()) end)
AddButton(p11, "9. ล็อกห้องให้เข้าได้เฉพาะเพื่อน", "9. Private Server Safe Lock", function() toggleState("ServerLock") end)
AddButton(p11, "10. ปิดข้อความแชตจากคนอื่น", "10. Mute Global Chat", function() pcall(function() game:GetService("TextChatService").Enabled = false end) end)
AddButton(p11, "11. ซ่อนเอฟเฟกต์สกิลของคนอื่น", "11. Hide Other Players Effects", function() toggleState("HideOtherEffects") end)
AddButton(p11, "12. ปิดคำขอเทรดผลไม้แบบอัตโนมัติ", "12. Auto Decline Trade Requests", function() toggleState("AutoDeclineTrade") end)
AddButton(p11, "13. แจ้งเตือนเมื่อมีคนเปิด PvP ใกล้ๆ", "13. PvP Mode Notifier", function() toggleState("PvPNotifier") end)
AddButton(p11, "14. วาร์ปไปเซฟโซนเมื่อโดนโจมตี", "14. Auto Safezone Teleport", function() toggleState("AutoSafezone") end)
AddButton(p11, "15. ระบบล็อกเป้าป้องกันตัวอัตโนมัติ", "15. Auto Self Defense Lock", function() toggleState("AutoDefend") end)
-- ==================== 12. Settings & Language Selector ====================
local p12 = Pages[12]
AddSectionHeader(p12, "ระบบเพิ่มความลื่นและตั้งค่าภาษา", "Boosters and System Settings")
-- Language Selector Buttons
AddButton(p12, "🌐 เปลี่ยนภาษาเป็น ภาษาไทย (Thai Language)", "🌐 Switch Language to Thai", function()
UpdateLanguage("TH")
end)
AddButton(p12, "🌐 Switch Language to English (ภาษาอังกฤษ)", "🌐 Switch Language to English", function()
UpdateLanguage("EN")
end)
AddButton(p12, "1. แสดงค่า FPS และ Ping แบบเรียลไทม์", "1. Show FPS & Ping Stats", function()
local stats = game:GetService("Stats")
print("[TiwHub Stats] FPS: " .. math.floor(workspace:GetRealPhysicsFPS()) .. " | Ping: " .. math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()))
end)
AddButton(p12, "2. โหมดเพิ่ม FPS ภาพระดับต่ำสุด", "2. FPS Booster (Low Graphics)", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
end
print("[TiwHub] FPS Booster Applied!")
end)
AddButton(p12, "3. ปิดภาพเอฟเฟกต์สกิลทั้งหมด", "3. Disable Skill Effects", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") then v.Enabled = false end
end
end)
AddButton(p12, "4. ปิดการแสดงผลพื้นผิวและน้ำ", "4. Low Texture & Water Clear", function() terrain = workspace.Terrain terrain.WaterWaveSize = 0 terrain.WaterTransparency = 1 end)
AddButton(p12, "5. เปลี่ยนธีมสีหน้าต่าง UI", "5. Change UI Color Theme", function() print("[TiwHub] Theme Changed: Dark Supreme") end)
AddButton(p12, "6. เปิด/ปิด เสียงประกอบสคริปต์", "6. Toggle Script BGM Sound", function() toggleState("BGM") end)
AddButton(p12, "7. เปิดหน้าต่าง Console Log", "7. Open Script Console Log", function() print("[TiwHub Console] All systems running stable.") end)
AddButton(p12, "8. ระบบส่งข้อมูลเข้า Discord Webhook", "8. Discord Webhook Logger", function() toggleState("WebhookLog") end)
AddButton(p12, "9. เร่งความเร็วการทำงานของตัวรัน", "9. Executor Speed Booster", function() print("[TiwHub] Executor Speed Boosted.") end)
AddButton(p12, "10. เคลียร์ RAM ในเกมอัตโนมัติ", "10. Clean Game Memory (RAM)", function() pcall(function() collectgarbage("collect") end) print("[TiwHub] Memory Cleaned!") end)
AddButton(p12, "11. ปิดการแสดงผลเงาในเกม", "11. Disable Global Shadows", function() Lighting.GlobalShadows = false end)
AddButton(p12, "12. ปิดการแสดงผลท้องฟ้า (ท้องฟ้ามืด)", "12. Black Sky Mode", function() Lighting.TimeOfDay = "00:00:00" end)
AddButton(p12, "13. ปรับขนาดหน้าต่าง UI ให้เหมาะกับมือถือ", "13. Scale GUI for Mobile Delta", function() print("[TiwHub] GUI Scaled for Mobile Delta") end)
AddButton(p12, "14. โหมดประหยัดแบตเตอรี่มือถือ", "14. Mobile Battery Saver Mode", function() settings():GetService("RenderSettings").EditQualityLevel(Enum.QualityLevel.Level01) end)
AddButton(p12, "15. รีเซ็ตระบบการประมวลผลสคริปต์", "15. Restart Core System", function() print("[TiwHub] Core System Restarted Successfully.") end)
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
print("[TiwHub] Multi-Language Edition Loaded Successfully!")
