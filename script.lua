-- Super Modern GUI for "Steal a Brainrot" (Roblox Lua)
-- Theme: Dark Futuristic / Glassmorphism

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Удаляем старую копию GUI, если она уже существует
if CoreGui:FindFirstChild("BrainrotHubGui") then
    CoreGui.BrainrotHubGui:Destroy()
end

-- Создание главного контейнера
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Закругление углов главного окна
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Тень окна
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 50, 150)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

-- Шапка окна (для перетаскивания)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 14)
TopBarCorner.Parent = TopBar

-- Исправление нижних углов шапки, чтобы они были прямыми
local FixCorner = Instance.new("Frame")
FixCorner.Size = UDim2.new(1, 0, 0, 10)
FixCorner.Position = UDim2.new(0, 0, 1, -10)
FixCorner.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
FixCorner.BorderSizePixel = 0
FixCorner.Parent = TopBar

-- Название гуи
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "STEAL A BRAINROT HUB"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Кнопка сворачивания (Minimize)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -40, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- Контейнер для элементов внутри
local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -20, 1, -60)
ContentContainer.Position = UDim2.new(0, 10, 0, 52)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 250)
ContentContainer.ScrollBarThickness = 4
ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 60, 200)
ContentContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 15)
UIListLayout.Parent = ContentContainer

-- Функция создания красивой кнопки с градиентом
local function CreateButton(name, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 50, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 120, 240))
    })
    gradient.Rotation = 45
    gradient.Parent = btn

    -- Анимация наведения
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 45)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 42)}):Play()
    end)

    return btn
end

-- Функция создания слайдера
local function CreateSlider(name, text, minVal, maxVal, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = text .. ": " .. defaultVal
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 8)
    sliderBg.Position = UDim2.new(0, 10, 0, 38)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame

    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(1, 0)
    sliderBgCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(110, 50, 220)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg

    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(1, 0)
    sliderFillCorner.Parent = sliderFill

    local sliderFillGradient = Instance.new("UIGradient")
    sliderFillGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 50, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 180, 255))
    })
    sliderFillGradient.Parent = sliderFill

    -- Логика перетаскивания слайдера
    local dragging = false

    local function updateInput(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal) * pos)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        label.Text = text .. ": " .. val
        callback(val)
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- Добавляем элементы в меню
local AutoFarmBtn = CreateButton("AutoFarmBtn", "✨ Включить Auto-Farm (Brainrot)")
local CollectBtn = CreateButton("CollectBtn", "💎 Собрать все Brainrot на карте")

-- Слайдеры скорости и прыжка
CreateSlider("SpeedSlider", "Скорость бега (WalkSpeed)", 16, 200, 16, function(val)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = val
    end
end)

CreateSlider("JumpSlider", "Сила прыжка (JumpPower)", 50, 300, 50, function(val)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.UseJumpPower = true
        char.Humanoid.JumpPower = val
    end
end)

-- Функционал кнопок (примеры действий для Steal a Brainrot)
AutoFarmBtn.MouseButton1Click:Connect(function()
    print("Auto-farm запущен!")
    AutoFarmBtn.Text = "✅ Auto-Farm Активен"
end)

CollectBtn.MouseButton1Click:Connect(function()
    print("Сбор предметов...")
    -- Сюда можно добавить логику телепортации к объектам или сбора монеток
end)

-- Логика сворачивания окна
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 420, 0, 45) or UDim2.new(0, 420, 0, 320)
    ContentContainer.Visible = not minimized
    MinimizeBtn.Text = minimized and "+" or "-"
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
end)

-- Плавное появление интерфейса при открытии
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 320)}):Play()

-- Логика перетаскивания окна (Dragging)
local dragging, dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("Brainrot Hub загружен!")
-- Простой интерфейс (GUI) для Steal a Brainrot (от Gemini)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Защита от повторного запуска скрипта
if localPlayer.PlayerGui:FindFirstChild("BrainrotHub") then
    localPlayer.PlayerGui.BrainrotHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotHub"
ScreenGui.Parent = localPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "Brainrot Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSans
    btn.Text = name
    btn.MouseButton1Click:Connect(callback)
end

createButton("Speed Boost (WalkSpeed)", 60, function()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

createButton("High Jump", 110, function()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpPower = 120
    end
end)

createButton("Reset Speed/Jump", 160, function()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = 16
        localPlayer.Character.Humanoid.JumpPower = 50
    end
end)

createButton("Close GUI", 220, function()
    ScreenGui:Destroy()
end)

print("Brainrot Hub загружен!")
