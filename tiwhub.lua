local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===== สร้างหน้าจอหลัก =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FeatureMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ปุ่มเปิดเมนู
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 140, 0, 45)
OpenBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(124, 108, 255)
OpenBtn.Text = "📖 เมนูฟีเจอร์"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.TextSize = 14
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

-- หน้าต่างเมนู
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 460)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(26, 27, 38)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- แถบชื่อเรื่อง
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(36, 37, 52)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "📖 โครงสร้างฟีเจอร์ — เพื่อการเรียนรู้"
Title.TextColor3 = Color3.fromRGB(124, 108, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 30)
CloseBtn.Position = UDim2.new(1, -50, 0, 8)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

-- แถบหมวดหมู่
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -10, 0, 40)
TabContainer.Position = UDim2.new(0, 5, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- พื้นที่เนื้อหา
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 4
ContentFrame.CanvasSize = UDim2.new()
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.Parent = ContentFrame

-- =============================================
-- 📂 ข้อมูลหมวดหมู่และฟีเจอร์ — ตามรายการที่ส่งมา
-- =============================================
local Categories = {
    {
        name = "ฟาร์ม", icon = "🌾",
        items = {
            "Auto Farm Level — เก็บเลเวลอัตโนมัติ",
            "Auto Farm Boss / Selected Boss — ตีบอสอัตโนมัติ",
            "Auto Farm Mastery — ฝึกฝนอาวุธ/ผลไม้",
            "Auto Quest Items — เก็บไอเทมภารกิจ"
        }
    },
    {
        name = "ต่อสู้", icon = "⚔️",
        items = {
            "Fast Attack — เร่งความเร็วโจมตี",
            "Bring Mobs — ดึงมอนสเตอร์มารวมกัน",
            "Kill Aura / Attack Aura — โจมตีรอบตัว",
            "Disable Mob Collision — ปิดการชนกับมอนสเตอร์"
        }
    },
    {
        name = "ดันเจี้ยน", icon = "🏛️",
        items = {
            "Auto Buy Microchip — ซื้อชิปเปิดดันเจี้ยน",
            "Auto Start Raid — เริ่มเรดอัตโนมัติ",
            "Auto Awaken Fruit — ปลุกพลังผลไม้"
        }
    },
    {
        name = "ทะเล", icon = "🌊",
        items = {
            "Auto Sea Beasts / Terror Shark — ล่าสัตว์ทะเล",
            "Mirage Island Finder — ค้นหาเกาะมิราจ",
            "Auto Find Gear V4 — ค้นหาจุดบูชา V4"
        }
    },
    {
        name = "ปลดล็อก", icon = "🔓",
        items = {
            "Race V4 Automation — เควสอัปเกรดเผ่า V4",
            "Legendary Swords — ดาบพิเศษทั้งหมด",
            "Soul Guitar Quest — เควสปืนกีตาร์โซล"
        }
    },
    {
        name = "ผลไม้", icon = "🍎",
        items = {
            "Fruit Notifier / ESP — แจ้งเตือนผลไม้",
            "Auto Teleport to Fruit — วาร์ปไปเก็บผลไม้",
            "Auto Store / Random Fruit — เก็บและสุ่มผลไม้"
        }
    },
    {
        name = "เดินทาง", icon = "🚀",
        items = {
            "Tween Teleport — วาร์ปราบรื่น",
            "Noclip — ทะลุกำแพง",
            "Infinite Jump & Fly — กระโดดไม่จำกัดและบิน"
        }
    },
    {
        name = "ผู้เล่น & PvP", icon = "👥",
        items = {
            "Auto Bounty / Player Farm — ล่าค่าหัว",
            "Player ESP / Tracer — มองเห็นผู้เล่น",
            "Safe Zone Escape — หนีเข้าเขตปลอดภัยอัตโนมัติ"
        }
    },
    {
        name = "สเตตัส & ร้านค้า", icon = "📊",
        items = {
            "Auto Assign Stats — จ่ายค่าสเตตัสอัตโนมัติ",
            "Remote Shop — เปิดร้านค้าจากระยะไกล"
        }
    },
    {
        name = "เครื่องมือ", icon = "🛠️",
        items = {
            "Anti-AFK — ป้องกันหลุดจากเซิร์ฟ",
            "Server Hop — เปลี่ยนเซิร์ฟเวอร์",
            "Remove Textures / FPS Boost — เพิ่มความลื่น"
        }
    }
}

local tabs = {}
local currentCat = nil
local selectedColor = Color3.fromRGB(124, 108, 255)
local normalColor = Color3.fromRGB(45, 47, 65)

-- ===== สร้างปุ่มหมวดหมู่ =====
local function CreateCategoryTabs()
    for _, c in ipairs(TabContainer:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    tabs = {}
    
    for i, cat in ipairs(Categories) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 62, 1, 0)
        btn.Position = UDim2.new(0, (i-1)*66, 0, 0)
        btn.BackgroundColor3 = normalColor
        btn.Text = cat.icon
        btn.TextColor3 = Color3.new(0.8, 0.8, 0.9)
        btn.TextSize = 18
        btn.Font = Enum.Font.GothamBold
        btn.Parent = TabContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function()
            for _, b in ipairs(tabs) do
                b.BackgroundColor3 = normalColor
                b.TextColor3 = Color3.new(0.8, 0.8, 0.9)
            end
            btn.BackgroundColor3 = selectedColor
            btn.TextColor3 = Color3.new(1, 1, 1)
            currentCat = cat
            UpdateContent()
        end)
        
        tabs[i] = btn
    end
end

-- ===== อัปเดตเนื้อหาตามหมวดหมู่ =====
function UpdateContent()
    for _, c in ipairs(ContentFrame:GetChildren()) do
        if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end
    end
    
    if not currentCat then return end
    
    -- หัวข้อหมวด
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 32)
    Header.BackgroundTransparency = 1
    Header.Text = currentCat.icon .. "  " .. currentCat.name
    Header.TextColor3 = selectedColor
    Header.TextSize = 15
    Header.Font = Enum.Font.GothamBold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = ContentFrame
    
    -- รายการฟีเจอร์
    for _, item in ipairs(currentCat.items) do
        local ItemFrame = Instance.new("Frame")
        ItemFrame.Size = UDim2.new(1, 0, 0, 42)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(38, 40, 58)
        ItemFrame.Parent = ContentFrame
        Instance.new("UICorner", ItemFrame).CornerRadius = UDim.new(0, 6)
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = "○  " .. item
        Label.TextColor3 = Color3.new(0.85, 0.85, 0.9)
        Label.TextSize = 12
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ItemFrame
        
        -- ปุ่มสวิตช์ (แสดงเฉยๆ ไม่มีฟังก์ชัน)
        local ToggleBg = Instance.new("Frame")
        ToggleBg.Size = UDim2.new(0, 42, 0, 24)
        ToggleBg.Position = UDim2.new(1, -54, 0.5, -12)
        ToggleBg.BackgroundColor3 = Color3.fromRGB(60, 62, 80)
        ToggleBg.Parent = ItemFrame
        Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 12)
        
        local ToggleDot = Instance.new("Frame")
        ToggleDot.Size = UDim2.new(0, 18, 0, 18)
        ToggleDot.Position = UDim2.new(0, 3, 0.5, -9)
        ToggleDot.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
        ToggleDot.Parent = ToggleBg
        Instance.new("UICorner", ToggleDot).CornerRadius = UDim.new(0, 9)
        
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
        ToggleBtn.BackgroundTransparency = 1
        ToggleBtn.Parent = ItemFrame
        
        local isOn = false
        ToggleBtn.MouseButton1Click:Connect(function()
            isOn = not isOn
            local targetColor = isOn and selectedColor or Color3.fromRGB(60, 62, 80)
            local dotPos = isOn and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
            TweenService:Create(ToggleBg, TweenInfo.new(0.15), {BackgroundColor3 = targetColor}):Play()
            TweenService:Create(ToggleDot, TweenInfo.new(0.15), {Position = dotPos}):Play()
        end)
    end
end

-- ===== เริ่มต้นแสดงหมวดแรก =====
CreateCategoryTabs()
if #tabs > 0 then
    currentCat = Categories[1]
    tabs[1].BackgroundColor3 = selectedColor
    tabs[1].TextColor3 = Color3.new(1, 1, 1)
    UpdateContent()
end

-- ===== เปิด-ปิดเมนู =====
local isOpen = false
local function Toggllocal()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end

OpenBtn.MouseButton1Click:Connect(ToggleMenu)
CloseBtn.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.M then
        ToggleMenu()
    end
end)

-- ข้อความแจ้งเตือน
local Note = Instance.new("TextLabel")
Note.Size = UDim2.new(1, 0, 0, 25)
Note.Position = UDim2.new(0, 0, 1, -28)
Note.BackgroundTransparency = 1
Note.Text = "⚠️  โครงสร้างเพื่อการเรียนรู้เท่านั้น — ไม่มีฟังก์ชันทำงานจริง"
Note.TextColor3 = Color3.fromRGB(255, 130, 130)
Note.TextSize = 11
Note.Font = Enum.Font.Gotham
Note.Parent = MainFrame

print("✅ เมนูโครงสร้างโหลดแล้ว! กด M หรือปุ่ม '📖 เมนูฟีเจอร์' เพื่อเปิด")
print("📂 มีทั้งหมด " .. #Categories .. " หมวดหมู่ — กดที่ไอคอนด้านบนเพื่อสลับ")
