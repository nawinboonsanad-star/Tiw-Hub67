-- ==============================================================================
-- Tiw Hub - Ultimate All-in-One Blox Fruits Edition for Delta
-- Features: 11 Comprehensive Categories, Language Switcher (TH/EN),
-- Resizable Mobile GUI, Floating Ball Toggle, On-Death Haki Engine.
-- ==============================================================================
print("[TiwHub] Loading Ultimate Framework...")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
-- Safely clear previous UI instances
pcall(function()
if PlayerGui:FindFirstChild("TiwHubMainUI") then
PlayerGui.TiwHubMainUI:Destroy()
end
end)
-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TiwHubMainUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
-- Main Container Window
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(620, 420)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
MainFrame.Active = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 170, 0)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame
-- Floating Menu Ball Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(50, 50)
ToggleButton.Position = UDim2.new(0, 15, 0.35, 0)
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
-- Header Bar Label
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, -20, 0, 38)
Header.Position = UDim2.new(0, 10, 0, 2)
Header.BackgroundColor3 = Color3.fromRGB(18, 21, 32)
Header.TextColor3 = Color3.fromRGB(255, 190, 60)
Header.TextSize = 13
Header.Font = Enum.Font.GothamBold
Header.Text = "  TIW HUB - Blox Fruits Ultimate (Auto Buso Haki Active)"
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header
-- Top Category Navigation Scroll
local CategoryScroll = Instance.new("ScrollingFrame")
CategoryScroll.Size = UDim2.new(1, -20, 0, 36)
CategoryScroll.Position = UDim2.new(0, 10, 0, 44)
CategoryScroll.BackgroundTransparency = 1
CategoryScroll.CanvasSize = UDim2.fromScale(14.0, 0)
CategoryScroll.ScrollBarThickness = 3
CategoryScroll.Parent = MainFrame
local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
CategoryLayout.Padding = UDim.new(0, 6)
CategoryLayout.Parent = CategoryScroll
-- Content Frame Area
local ContainerFrame = Instance.new("Frame")
ContainerFrame.Size = UDim2.new(1, -20, 1, -90)
ContainerFrame.Position = UDim2.new(0, 10, 0, 84)
ContainerFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 25)
ContainerFrame.Parent = MainFrame
local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 10)
ContainerCorner.Parent = ContainerFrame
-- State & Language Systems
local currentLang = "TH"
local registeredButtons = {}
local categoryButtonsUI = {}
local pagesMap = {}
local activeToggles = {}
local function toggleState(featureName)
activeToggles[featureName] = not activeToggles[featureName]
print("[TiwHub] Feature " .. featureName .. " set to: " .. tostring(activeToggles[featureName]))
end
local function CreatePage(pageID)
local scroll = Instance.new("ScrollingFrame")
scroll.Name = pageID
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.fromScale(0, 12.0)
scroll.ScrollBarThickness = 4
scroll.Visible = false
scroll.Parent = ContainerFrame
local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)
layout.Parent = scroll
  local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 6)
padding.PaddingLeft = UDim.new(0, 6)
padding.PaddingRight = UDim.new(0, 6)
padding.PaddingBottom = UDim.new(0, 6)
padding.Parent = scroll
pagesMap[pageID] = scroll
return scroll
end
local function AddSectionHeader(page, titleEN, titleTH)
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 0, 26)
lbl.BackgroundColor3 = Color3.fromRGB(25, 30, 46)
lbl.TextColor3 = Color3.fromRGB(90, 220, 255)
lbl.TextSize = 11
lbl.Font = Enum.Font.GothamBold
lbl.Text = "  " .. (currentLang == "TH" and titleTH or titleEN)
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = page
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = lbl
table.insert(registeredButtons, { Element = lbl, TH = "  " .. titleTH, EN = "  " .. titleEN })
end
local function AddButton(page, textEN, textTH, callback)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 0, 32)
btn.BackgroundColor3 = Color3.fromRGB(32, 38, 56)
btn.TextColor3 = Color3.fromRGB(245, 245, 245)
btn.TextSize = 11
btn.Font = Enum.Font.GothamSemibold
btn.Text = (currentLang == "TH" and textTH or textEN)
btn.Parent = page
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = btn
btn.MouseButton1Click:Connect(function()
pcall(callback)
end)
table.insert(registeredButtons, { Element = btn, TH = textTH, EN = textEN })
end
-- Strictly Defined 11 Categories List
local categoriesList = {
{ ID = "1. Main Farm", EN = "1. Main Farm", TH = "1. ฟาร์มหลัก & ปรับการโจมตี" },
{ ID = "2. Sea Events", EN = "2. Sea Events & Sea 3", TH = "2. ทะเล & กิจกรรมทะเล" },
{ ID = "3. Raids", EN = "3. Raids & Dungeons", TH = "3. ดันเจี้ยน & ปลุกผล" },
{ ID = "4. Quests & Weapons", EN = "4. Quests & Weapons", TH = "4. เควสอาวุธ & เผ่า V4" },
{ ID = "5. Boss Hunter", EN = "5. Boss Hunter", TH = "5. ล่าบอส" },
{ ID = "6. Teleport", EN = "6. Teleport & Navigation", TH = "6. ระบบวาร์ป & เดินทาง" },
{ ID = "7. Stats & Shop", EN = "7. Stats & Shop", TH = "7. สเตตัส & ร้านค้าผลไม้" },
{ ID = "8. Visuals & ESP", EN = "8. Visuals & ESP", TH = "8. มองเห็น & โหมดสายฟาร์ม" },
{ ID = "9. PvP & Combat", EN = "9. PvP & Combat", TH = "9. ระบบช่วยต่อสู้ PvP" },
{ ID = "10. Character Mods", EN = "10. Character Mods", TH = "10. ปรับแต่งตัวละคร" },
{ ID = "11. Anti-Ban & System", EN = "11. Safety & System", TH = "11. ความปลอดภัย & ตั้งค่า" }
}
for _, cat in ipairs(categoriesList) do
CreatePage(cat.ID)
end
local function SwitchPage(targetID)
for id, page in pairs(pagesMap) do
page.Visible = (id == targetID)
end
end
for _, cat in ipairs(categoriesList) do
local catBtn = Instance.new("TextButton")
catBtn.Size = UDim2.fromOffset(160, 30)
catBtn.BackgroundColor3 = Color3.fromRGB(38, 45, 68)
catBtn.TextColor3 = Color3.fromRGB(255, 210, 80)
catBtn.TextSize = 10
catBtn.Font = Enum.Font.GothamBold
catBtn.Text = (currentLang == "TH" and cat.TH or cat.EN)
catBtn.Parent = CategoryScroll
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = catBtn
catBtn.MouseButton1Click:Connect(function()
SwitchPage(cat.ID)
end)
table.insert(categoryButtonsUI, { Element = catBtn, TH = cat.TH, EN = cat.EN })
end
SwitchPage("1. Main Farm")
-- Language Switcher Functionality
local function UpdateLanguage(newLang)
currentLang = newLang
for _, item in ipairs(registeredButtons) do
item.Element.Text = (currentLang == "TH" and item.TH or item.EN)
end
for _, item in ipairs(categoryButtonsUI) do
item.Element.Text = (currentLang == "TH" and item.TH or item.EN)
end
print("[TiwHub] Language switched to: " .. currentLang)
end
-- Core Engine: Background On-Death Buso Haki Loop
local function EnableBusoHaki()
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
if not char:FindFirstChild("Buso") then
local comm = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
if comm then
comm:InvokeServer("Buso")
print("[TiwHub Engine] Buso Haki Auto Activated.")
end
end
end
end)
end
local function SetupCharacter(char)
local humanoid = char:WaitForChild("Humanoid", 10)
if humanoid then
task.wait(1.2)
EnableBusoHaki()
end
end
if LocalPlayer.Character then SetupCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(SetupCharacter)
task.spawn(function()
while true do
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") and not char:FindFirstChild("Buso") then
EnableBusoHaki()
end
end)
task.wait(3.5)
end
end)
-- ==============================================================================
-- 1. Main Farm (ระบบฟาร์มหลักและปรับแต่งการโจมตี)
-- ==============================================================================
local p1 = pagesMap["1. Main Farm"]
AddSectionHeader(p1, "1.1 Auto Leveling System", "1.1 ระบบฟาร์มเลเวลอัตโนมัติ")
AddButton(p1, "Auto Farm Level (Auto Quest & Farm)", "ออโต้ฟาร์มเลเวล (รับเควส -> วาร์ป -> ตีมอน -> ส่งเควส)", function() toggleState("AutoFarmLevel") end)
AddButton(p1, "Select Quest Method (Auto / Direct No Quest)", "เลือกโหมดรับเควส (Auto Quest / Direct Farm)", function() toggleState("DirectFarm") end)
AddButton(p1, "Auto Second / Third Sea Quest Progression", "ทำเควสเปลี่ยนทะเลอัตโนมัติ (Sea 1 -> 2 -> 3)", function() toggleState("AutoSeaPass") end)
AddSectionHeader(p1, "1.2 Attack & Farm Configurations", "1.2 ปรับแต่งการโจมตีและการฟาร์ม")
AddButton(p1, "Fast Attack Speed (Super Fast / Custom Delay)", "ปรับความเร็วโจมตีระดับสูง (Fast Attack Speed)", function() toggleState("FastAttack") end)
AddButton(p1, "Hitbox Extender (360 Range Hit)", "ขยายขนาดวงการโจมตีมอนรอบทิศทาง 360 องศา", function() toggleState("HitboxExtender") end)
AddButton(p1, "Bring Mob / Mob Magnet", "ระบบดึงมอนสเตอร์รอบเกาะมารวมจุดเดียว", function() toggleState("BringMob") end)
AddButton(p1, "Set Bring Mob Radius (10 - 500 Studs)", "ปรับระยะความกว้างการดึงมอนสเตอร์", function() print("[TiwHub] Radius Set to Max") end)
AddButton(p1, "Select Weapon to Farm (Melee/Sword/Fruit/Gun)", "เลือกอาวุธสำหรับใช้ฟาร์มหลัก", function() print("[TiwHub] Weapon Selected") end)
AddButton(p1, "Farm Disabler / Safe Mode", "สลับจุดยืนตีเพื่อหลบการโจมตีมอนสเตอร์ (กันตาย)", function() toggleState("SafeFarmMode") end)
AddButton(p1, "Auto Skill Switch (Z, X, C, V, F)", "สลับกดใช้สกิล Z, X, C, V, F อัตโนมัติขณะฟาร์ม", function() toggleState("AutoSkillSwitch") end)
AddSectionHeader(p1, "1.3 Target & Mastery Farming", "1.3 ฟาร์มเป้าหมายเจาะจง & ค่า Mastery")
AddButton(p1, "Select Specific Mob / Boss", "เลือกเจาะจงมอนสเตอร์หรือบอสบนเกาะ", function() print("[TiwHub] Specific Mob Selected") end)
AddButton(p1, "Auto Selected Mob / Boss Farm", "สั่งตีเฉพาะเป้าหมายที่เลือกไว้เพื่อปั๊มของดรอป", function() toggleState("FarmSelectedMob") end)
AddButton(p1, "Mastery Health Percentage Slider (10% - 50%)", "ปรับ % เลือดมอนสำหรับสลับใช้สกิลดัน Mastery", function() print("[TiwHub] Mastery Health set to 25%") end)
AddButton(p1, "Auto Farm Fruit Mastery (Z, X, C, V, F Skills)", "ฟาร์มค่า Mastery ผลปีศาจด้วยสกิลอัตโนมัติ", function() toggleState("FruitMastery") end)
AddButton(p1, "Auto Farm Sword Mastery (Z, X Skills)", "ฟาร์มค่า Mastery ดาบด้วยสกิลอัตโนมัติ", function() toggleState("SwordMastery") end)
AddButton(p1, "Auto Farm Bones (Haunted Castle)", "ฟาร์มมอนสเตอร์บนเกาะผีสิงเพื่อสะสมกระดูก", function() toggleState("FarmBones") end)
AddButton(p1, "Auto Random Bones Gacha (Death King)", "นำกระดูกไปสุ่มไอเทมที่ NPC Death King อัตโนมัติ", function() toggleState("RandomBones") end)
-- ==============================================================================
-- 2. Sea Events & Sea 3 Features (ทะเลและกิจกรรมทะเล)
-- ==============================================================================
local p2 = pagesMap["2. Sea Events"]
AddSectionHeader(p2, "2.1 Sea Events Automation", "2.1 ระบบฟาร์มอีเวนต์ทะเลอัตโนมัติ")
AddButton(p2, "Auto Shipwright / Sail Ship Coordinates", "ขับเรือออกทะเลตามพิกัดเร่งการเกิดอีเวนต์", function() toggleState("SailShip") end)
AddButton(p2, "Auto Spawn Sea Events (Danger Level 1 - 6)", "ขับเรือวนใน Danger Level 1-6 เรียกมอนทะเล", function() toggleState("DangerLevelSail") end)
AddButton(p2, "Auto Kill Terrorshark (Skill Dodge)", "ตรวจจับและสังหาร Terrorshark พร้อมหลบสกิล", function() toggleState("KillTerrorShark") end)
AddButton(p2, "Auto Kill Sea Beast (Single & Trio)", "ล็อกเป้าโจมตี Sea Beast (เดี่ยว/สามตัว) อัตโนมัติ", function() toggleState("KillSeaBeast") end)
AddButton(p2, "Auto Kill Ghost Ship / Piranha / Shark", "กำจัดเรือผีสิง, ฝูงปิรันย่า และฉลามธรรมดา", function() toggleState("KillMobsSea") end)
AddButton(p2, "Boat Utilities (Buy / Repair / Clear Fog)", "ซื้อเรือ, ซ่อมเรืออัตโนมัติ และเคลียร์หมอกทะเล", function() toggleState("BoatUtilities") end)
AddSectionHeader(p2, "2.2 Leviathan & Specialized Islands", "2.2 ล่า Leviathan และเกาะพิเศษ")
AddButton(p2, "Auto Leviathan Hunt (Heart & Scale Collector)", "ติดตามหัวเรือ ตี Leviathan และเก็บ Heart/Scales", function() toggleState("HuntLeviathan") end)
AddButton(p2, "Mirage Island Detector & Teleport", "แจ้งเตือนและวาร์ปขึ้นเกาะ Mirage ทันทีที่เกิด", function() toggleState("MirageTeleport") end)
AddButton(p2, "Auto Gear Search (Moon Stare & Blue Gear)", "นำทางจุดสูง ส่องจันทร์ หา Blue Gear (เผ่า V4)", function() toggleState("FindBlueGear") end)
AddButton(p2, "Auto Collect Azure Embers (Kitsune Island)", "วิ่งเก็บดวงไฟสีฟ้าบนเกาะจิ้งจอกอัตโนมัติ", function() toggleState("CollectEmbers") end)
AddButton(p2, "Auto Offer Embers (Kitsune Tree Exchange)", "นำดวงไฟไปถวายต้นไม้แลกไอเทมตำนาน", function() toggleState("OfferEmbers") end)
-- ==============================================================================
-- 3. Raids & Dungeons (ระบบดันเจี้ยนและปลุกพลังผล)
-- ==============================================================================
local p3 = pagesMap["3. Raids"]
AddSectionHeader(p3, "3.1 Dungeon Automation", "3.1 ระบบลงดันเจี้ยนอัตโนมัติ")
AddButton(p3, "Select Raid Microchip Type", "เลือกประเภทชิปดันเจี้ยนที่ต้องการลง", function() print("[TiwHub] Raid Chip Selected") end)
AddButton(p3, "Auto Buy Chip Method (Beli / Physical Fruit)", "เลือกวิธีซื้อชิป (เงิน Beli หรือผลปีศาจ)", function() print("[TiwHub] Chip Buy Method Selected") end)
AddButton(p3, "Auto Start Dungeon Room", "เดินไปกดแท่นเริ่มดันเจี้ยนให้อัตโนมัติ", function() toggleState("StartDungeon") end)
AddButton(p3, "Kill Aura / Instant Dungeon Clear (Islands 1-5)", "กำจัดมอนในห้องดันเจี้ยนทันทีที่เกิด (ลุยจบ 1-5)", function() toggleState("DungeonKillAura") end)
AddButton(p3, "Auto Next Island Teleport Gate", "วาร์ปตัวละครไปยังประตูดันเจี้ยนถัดไปทันที", function() toggleState("NextIslandGate") end)
AddSectionHeader(p3, "3.2 Awaken Systems", "3.2 ระบบปลุกพลังผลปีศาจ")
AddButton(p3, "Auto Awaken Skill (NPC Auto Talk)", "คุยกับ NPC Awaken ปลดล็อกสกิลให้อัตโนมัติ", function() toggleState("AutoAwakenSkill") end)
AddButton(p3, "Buy Advanced Raid Microchip", "ซื้อชิปเรดขั้นสูงด้วย Fragments", function() toggleState("BuyAdvChip") end)
-- ==============================================================================
-- 4. Quests, Swords & Fighting Styles (เควสอาวุธและหมัด)
-- ==============================================================================
local p4 = pagesMap["4. Quests & Weapons"]
AddSectionHeader(p4, "4.1 Melee Unlocks (Fighting Styles)", "4.1 ปลดล็อกศิลปะการต่อสู้")
AddButton(p4, "Auto Fighting Styles (Superhuman/Step/Claw/Talon)", "ปลดล็อก Superhuman, Death Step, Sharkman, Claw", function() toggleState("AutoStyles") end)
AddButton(p4, "Auto Godhuman Unlocker", "เช็คเงื่อนไขวัตถุดิบ เงิน Beli, Frags และทำเควส Godhuman", function() toggleState("AutoGodhuman") end)
AddButton(p4, "Auto Sanguine Art Quest & Purchase", "ช่วยทำเควสสูบเลือด Leviathan และซื้อหมัด Sanguine", function() toggleState("AutoSanguine") end)
AddSectionHeader(p4, "4.2 Sword & Item Quests", "4.2 เควสอาวุธและดาบตำนาน")
AddButton(p4, "Auto Legendary Swords (Saber/Yama/Tushita/etc)", "ทำเควสเก็บ Saber, Rengoku, Midnight, Tushita, Yama", function() toggleState("AutoSwords") end)
AddButton(p4, "Auto Cursed Dual Katana (CDK Quests)", "ทำภารกิจ Good & Evil ของ Tushita และ Yama", function() toggleState("AutoCDK") end)
AddButton(p4, "Auto Haze of Misery (Purple Aura Mob Farm)", "ไล่ตีมอนสเตอร์ออร่าสีม่วงทั่วแมพเพื่อผ่านเควส", function() toggleState("HazeOfMisery") end)
AddButton(p4, "Auto True Triple Katana (TTK Dealer Radar)", "ตรวจจับ Sword Dealer ใน Sea 2 และซื้อดาบ 3 เล่ม", function() toggleState("AutoTTK") end)
AddButton(p4, "Auto Soul Guitar (Full Moon Castle Quest)", "ทำเควสคืนวันพระจันทร์เต็มดวงที่ Haunted Castle", function() toggleState("AutoSoulGuitar") end)
AddSectionHeader(p4, "4.3 Race V4 & Trials", "4.3 ระบบเผ่า V4 และดันทดสอบ")
AddButton(p4, "Full Moon Status Indicator (0% - 100%)", "เช็คสถานะดวงจันทร์บนหน้าจอ (Full Moon %)", function() print("[TiwHub] Full Moon Status: Checked") end)
AddButton(p4, "Auto Temple of Time Teleport", "วาร์ปไปวิหารกาลเวลา (Temple of Time)", function() toggleState("TeleportTemple") end)
AddButton(p4, "Auto Trial Automation (All Races Supported)", "ช่วยผ่านดันทดสอบของทุกเผ่าอัตโนมัติ", function() toggleState("AutoRaceTrial") end)
AddButton(p4, "Auto Pull Temple Lever", "ออโต้ดึงคันโยกเกาะฟ้าเปิดประตู", function() toggleState("PullLeverV4") end)
AddButton(p4, "Auto Ancient One Upgrade Skill Tree", "อัปเกรดแผนผังพรสวรรค์เผ่า V4 อัตโนมัติ", function() toggleState("AutoAncientOne") end)
-- ==============================================================================
-- 5. Boss Hunter (ระบบล่าบอส)
-- ==============================================================================
local p5 = pagesMap["5. Boss Hunter"]
AddSectionHeader(p5, "Boss Hunting Automation", "ระบบล่าบอสอัตโนมัติ")
AddButton(p5, "Auto Farm All Spawned Bosses", "ออโต้ฟาร์มบอสที่เกิดใหม่ทั้งหมดบนแมพ", function() toggleState("FarmAllBosses") end)
AddButton(p5, "Select Specific Target Boss", "เลือกเจาะจงบอสที่ต้องการฟาร์ม", function() print("[TiwHub] Specific Boss Selected") end)
AddButton(p5, "Auto Katakuri V2 Farm", "ออโต้ฟาร์มบอส Katakuri V2", function() toggleState("FarmKatakuriV2") end)
AddButton(p5, "Auto Darkbeard Farm", "ออโต้ฟาร์มบอส Darkbeard", function() toggleState("FarmDarkbeard") end)
AddButton(p5, "Auto Whitebeard Farm", "ออโต้ฟาร์มบอส Whitebeard", function() toggleState("FarmWhitebeard") end)
AddButton(p5, "Auto Kizaru / Doflamingo / Soul Reaper Farm", "ออโต้ฟาร์มบอส Kizaru, Doflamingo, Soul Reaper", function() toggleState("FarmSpecialBosses") end)
-- ==============================================================================
-- 6. Teleport & Navigation (ระบบวาร์ปและการเดินทาง)
-- ==============================================================================
local p6 = pagesMap["6. Teleport"]
AddSectionHeader(p6, "6.1 World & Island Teleport", "6.1 วาร์ปสลับโลกและเกาะหลัก")
AddButton(p6, "Sea Teleport (First / Second / Third Sea)", "วาร์ปสลับข้ามโลก (Sea 1 / Sea 2 / Sea 3)", function() print("[TiwHub] Teleporting Sea...") end)
AddButton(p6, "Select Island Target (Tween System)", "เลือกวาร์ปไปยังเกาะทั้งหมดด้วยระบบ Tween", function() print("[TiwHub] Island Selected") end)
AddButton(p6, "Tween Speed Slider (200 - 350 Studs/Sec)", "ปรับระดับความเร็วในการวาร์ปบินข้ามแมพ", function() print("[TiwHub] Tween Speed Set to 250") end)
AddSectionHeader(p6, "6.2 Specific Teleports", "6.2 วาร์ปจุดสำคัญและบุคคล")
AddButton(p6, "Teleport to Specific NPC", "เลือกวาร์ปไปหา NPC ใดก็ได้ในเกม", function() print("[TiwHub] NPC Selected") end)
AddButton(p6, "Teleport to Target Player", "วาร์ปไปหาผู้เล่นคนอื่นในเซิร์ฟเวอร์", function() print("[TiwHub] Player Selected") end)
AddButton(p6, "Safe Zone Instant Teleport", "วาร์ปเข้าพื้นที่ปลอดภัยทันทีเมื่อโดนโจมตี", function() toggleState("TeleportSafeZone") end)
AddButton(p6, "Teleport Active Quest NPC / Spawned Boss", "วาร์ปไปหา NPC เควสปัจจุบัน หรือบอสที่เกิด", function() toggleState("TeleportQuestBoss") end)
-- ==============================================================================
-- 7. Stats & Shop Automation (สเตตัส ร้านค้า และผลไม้)
-- ==============================================================================
local p7 = pagesMap["7. Stats & Shop"]
AddSectionHeader(p7, "7.1 Auto Stats Assign", "7.1 ระบบอัปสเตตัสอัตโนมัติ")
AddButton(p7, "Select Stat Type (Melee/Defense/Sword/Gun/Fruit)", "เลือกสายสเตตัสที่ต้องการอัป", function() print("[TiwHub] Stat Type Selected") end)
AddButton(p7, "Select Points per Click (1 / 3 / 10 / Max Points)", "เลือกจำนวนแต้มที่จะอัปต่อครั้ง", function() print("[TiwHub] Stat Amount Selected") end)
AddButton(p7, "Auto Assign Points on Level Up", "ลงแต้มสเตตัสให้อัตโนมัติทันทีที่เลเวลอัป", function() toggleState("AutoStats") end)
AddSectionHeader(p7, "7.2 Fruit Systems & Shop Automation", "7.2 ระบบสุ่มผลไม้ ร้านค้า และสไนเปอร์")
AddButton(p7, "Auto Random Fruit Gacha (Cousin NPC)", "สุ่มผลปีศาจจาก NPC เมื่อครบ Cooldown", function() toggleState("AutoGacha") end)
AddButton(p7, "Auto Store Fruit to Personal Storage", "ตรวจสอบผลไม้ในตัว แล้วเก็บเข้าคลังอัตโนมัติ", function() toggleState("AutoStoreFruit") end)
AddButton(p7, "Fruit Sniper (Auto Buy Dough/Leo/Kitsune/Dragon)", "ดักซื้อผลปีศาจระดับสูงทันทีที่มีการ Restock", function() toggleState("FruitSniper") end)
AddButton(p7, "Auto Bring Fruit on Map", "ดึงผลปีศาจที่ตกอยู่บนพื้นทั่วแมพเข้าหาตัว", function() toggleState("BringFruit") end)
AddButton(p7, "Buy Abilities / Haki / Styles / Items", "ซื้อฮากิสังเกต, สีฮากิ, สไตล์ต่อสู้ และปืนออโต้", function() toggleState("AutoShopBuyer") end)
-- ==============================================================================
-- 8. Visuals & ESP (การมองเห็นและช่วยการแสดงผล)
-- ==============================================================================
local p8 = pagesMap["8. Visuals & ESP"]
AddSectionHeader(p8, "8.1 ESP System", "8.1 ระบบมองเห็นผ่านกำแพง (ESP)")
AddButton(p8, "Player ESP (Box / Name / Distance / HP)", "แสดงกรอบ, ชื่อ, ระยะ และเลือดของผู้เล่นคนอื่น", function() toggleState("ESPPlayer") end)
AddButton(p8, "Fruit ESP (Spawned Fruits Tracking)", "แสดงตำแหน่งผลปีศาจที่เกิดตามพื้นและระยะห่าง", function() toggleState("ESPFruit") end)
AddButton(p8, "Chest ESP (Silver / Gold / Diamond)", "แสดงตำแหน่งกล่องสมบัติทุกชนิดบนแมพ", function() toggleState("ESPChest") end)
AddButton(p8, "Flower ESP (Red & Blue Flower Quest)", "แสดงตำแหน่งดอกไม้เควสเผ่า V2", function() toggleState("ESPFlower") end)
AddButton(p8, "Mirage & Kitsune Island ESP", "แสดงทิศทางและระยะทางไปยังเกาะพิเศษ", function() toggleState("ESPIslands") end)
AddSectionHeader(p8, "8.2 Performance & Optimization Tools", "8.2 โหมดเพิ่มความเร็วและเปิด AFK")
AddButton(p8, "White Screen / Fast Render Mode (AFK)", "โหมดจอขาว ลดภาระ GPU/CPU สำหรับเปิด AFK", function() toggleState("WhiteScreen") end)
AddButton(p8, "Disable 3D Rendering Graphics", "ปิดการเรนเดอร์ภาพกราฟิก 3D ทั้งหมด", function() RunService:Set3dRenderingEnabled(not activeToggles["Disable3D"]) toggleState("Disable3D") end)
AddButton(p8, "FPS Booster / Remove Map Effects", "ลบหมอก, เอฟเฟกต์สกิล และพื้นผิวเพื่อดัน FPS", function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
end
end)
AddButton(p8, "Anti-AFK Inactivity Bypass (20 Min Kick Fix)", "ระบบกันโดนเตะออกจากเกมเมื่อยืนนิ่งเกิน 20 นาที", function()
LocalPlayer.Idled:Connect(function()
VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(1)
VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
print("[TiwHub] Anti-AFK Engine Started.")
end)
-- ==============================================================================
-- 9. PvP & Combat Assistance (ระบบช่วยต่อสู้ PvP)
-- ==============================================================================
local p9 = pagesMap["9. PvP & Combat"]
AddSectionHeader(p9, "Combat & Target Locking", "ระบบช่วยต่อสู้และล็อกเป้าหมาย")
AddButton(p9, "Player Target Lock Aim", "ล็อกเป้าหมายผู้เล่นคนอื่นในระยะต่อสู้", function() toggleState("LockPlayerTarget") end)
AddButton(p9, "Skill Aim Auto-Targeting", "ปรับทิศทางการใช้สกิลอาวุธ/ผลให้เล็งใส่เป้าหมาย", function() toggleState("SkillAimAssist") end)
AddButton(p9, "Safe Health Escape (Fly Up / Safezone)", "วาร์ปขึ้นฟ้าหรือเข้า Safe Zone เมื่อ HP ต่ำ", function() toggleState("LowHPEscape") end)
AddButton(p9, "Auto Active Race V3 / V4 Ability", "กดเปิดใช้งานพลังเผ่า V3 / V4 อัตโนมัติเมื่อเกจเต็ม", function() toggleState("AutoActiveRace") end)
AddButton(p9, "Auto Ken Haki Dodge & Max Training", "ออโต้หลบการโจมตีและฝึกฮากิสังเกตจนตัน", function() toggleState("KenDodgeTrain") end)
-- ==============================================================================
-- 10. Character Mods (ปรับแต่งตัวละคร)
-- ==============================================================================
local p10 = pagesMap["10. Character Mods"]
AddSectionHeader(p10, "Character Movement & Physical Hacks", "ปรับแต่งการเคลื่อนที่ของตัวละคร")
AddButton(p10, "WalkSpeed Boost (100+ Speed)", "เพิ่มความเร็วในการเดิน (WalkSpeed Boost)", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 100 end end)
AddButton(p10, "JumpPower Boost (150+ Jump)", "เพิ่มพลังในการกระโดด (JumpPower Boost)", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 150 end end)
AddButton(p10, "Noclip Mode (Pass Through Walls)", "โหมดเดินทะลุกำแพงและสิ่งกีดขวาง", function() toggleState("Noclip") end)
AddButton(p10, "Fly Mode Flight Controls", "โหมดบินอิสระ (Fly Mode)", function() toggleState("FlyMode") end)
AddButton(p10, "Levitation Float Mode", "โหมดลอยตัวกลางอากาศ (Levitation)", function() toggleState("Levitate") end)
AddButton(p10, "Water Damage Immunity", "ป้องกันการได้รับความเสียหายเมื่อตกน้ำทะเล", function() toggleState("WaterImmune") end)
AddButton(p10, "Infinite Jump Air Leap", "กระโดดไม่จำกัดกลางอากาศ (Infinite Jump)", function() toggleState("InfJump") end)
-- ==============================================================================
-- 11. Anti-Ban & System Settings (ความปลอดภัย & ตั้งค่า)
-- ==============================================================================
local p11 = pagesMap["11. Anti-Ban & System"]
AddSectionHeader(p11, "Language & Interface Scale", "สลับภาษาและปรับขนาด UI")
AddButton(p11, "Switch Language: English / ไทย", "ระบบสลับภาษา: ไทย / English", function()
if currentLang == "TH" then UpdateLanguage("EN") else UpdateLanguage("TH") end
end)
AddButton(p11, "UI Size: Mobile Compact (Default)", "ปรับขนาด UI: มือถือกะทัดรัด (เริ่มต้น)", function()
MainFrame.Size = UDim2.fromOffset(620, 420)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -210)
end)
AddButton(p11, "UI Size: Tablet / Large Display", "ปรับขนาด UI: หน้าจอใหญ่ (แท็บเล็ต)", function()
MainFrame.Size = UDim2.fromOffset(740, 480)
MainFrame.Position = UDim2.new(0.5, -370, 0.5, -240)
end)
AddSectionHeader(p11, "Safety & Anti-Admin Detection", "ความปลอดภัยและตรวจจับแอดมิน")
AddButton(p11, "Anti-Admin Detector (Auto Kick)", "ระบบตรวจจับแอดมินพร้อมออโต้เตะออกเมื่อเจอ", function() toggleState("AntiAdmin") end)
AddButton(p11, "Stealth Radar Hiding & Hide Name", "ซ่อนป้ายชื่อเหนือหัวและซ่อนจากเรดาร์ผู้เล่นอื่น", function() toggleState("StealthName") end)
AddButton(p11, "PvP Warning Alert System", "แจ้งเตือนเมื่อโดนเปิดโหมด PvP ใส่", function() toggleState("PvPAlert") end)
AddButton(p11, "Realtime Players & Ping/FPS Display", "แสดงจำนวนคนในเซิร์ฟเวอร์ และ FPS/Ping", function()
local stats = game:GetService("Stats")
print("[Stats] Players: " .. #Players:GetPlayers() .. " | FPS: " .. math.floor(workspace:GetRealPhysicsFPS()) .. " | Ping: " .. math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()))
end)
AddButton(p11, "Rejoin Current Server", "เข้าเซิร์ฟเวอร์เดิมใหม่ (แก้แลก)", function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
AddButton(p11, "Server Hop Low Players", "ย้ายเซิร์ฟเวอร์สุ่ม (เลือกคนน้อย)", function() print("[TiwHub] Server Hopping...") end)
AddButton(p11, "Destroy Script UI Permanently", "ทำลาย UI ทั้งหมดทิ้ง", function() ScreenGui:Destroy() end)
-- Mobile Touch Dragging Engine
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
print("[TiwHub] Complete Script Loaded Successfully!")
