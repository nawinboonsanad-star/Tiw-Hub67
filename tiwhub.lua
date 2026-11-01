local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FeatureMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 130, 0, 45)
OpenBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(124, 108, 255)
OpenBtn.Text = "📖 เมนูฟีเจอร์"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.TextSize = 14
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(26, 27, 38)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(36, 37, 52)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -55, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "📖 รวมฟีเจอร์ทั้งหมด"
Title.TextColor3 = Color3.fromRGB(124, 108, 255)
Title.TextSize = 15
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

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -65)
Content.Position = UDim2.new(0, 10, 0, 55)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 0, 2100)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.Parent = Content

local Categories = {
    {name = "🌾 ระบบฟาร์มหลัก", items = {
        "Auto Farm Level",
        "Auto Farm Boss / Selected Boss",
        "Auto Farm Mastery",
        "Auto Quest Items (Bone, Ectoplasm, Materials)"
    }},
    {name = "⚔️ ระบบการต่อสู้", items = {
        "Fast Attack",
        "Bring Mobs",
        "Kill Aura / Attack Aura",
        "Disable Mob Collision"
    }},
    {name = "🏛️ ระบบดันเจี้ยนและเรด", items = {
        "Auto Buy Microchip",
        "Auto Start Raid",
        "Auto Awaken Fruit"
    }},
    {name = "🌊 ระบบอีเวนต์ทางทะเล", items = {
        "Auto Sea Beasts / Terror Shark",
        "Mirage Island Finder",
        "Auto Find Gear V4"
    }},
    {name = "🔓 ระบบปลดล็อกและเควสลับ", items = {
        "Race V4 Automation",
        "Legendary Swords (Saber, Rengoku, CDK)",
        "Soul Guitar Quest"
    }},
    {name = "🍎 ระบบผลไม้ปีศาจ", items = {
        "Fruit Notifier / ESP",
        "Auto Teleport to Fruit",
        "Auto Store / Random Fruit"
    }},
    {name = "🚀 ระบบการเดินทาง", items = {
        "Tween Teleport",
        "Noclip",
        "Infinite Jump & Fly"
    }},
    {name = "👥 ระบบผู้เล่นและ PvP", items = {
        "Auto Bounty / Player Farm",
        "Player ESP / Tracer",
        "Safe Zone Escape"
    }},
    {name = "📊 ระบบสเตตัสและร้านค้า", items = {
        "Auto Assign Stats",
        "Remote Shop"
    }},
    {name = "🛠️ ระบบเครื่องมือเสริม", items = {
        "Anti-AFK",
        "Server Hop",
        "Remove Textures / FPS Boost"
    }}
}

local function CreateCategoryHeader(name)
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 28)
    Header.BackgroundTransparency = 1
    Header.Text = name
    Header.TextColor3 = Color3.fromRGB(124, 108, 255)
    Header.TextSize = 14
    Header.Font = Enum.Font.GothamBold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content
end

local function CreateFeatureItem(name)
    local Item = Instance.new("Frame")
    Item.Size = UDim2.new(1, 0, 0, 38)
    Item.BackgroundColor3 = Color3.fromRGB(38, 40, 58)
    Item.Parent = Content
    Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -55, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(0.85, 0.85, 0.9)
    Label.TextSize = 11
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Item

    local ToggleBg = Instance.new("Frame")
    ToggleBg.Size = UDim2.new(0, 42, 0, 24)
    ToggleBg.Position = UDim2.new(1, -54, 0.5, -12)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(60, 62, 80)
    ToggleBg.Parent = Item
    Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 12)

    local ToggleDot = Instance.new("Frame")
    ToggleDot.Size = UDim2.new(0, 18, 0, 18)
    ToggleDot.Position = UDim2.new(0, 3, 0.5, -9)
    ToggleDot.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    ToggleDot.Parent = ToggleBg
    Instance.new("UICorner", ToggleDot).CornerRadius = UDim.new(0, 9)

    local Hit = Instance.new("TextButton")
    Hit.Size = UDim2.new(1, 0, 1, 0)
    Hit.BackgroundTransparency = 1
    Hit.Parent = Item

    local isOn = false
    Hit.MouseButton1Click:Connect(function()
        isOn = not isOn
        local targetColor = isOn and Color3.fromRGB(124, 108, 255) or Color3.fromRGB(60, 62, 80)
        local dotPos = isOn and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        TweenService:Create(ToggleBg, TweenInfo.new(0.15), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(ToggleDot, TweenInfo.new(0.15), {Position = dotPos}):Play()
    end)
end

for _, cat in ipairs(Categories) do
    CreateCategoryHeader(cat.name)
    for _, feat in ipairs(cat.items) do
        CreateFeatureItem(feat)
    end
end

local isOpen = false
local function ToggleMenu()
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
