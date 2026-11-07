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
