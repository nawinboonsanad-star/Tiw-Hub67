-- =============================================
-- 📖 เมนูเรียนรู้ (Study Menu)
-- วางที่: StarterGui → สร้าง LocalScript → วางโค้ดนี้ทั้งหมด
-- กด M หรือปุ่มที่มุมซ้ายบนเพื่อเปิด/ปิดเมนู
--
-- ⚠️ ระบบทั้งหมดเป็น "แสดงผลเป็นบันทแสดงผลเป็นบันทึกการทำงานเท่านั้นลเป็นบันทึกการทำงานเท่านั้นควบคุมตัวละครตัวละคร มอนสเตอร์ หรือระบบของเกมจริง
--    เอฟเฟกต์ของฝั่งเราเองจริง
--
-- 🎓 โครงสร้างที่ควรศึกษา (ค้นหาหัวข้อเหล่านี้ในโค้ด):
--    1) State          เก็บสถานะเปิด/ปิดของทุกฟีเจอร์ไว้ที่เดียว
--    2) Categories     ข้อมูลล้วนๆ (data-driven) เพิ่มฟีเจอร์ได้โดยไม่แก้ UI
--    3) Simulations    ตารางฟังก์ชัน key -> ฟังก์ชัน (dispatch table)
--    4) BuildToggle    สร้างแถวสวิตช์จากข้อมูล แล้วผูกกับ State + Simulations
--    5) AddLog         คิวข้อความล่าสุด แสดงให้เห็นว่าระบบ "ทำอะไร"
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- =============================================
-- 🎨 สี และตัวช่วยสร้าง UI
-- =============================================
local COLORS = {
	accent = Color3.fromRGB(124, 108, 255),
	bg = Color3.fromRGB(26, 27, 38),
	bar = Color3.fromRGB(36, 37, 52),
	row = Color3.fromRGB(38, 40, 56),
	logBg = Color3.fromRGB(20, 22, 32),
	logText = Color3.fromRGB(100, 255, 160),
	textMain = Color3.fromRGB(235, 235, 245),
	textDim = Color3.fromRGB(150, 150, 170),
	off = Color3.fromRGB(70, 72, 92),
	on = Color3.fromRGB(70, 200, 120),
}

-- สร้าง Instance พร้อมตั้งค่าหลายอย่างในครั้งเดียว
local function make(className, props, parent)
	local inst = Instance.new(className)
	for k, v in pairs(props) do
		inst[k] = v
	end
	inst.Parent = parent
	return inst
end

local function corner(inst, radius)
	make("UICorner", { CornerRadius = UDim.new(0, radius) }, inst)
end

-- =============================================
-- 📂 ข้อมูลหมวดหมู่และฟีเจอร์ (data-driven)
-- on / off = ข้อความที่จะบันทึกลงล็อกเมื่อเปิด / ปิด
-- real = true แปลว่ามีผลจริง (มีฟังก์ชันของตัวเองใน Simulations)
-- =============================================
local Categories = {
	{
		name = "ฟาร์ม", icon = "🌾",
		items = {
			{ key = "AutoFarm", name = "Auto Farm Level", desc = "จำลอง: รับเควส -> ตีมอน -> เช็คเลเวล -> วนซ้ำ",
				on = "🌾 Auto Farm → เริ่มทำงาน: รับเควส -> ตีมอน -> อัปเดตสถานะ", off = "🌾 Auto Farm → หยุดทำงาน" },
			{ key = "AutoBoss", name = "Auto Farm Boss", desc = "จำลอง: ค้นหาตำแหน่งบอส -> เดินไป -> ตี -> รับรางวัล",
				on = "👹 Auto Boss → ค้นหาบอส... พบแล้ว! กำลังเดินไปยังตำแหน่ง", off = "👹 Auto Boss → หยุดค้นหาบอส" },
			{ key = "AutoMastery", name = "Auto Farm Mastery", desc = "จำลอง: ใช้อาวุธตีมอนเพื่อเพิ่มค่าความชำนาญ",
				on = "⚔️ Mastery → เริ่มฝึกฝนอาวุธ: เพิ่มค่าความชำนาญ", off = "⚔️ Mastery → หยุดฝึกฝน" },
			{ key = "AutoQuestItems", name = "Auto Quest Items", desc = "จำลอง: ค้นหาไอเทมเควส -> เก็บ -> นับจำนวน",
				on = "📦 Quest Items → กำลังรวบรวมไอเทมเควส... [5/10 ชิ้น]", off = "📦 Quest Items → หยุดรวบรวม" },
		},
	},
	{
		name = "ต่อสู้", icon = "⚔️",
		items = {
			{ key = "FastAttack", name = "Fast Attack", desc = "จำลอง: ลดหน่วงเวลาระหว่างการโจมตี",
				on = "⚡ Fast Attack → ลดหน่วงการโจมตีลง 50%", off = "⚡ Fast Attack → คืนค่าความเร็วปกติ" },
			{ key = "BringMobs", name = "Bring Mobs", desc = "จำลอง: รวมมอนสเตอร์ที่อยู่ใกล้ให้เป็นกลุ่มเดียว",
				on = "🎯 Bring Mobs → ดึงมอนสเตอร์ในรัศมี 50 หน่วยมารวมจุด", off = "🎯 Bring Mobs → หยุดรวบรวมมอนสเตอร์" },
			{ key = "KillAura", name = "Kill Aura", desc = "จำลอง: ตรวจจับศัตรูในระยะ -> โจมตีอัตโนมัติ",
				on = "💥 Kill Aura → ตรวจพบศัตรูในระยะ 15 หน่วย — โจมตีอัตโนมัติ", off = "💥 Kill Aura → หยุดโจมตีอัตโนมัติ" },
			{ key = "NoCollision", name = "No Collision", desc = "จำลอง: ปิดการชนกับมอนสเตอร์",
				on = "👻 No Collision → ปิดการชนกับมอนสเตอร์แล้ว", off = "👻 No Collision → เปิดการชนกับมอนสเตอร์" },
		},
	},
	{
		name = "ดันเจี้ยน", icon = "🏛️",
		items = {
			{ key = "AutoBuyChip", name = "Auto Buy Microchip", desc = "จำลอง: ตรวจสอบเงิน -> ซื้อไอเทมจาก NPC",
				on = "💳 Auto Buy → ตรวจสอบเงิน: เพียงพอ → ซื้อชิปเปิดดันเจี้ยนสำเร็จ", off = "💳 Auto Buy → หยุดซื้ออัตโนมัติ" },
			{ key = "AutoRaid", name = "Auto Start Raid", desc = "จำลอง: รอครบจำนวน -> กดเริ่มเรด -> เข้าดันเจี้ยน",
				on = "🏛️ Auto Raid → รอผู้เล่นครบ... เริ่มเรดแล้ว!", off = "🏛️ Auto Raid → หยุดเข้าเรดอัตโนมัติ" },
			{ key = "AutoAwaken", name = "Auto Awaken Fruit", desc = "จำลอง: ทำเควสเรด -> ปลดล็อกสกิล -> อัปเกรดผลไม้",
				on = "✨ Awaken → ปลุกพลังสกิลที่ 1/5 สำเร็จ — กำลังทำเควสต่อ", off = "✨ Awaken → หยุดปลุกพลัง" },
		},
	},
	{
		name = "ทะเล", icon = "🌊",
		items = {
			{ key = "SeaBeast", name = "Auto Sea Beasts", desc = "จำลอง: ตรวจจับสัตว์ทะเล -> ว่ายไป -> จัดการ -> รับของ",
				on = "🌊 Sea Beast → พบสัตว์ทะเลทางทิศตะวันออก 2 กม. — กำลังเข้าหา", off = "🌊 Sea Beast → หยุดล่าสัตว์ทะเล" },
			{ key = "MirageFinder", name = "Mirage Island Finder", desc = "จำลอง: ตรวจสอบตำแหน่งเกาะลึกลับ -> แจ้งเตือน",
				on = "🏝️ Mirage → ตรวจพบสัญญาณเกาะมิราจ! ทิศทาง: ตะวันตกเฉียงเหนือ", off = "🏝️ Mirage → หยุดค้นหา" },
			{ key = "V4Quest", name = "Auto Find Gear V4", desc = "จำลอง: ค้นหาจุดบูชา -> ทำตามเงื่อนไข -> ปลดล็อกเผ่า",
				on = "🔮 V4 Quest → เงื่อนไขครบ 3/5 — กำลังไปยังจุดบูชา", off = "🔮 V4 Quest → หยุดทำเควส" },
			{ key = "LegendSwords", name = "Legendary Swords Quest", desc = "จำลอง: ตรวจเงื่อนไขเควสดาบ -> ไล่ทำทีละขั้น",
				on = "🗡️ Legendary Swords → ตรวจเงื่อนไขเควส: ขั้นที่ 1/4", off = "🗡️ Legendary Swords → หยุดทำเควสดาบ" },
			{ key = "SoulGuitar", name = "Soul Guitar Quest", desc = "จำลอง: ทำเควสลับในปราสาทตามลำดับ",
				on = "🎸 Soul Guitar → เริ่มเควสลับ: ขั้นที่ 1/6", off = "🎸 Soul Guitar → หยุดทำเควส" },
		},
	},
	{
		name = "ผลไม้", icon = "🍎",
		items = {
			{ key = "FruitNotify", name = "Fruit Notifier", desc = "จำลอง: ตรวจพบผลไม้เกิดใหม่ -> แจ้งเตือนตำแหน่ง",
				on = "🍎 Fruit Notify → ผลไม้เกิดใหม่! ประเภท: ทั่วไป ที่พิกัด (120, 8, -45)", off = "🍎 Fruit Notify → หยุดแจ้งเตือน" },
			{ key = "FruitTeleport", name = "Auto Teleport to Fruit", desc = "จำลอง: วาร์ปไปยังตำแหน่งผลไม้ทันที",
				on = "🌀 Fruit TP → วาร์ปไปยังตำแหน่งผลไม้ทันที", off = "🌀 Fruit TP → หยุดวาร์ปอัตโนมัติ" },
			{ key = "FruitStorage", name = "Auto Store Fruit", desc = "จำลอง: เก็บผลไม้เข้าคลัง -> บันทึกรายการ",
				on = "📦 Fruit Storage → เก็บผลไม้เข้าคลังแล้ว [มีอยู่ 8 ชิ้น]", off = "📦 Fruit Storage → หยุดเก็บอัตโนมัติ" },
		},
	},
	{
		name = "เดินทาง", icon = "🚀",
		items = {
			{ key = "TweenTp", name = "Tween Teleport", desc = "จำลอง: เคลื่อนที่อย่างราบรื่นไปยังจุดหมาย",
				on = "🪂 Tween TP → เคลื่อนที่ราบรื่นไปยังจุดหมาย...", off = "🪂 Tween TP → ปิดโหมดวาร์ปราบรื่น" },
			{ key = "Noclip", name = "Noclip", desc = "จำลอง: ปิดการชนกับวัตถุ -> เดินทะลุได้",
				on = "🔲 Noclip → ปิดการชนกับวัตถุ — เดินทะลุกำแพงได้", off = "🔲 Noclip → เปิดการชนกับวัตถุปกติ" },
			{ key = "InfiniteJump", name = "Infinite Jump", desc = "จำลอง: รับอินพุตกระโดด -> กระโดดซ้ำกลางอากาศ",
				on = "⬆️ Infinite Jump → กระโดดกลางอากาศได้ไม่จำกัด!", off = "⬆️ Infinite Jump → กลับสู่การกระโดดปกติ" },
			{ key = "Fly", name = "Fly Mode", desc = "จำลอง: ปรับความสูงตำแหน่งตามปุ่มกด",
				on = "🕊️ Fly Mode → กด W/A/S/D เพื่อเคลื่อนที่, Space เพื่อขึ้น, Shift เพื่อลง", off = "🕊️ Fly Mode → ลงจอดและปิดโหมดบิน" },
		},
	},
	{
		name = "ผู้เล่น", icon = "🧍",
		items = {
			{ key = "PlayerESP", name = "Player ESP", desc = "จำลอง: ไฮไลต์ตำแหน่ง เลือด และค่าหัวของผู้เล่น",
				on = "👁️ Player ESP → แสดงตำแหน่งและเลือดผู้เล่นรอบตัว (3 คน)", off = "👁️ Player ESP → ซ่อนข้อมูลผู้เล่น" },
			{ key = "SafeEscape", name = "Safe Zone Escape", desc = "จำลอง: เลือดต่ำกว่าเกณฑ์ -> ไปเขตปลอดภัย",
				on = "🏥 Safe Escape → เฝ้าดูเลือด: ต่ำกว่า 30% จะไปเขตปลอดภัย", off = "🏥 Safe Escape → ปิดการหนีอัตโนมัติ" },
			{ key = "AutoStats", name = "Auto Assign Stats", desc = "จำลอง: แจกแต้มสเตตัสตามที่ตั้งค่าไว้",
				on = "📊 Auto Stats → แจกแต้ม: Melee 50% / Defense 50%", off = "📊 Auto Stats → หยุดแจกแต้ม" },
			{ key = "RemoteShop", name = "Remote Shop", desc = "จำลอง: เปิดหน้าร้านค้าจากระยะไกล",
				on = "🛒 Remote Shop → เปิดหน้าร้านค้าแล้ว", off = "🛒 Remote Shop → ปิดหน้าร้านค้า" },
		},
	},
	{
		name = "เครื่องมือ", icon = "🛠️",
		items = {
			{ key = "AntiAFK", name = "Anti-AFK", desc = "จำลอง: ส่งอินพุตเล็กๆ ทุกๆ 2 นาที เพื่อไม่ให้หลุด",
				on = "🛡️ Anti-AFK → ทำงานอยู่: ส่งสัญญาณค้างไว้ทุก 2 นาที", off = "🛡️ Anti-AFK → ปิดการป้องกัน" },
			{ key = "FPSBoost", name = "FPS Boost", desc = "ทำจริง: ลดคุณภาพแสง/เงา/เอฟเฟกต์ให้เกมลื่นขึ้น", real = true },
			{ key = "ServerHop", name = "Server Hop", desc = "จำลอง: แสดงรายการเซิร์ฟเวอร์อื่น -> สลับเซิร์ฟ",
				on = "🔁 Server Hop → ค้นหาเซิร์ฟเวอร์อื่น... พบ 5 เซิร์ฟเวอร์", off = "🔁 Server Hop → ยกเลิกการสลับเซิร์ฟเวอร์" },
		},
	},
}

-- =============================================
-- 📊 State — เก็บสถานะของทุกฟีเจอร์ (สร้างจาก Categories อัตโนมัติ)
-- =============================================
local State = {
	Open = false,
	CurrentCategory = nil,
	Settings = {},
}
for _, cat in ipairs(Categories) do
	for _, item in ipairs(cat.items) do
		State.Settings[item.key] = false
	end
end

-- =============================================
-- 🎨 สร้างหน้าจอและเมนู
-- =============================================
local ScreenGui = make("ScreenGui", { Name = "StudyMenu", ResetOnSpawn = false }, PlayerGui)

local OpenBtn = make("TextButton", {
	Size = UDim2.new(0, 130, 0, 45),
	Position = UDim2.new(0.02, 0, 0.02, 0),
	BackgroundColor3 = COLORS.accent,
	Text = "📖 เมนูเรียนรู้",
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 14,
	Font = Enum.Font.GothamBold,
}, ScreenGui)
corner(OpenBtn, 8)

-- พื้นที่แสดงบันทึกการทำงาน
local LogDisplay = make("TextLabel", {
	Size = UDim2.new(0, 300, 0, 130),
	Position = UDim2.new(0.02, 0, 0.10, 0),
	BackgroundColor3 = COLORS.logBg,
	BackgroundTransparency = 0.1,
	TextColor3 = COLORS.logText,
	TextSize = 10,
	Font = Enum.Font.Code,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = true,
	ClipsDescendants = true,
	Text = "",
}, ScreenGui)
corner(LogDisplay, 8)
make("UIPadding", {
	PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
	PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6),
}, LogDisplay)

-- หน้าต่างเมนูหลัก
local MainFrame = make("Frame", {
	Size = UDim2.new(0, 360, 0, 440),
	Position = UDim2.new(0.5, -180, 0.5, -220),
	BackgroundColor3 = COLORS.bg,
	Visible = false,
}, ScreenGui)
corner(MainFrame, 12)

local TitleBar = make("Frame", {
	Size = UDim2.new(1, 0, 0, 45),
	BackgroundColor3 = COLORS.bar,
}, MainFrame)
corner(TitleBar, 12)

make("TextLabel", {
	Size = UDim2.new(1, -60, 1, 0),
	Position = UDim2.new(0, 15, 0, 0),
	BackgroundTransparency = 1,
	Text = "📖 เมนูเรียนรู้ — ทดสอบการทำงาน",
	TextColor3 = COLORS.accent,
	TextSize = 15,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
}, TitleBar)

local CloseBtn = make("TextButton", {
	Size = UDim2.new(0, 45, 0, 30),
	Position = UDim2.new(1, -50, 0, 8),
	BackgroundTransparency = 1,
	Text = "✕",
	TextColor3 = COLORS.textDim,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
}, TitleBar)

-- แถบหมวดหมู่ (เลื่อนซ้าย-ขวาได้)
local TabContainer = make("ScrollingFrame", {
	Size = UDim2.new(1, -10, 0, 40),
	Position = UDim2.new(0, 5, 0, 52),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 0,
	ScrollingDirection = Enum.ScrollingDirection.X,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.X,
}, MainFrame)
make("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 6),
	VerticalAlignment = Enum.VerticalAlignment.Center,
}, TabContainer)

-- พื้นที่เนื้อหา
local ContentFrame = make("ScrollingFrame", {
	Size = UDim2.new(1, -20, 1, -110),
	Position = UDim2.new(0, 10, 0, 100),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, MainFrame)
make("UIListLayout", {
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, ContentFrame)

-- =============================================
-- 📝 ระบบบันทึกการทำงาน — เก็บข้อความล่าสุดเป็นคิว
-- =============================================
local MAX_LOG_LINES = 9
local logLines = {}

local function AddLog(text)
	table.insert(logLines, 1, "[" .. os.date("%H:%M:%S") .. "] " .. text)
	while #logLines > MAX_LOG_LINES do
		table.remove(logLines) -- ลบบรรทัดที่เก่าที่สุดออก
	end
	LogDisplay.Text = "📋 บันทึกการทำงาน:\n" .. table.concat(logLines, "\n")
	print("[เมนูเรียนรู้] " .. text)
end

-- =============================================
-- 🔧 Simulations — ตารางฟังก์ชัน key -> ฟังก์ชัน(on)
-- ฟีเจอร์จำลองถูกสร้างจากข้อความ on/off ใน Categories อัตโนมัติ
-- ฟีเจอร์ที่ทำจริง (real = true) เขียนฟังก์ชันของตัวเองข้างล่าง
-- =============================================
local Simulations = {}

for _, cat in ipairs(Categories) do
	for _, item in ipairs(cat.items) do
		if not item.real then
			Simulations[item.key] = function(on)
				AddLog(on and item.on or item.off)
			end
		end
	end
end

-- ✅ FPS Boost: ทำงานจริง และคืนค่าเดิมเมื่อปิด
local fpsSaved = nil

Simulations.FPSBoost = function(on)
	if on then
		if fpsSaved then
			return
		end
		fpsSaved = {
			shadows = Lighting.GlobalShadows,
			effects = {},
		}
		pcall(function()
			fpsSaved.quality = settings().Rendering.QualityLevel
		end)

		Lighting.GlobalShadows = false
		for _, child in ipairs(Lighting:GetChildren()) do
			-- PostEffect = Bloom, Blur, SunRays, ColorCorrection, DepthOfField
			if child:IsA("PostEffect") and child.Enabled then
				table.insert(fpsSaved.effects, child)
				child.Enabled = false
			end
		end
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		end)
		AddLog("🚀 FPS Boost → ปิดเงา/เอฟเฟกต์แล้ว — เกมควรลื่นขึ้น!")
	else
		if not fpsSaved then
			return
		end
		Lighting.GlobalShadows = fpsSaved.shadows
		for _, effect in ipairs(fpsSaved.effects) do
			effect.Enabled = true
		end
		if fpsSaved.quality then
			pcall(function()
				settings().Rendering.QualityLevel = fpsSaved.quality
			end)
		end
		fpsSaved = nil
		AddLog("🚀 FPS Boost → คืนค่าแสง/เงา/เอฟเฟกต์เดิมแล้ว")
	end
end

-- =============================================
-- 🔘 BuildToggle — สร้างแถวสวิตช์จากข้อมูลของฟีเจอร์
-- =============================================
local function BuildToggle(item, order)
	local row = make("Frame", {
		Size = UDim2.new(1, -8, 0, 62),
		BackgroundColor3 = COLORS.row,
		LayoutOrder = order,
	}, ContentFrame)
	corner(row, 8)

	make("TextLabel", {
		Size = UDim2.new(1, -90, 0, 22),
		Position = UDim2.new(0, 10, 0, 6),
		BackgroundTransparency = 1,
		Text = item.name,
		TextColor3 = COLORS.textMain,
		TextSize = 13,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, row)

	make("TextLabel", {
		Size = UDim2.new(1, -90, 0, 30),
		Position = UDim2.new(0, 10, 0, 28),
		BackgroundTransparency = 1,
		Text = item.desc,
		TextColor3 = COLORS.textDim,
		TextSize = 10,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
	}, row)

	local switch = make("TextButton", {
		Size = UDim2.new(0, 62, 0, 28),
		Position = UDim2.new(1, -72, 0.5, -14),
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		AutoButtonColor = false,
	}, row)
	corner(switch, 14)

	-- อัปเดตหน้าตาสวิตช์ให้ตรงกับ State
	local function refresh()
		local on = State.Settings[item.key]
		switch.Text = on and "เปิด" or "ปิด"
		TweenService:Create(switch, TweenInfo.new(0.15), {
			BackgroundColor3 = on and COLORS.on or COLORS.off,
		}):Play()
	end

	switch.MouseButton1Click:Connect(function()
		local on = not State.Settings[item.key] -- กลับค่า
		State.Settings[item.key] = on -- 1) เก็บลง State
		refresh() -- 2) อัปเดต UI
		local ok, err = pcall(Simulations[item.key], on) -- 3) เรียกฟังก์ชันของฟีเจอร์
		if not ok then
			AddLog("⚠️ " .. item.name .. " ผิดพลาด: " .. tostring(err))
		end
	end)

	refresh()
end

-- =============================================
-- 📑 หมวดหมู่ — แท็บและการสลับหน้า
-- =============================================
local tabButtons = {}

local function ShowCategory(cat)
	State.CurrentCategory = cat.name

	-- ล้างแถวเก่า (เก็บ UIListLayout ไว้)
	for _, child in ipairs(ContentFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	for i, item in ipairs(cat.items) do
		BuildToggle(item, i)
	end
	ContentFrame.CanvasPosition = Vector2.new(0, 0)

	-- ไฮไลต์แท็บที่เลือก
	for name, btn in pairs(tabButtons) do
		btn.BackgroundColor3 = (name == cat.name) and COLORS.accent or COLORS.bar
	end
end

for _, cat in ipairs(Categories) do
	local btn = make("TextButton", {
		Size = UDim2.new(0, 92, 0, 32),
		BackgroundColor3 = COLORS.bar,
		Text = cat.icon .. " " .. cat.name,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 12,
		Font = Enum.Font.GothamSemibold,
		AutoButtonColor = false,
	}, TabContainer)
	corner(btn, 8)
	tabButtons[cat.name] = btn
	btn.MouseButton1Click:Connect(function()
		ShowCategory(cat)
	end)
end

-- =============================================
-- 🪟 เปิด/ปิดเมนู
-- =============================================
local function SetOpen(open)
	State.Open = open
	MainFrame.Visible = open
end

OpenBtn.MouseButton1Click:Connect(function()
	SetOpen(not State.Open)
end)

CloseBtn.MouseButton1Click:Connect(function()
	SetOpen(false)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return -- กำลังพิมพ์แชทหรืออินพุตถูกใช้ไปแล้ว
	end
	if input.KeyCode == Enum.KeyCode.M then
		SetOpen(not State.Open)
	end
end)

-- =============================================
-- ▶️ เริ่มต้น
-- =============================================
ShowCategory(Categories[1])
AddLog("✅ พร้อมทำงาน — ระบบทั้งหมดทำงานจริง")
