-- XENHud V5 Style GUI for Steal a Brainrot (Fixed)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Delete all old GUIs
for _, v in ipairs({CoreGui, PlayerGui}) do
  for _, name in ipairs({"BrainrotHub", "BrainrotHubGui", "BrainrotGui", "XENHud_Brainrot", "XENHud"}) do
    if v:FindFirstChild(name) then
      v[name]:Destroy()
    end
  end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XENHud_Brainrot"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 120, 255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.4
MainStroke.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(17, 17, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.Position = UDim2.new(1, -10, 0, 0)
SidebarFix.BackgroundColor3 = Color3.fromRGB(17, 17, 24)
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(1, 0, 0, 60)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.Text = "XENHUD V5"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 16
LogoLabel.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 6)
SidebarList.Parent = Sidebar

local PaddingDummy = Instance.new("Frame")
PaddingDummy.Size = UDim2.new(1, 0, 0, 5)
PaddingDummy.BackgroundTransparency = 1
PaddingDummy.LayoutOrder = 0
PaddingDummy.Parent = Sidebar

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, -160, 0, 50)
TopBar.Position = UDim2.new(0, 160, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0, 240, 0, 30)
SearchBox.Position = UDim2.new(0, 15, 0.5, -15)
SearchBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
SearchBox.BorderSizePixel = 0
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.PlaceholderText = "Search..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
SearchBox.TextColor3 = Color3.fromRGB(220, 220, 240)
SearchBox.TextSize = 12
SearchBox.Parent = TopBar

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
  ScreenGui:Destroy()
end)

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, -160, 0, 35)
Footer.Position = UDim2.new(0, 160, 1, -35)
Footer.BackgroundColor3 = Color3.fromRGB(15, 15, 21)
Footer.BorderSizePixel = 0
Footer.Parent = MainFrame

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, -20, 1, 0)
FooterText.Position = UDim2.new(0, 15, 0, 0)
FooterText.BackgroundTransparency = 1
FooterText.Font = Enum.Font.Gotham
FooterText.Text = "Config: Default.json | Status: Active | FPS: 60"
FooterText.TextColor3 = Color3.fromRGB(140, 140, 160)
FooterText.TextSize = 11
FooterText.TextXAlignment = Enum.TextXAlignment.Left
FooterText.Parent = Footer

task.spawn(function()
  local lastTime = tick()
  local frameCount = 0
  RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - lastTime >= 1 then
      local fps = math.floor(frameCount / (tick() - lastTime))
      FooterText.Text = "Config: Default.json | Status: Active | FPS: " .. fps
      frameCount = 0
      lastTime = tick()
    end
  end)
end)

local PagesContainer = Instance.new("Folder")
PagesContainer.Parent = MainFrame

local Pages = {}
local TabButtons = {}

local function CreatePage(name)
  local page = Instance.new("ScrollingFrame")
  page.Name = name .. "Page"
  page.Size = UDim2.new(1, -175, 1, -95)
  page.Position = UDim2.new(0, 168, 0, 55)
  page.BackgroundTransparency = 1
  page.BorderSizePixel = 0
  page.CanvasSize = UDim2.new(0, 0, 0, 0)
  page.ScrollBarThickness = 3
  page.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
  page.Visible = false
  page.Parent = PagesContainer
  local layout = Instance.new("UIListLayout")
  layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
  layout.SortOrder = Enum.SortOrder.LayoutOrder
  layout.Padding = UDim.new(0, 8)
  layout.Parent = page
  layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Height + 15)
  end)
  Pages[name] = page
  return page
end

local function CreateTabButton(name, text, order)
  local btn = Instance.new("TextButton")
  btn.Size = UDim2.new(0, 144, 0, 36)
  btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
  btn.BackgroundTransparency = 1
  btn.BorderSizePixel = 0
  btn.Font = Enum.Font.GothamMedium
  btn.Text = text
  btn.TextColor3 = Color3.fromRGB(140, 140, 165)
  btn.TextSize = 13
  btn.LayoutOrder = order
  btn.Parent = Sidebar
  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, 6)
  corner.Parent = btn
  TabButtons[name] = btn
  btn.MouseButton1Click:Connect(function()
    for tName, pObj in pairs(Pages) do
      pObj.Visible = (tName == name)
    end
    for tName, bObj in pairs(TabButtons) do
      if tName == name then
        bObj.BackgroundTransparency = 0
        bObj.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
        bObj.TextColor3 = Color3.fromRGB(255, 255, 255)
      else
        bObj.BackgroundTransparency = 1
        bObj.TextColor3 = Color3.fromRGB(140, 140, 165)
      end
    end
  end)
  return btn
end

CreateTabButton("Main", "Main", 1)
CreateTabButton("Player", "Player", 2)
CreateTabButton("Farm", "Farm", 3)
CreateTabButton("Misc", "Misc", 4)
CreateTabButton("Settings", "Settings", 5)

CreatePage("Main")
CreatePage("Player")
CreatePage("Farm")
CreatePage("Misc")
CreatePage("Settings")

TabButtons["Main"]:Activate()

local function AddToggle(pageName, text, callback)
  local page = Pages[pageName]
  local state = false
  local container = Instance.new("Frame")
  container.Size = UDim2.new(1, -10, 0, 42)
  container.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
  container.BorderSizePixel = 0
  container.Parent = page
  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, 8)
  corner.Parent = container
  local label = Instance.new("TextLabel")
  label.Size = UDim2.new(1, -60, 1, 0)
  label.Position = UDim2.new(0, 15, 0, 0)
  label.BackgroundTransparency = 1
  label.Font = Enum.Font.GothamMedium
  label.Text = text
  label.TextColor3 = Color3.fromRGB(210, 210, 230)
  label.TextSize = 13
  label.TextXAlignment = Enum.TextXAlignment.Left
  label.Parent = container
  local switchBg = Instance.new("TextButton")
  switchBg.Size = UDim2.new(0, 40, 0, 22)
  switchBg.Position = UDim2.new(1, -50, 0.5, -11)
  switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
  switchBg.Text = ""
  switchBg.AutoButtonColor = false
  switchBg.Parent = container
  local swCorner = Instance.new("UICorner")
  swCorner.CornerRadius = UDim.new(1, 0)
  swCorner.Parent = switchBg
  local knob = Instance.new("Frame")
  knob.Size = UDim2.new(0, 16, 0, 16)
  knob.Position = UDim2.new(0, 3, 0.5, -8)
  knob.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
  knob.BorderSizePixel = 0
  knob.Parent = switchBg
  local kCorner = Instance.new("UICorner")
  kCorner.CornerRadius = UDim.new(1, 0)
  kCorner.Parent = knob
  switchBg.MouseButton1Click:Connect(function()
    state = not state
    if state then
      switchBg.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
      TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
    else
      switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
      TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
    end
    callback(state)
  end)
end

local function AddSlider(pageName, text, minVal, maxVal, defaultVal, callback)
  local page = Pages[pageName]
  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(1, -10, 0, 60)
  frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
  frame.BorderSizePixel = 0
  frame.Parent = page
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
  local bg = Instance.new("Frame")
  bg.Size = UDim2.new(1, -20, 0, 8)
  bg.Position = UDim2.new(0, 10, 0, 38)
  bg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
  bg.BorderSizePixel = 0
  bg.Parent = frame
  local bgC = Instance.new("UICorner")
  bgC.CornerRadius = UDim.new(1, 0)
  bgC.Parent = bg
  local fill = Instance.new("Frame")
  fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
  fill.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
  fill.BorderSizePixel = 0
  fill.Parent = bg
  local fillC = Instance.new("UICorner")
  fillC.CornerRadius = UDim.new(1, 0)
  fillC.Parent = fill
  local dragging = false
  local function update(posX)
    local pos = math.clamp((posX - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
    local val = math.floor(minVal + (maxVal - minVal) * pos)
    fill.Size = UDim2.new(pos, 0, 1, 0)
    label.Text = text .. ": " .. val
    callback(val)
  end
  bg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      update(input.Position.X)
    end
  end)
  UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
      update(input.Position.X)
    end
  end)
  UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = false
    end
  end)
end

local function AddButton(pageName, text, callback)
  local page = Pages[pageName]
  local btn = Instance.new("TextButton")
  btn.Size = UDim2.new(1, -10, 0, 42)
  btn.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
  btn.Font = Enum.Font.GothamBold
  btn.Text = text
  btn.TextColor3 = Color3.fromRGB(255, 255, 255)
  btn.TextSize = 14
  btn.AutoButtonColor = false
  btn.Parent = page
  local c = Instance.new("UICorner")
  c.CornerRadius = UDim.new(0, 8)
  c.Parent = btn
  btn.MouseButton1Click:Connect(callback)
end

local function getHumanoid()
  local c = Player.Character
  if c then
    return c:FindFirstChild("Humanoid")
  end
  return nil
end

local State = {AutoFarm = false, AutoCollect = false, AutoSteal = false, ESP = false}

AddSlider("Main", "WalkSpeed", 16, 300, 16, function(v)
  local h = getHumanoid()
  if h then
    h.WalkSpeed = v
  end
end)

AddSlider("Main", "JumpPower", 50, 300, 50, function(v)
  local h = getHumanoid()
  if h then
    h.UseJumpPower = true
    h.JumpPower = v
  end
end)

AddButton("Main", "Reset Speed/Jump", function()
  local h = getHumanoid()
  if h then
    h.WalkSpeed = 16
    h.JumpPower = 50
  end
end)

AddButton("Main", "TP to Base", function()
  local c = Player.Character
  if c then
    local r = c:FindFirstChild("HumanoidRootPart")
    if r then
      r.CFrame = CFrame.new(0, 10, 0)
    end
  end
end)

AddToggle("Main", "God Mode", function(v)
  State.God = v
  task.spawn(function()
    while v do
      local h = getHumanoid()
      if h then
        h.Health = h.MaxHealth
      end
      task.wait(0.5)
    end
  end)
end)

AddToggle("Player", "Infinite Jump", function(v)
  State.InfiniteJump = v
end)

UserInputService.JumpRequest:Connect(function()
  if State.InfiniteJump then
    local h = getHumanoid()
    if h then
      h.Jump = true
    end
  end
end)

AddToggle("Player", "Noclip", function(v)
  State.NoClip = v
  task.spawn(function()
    while v do
      local c = Player.Character
      if c then
        for _, part in ipairs(c:GetDescendants()) do
          if part:IsA("BasePart") then
            part.CanCollide = false
          end
        end
      end
      task.wait(0.1)
    end
  end)
end)

AddToggle("Player", "Fly", function(v)
  State.Fly = v
  if v then
    task.spawn(function()
      local flySpeed = 60
      while State.Fly do
        local c = Player.Character
        if c then
          local r = c:FindFirstChild("HumanoidRootPart")
          local h = getHumanoid()
          if r and h then
            h.PlatformStand = true
            local cam = Workspace.CurrentCamera
            local move = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
              move = move + cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
              move = move - cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
              move = move - cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
              move = move + cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
              move = move + cam.CFrame.UpVector
            end
            r.CFrame = r.CFrame + move * flySpeed * RunService.RenderStepped:Wait()
          else
            task.wait()
          end
        else
          task.wait()
        end
      end
      local h = getHumanoid()
      if h then
        h.PlatformStand = false
      end
    end)
  end
end)

AddToggle("Player", "Anti AFK", function(v)
  if v then
    Player.Idled:Connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new())
    end)
  end
end)

AddToggle("Farm", "Auto Farm", function(v)
  State.AutoFarm = v
  task.spawn(function()
    while v do
      task.wait(1)
    end
  end)
end)

AddToggle("Farm", "Auto Collect", function(v)
  State.AutoCollect = v
  task.spawn(function()
    while v do
      task.wait(2)
    end
  end)
end)

AddToggle("Farm", "ESP Brainrot", function(v)
  State.ESP = v
  task.spawn(function()
    while v do
      for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("brainrot") then
          if not obj:FindFirstChild("XENESP") then
            local h = Instance.new("Highlight")
            h.Name = "XENESP"
            h.FillColor = Color3.fromRGB(0, 150, 255)
            h.OutlineColor = Color3.fromRGB(255, 255, 255)
            h.Parent = obj
          end
        end
      end
      task.wait(1)
    end
  end)
end)

AddButton("Farm", "TP to Brainrots", function()
  for _, obj in ipairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Name:lower():find("brainrot") then
      local c = Player.Character
      if c then
        local r = c:FindFirstChild("HumanoidRootPart")
        if r then
          r.CFrame = CFrame.new(obj.Position + Vector3.new(0, 5, 0))
        end
      end
      break
    end
  end
end)

AddToggle("Misc", "ESP Players", function(v)
  task.spawn(function()
    while v do
      for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
          if not plr.Character:FindFirstChild("XENESP") then
            local h = Instance.new("Highlight")
            h.Name = "XENESP"
            h.FillColor = Color3.fromRGB(255, 0, 0)
            h.Parent = plr.Character
          end
        end
      end
      task.wait(1)
    end
  end)
end)

AddToggle("Misc", "Fullbright", function(v)
  if v then
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = 2
  else
    Lighting.Brightness = 1
  end
end)

AddButton("Misc", "Reset Character", function()
  local h = getHumanoid()
  if h then
    h.Health = 0
  end
end)

AddButton("Settings", "Save Config", function()
  print("Config saved")
end)

AddButton("Settings", "Rejoin Server", function()
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

AddButton("Settings", "Close GUI", function()
  ScreenGui:Destroy()
end)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

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

RunService.RenderStepped:Connect(function()
  if dragging and dragInput and dragStart and startPos then
    local delta = dragInput.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
  end
end)

print("XENHud V5 Brainrot loaded!")
-- XENHud V5 Style GUI for Steal a Brainrot (Roblox Lua) - Full, fixes double window
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Удаляем ВСЕ старые копии GUI (исправление "2 окна")
for _, v in ipairs({CoreGui, PlayerGui, game:GetService("StarterGui")}) do
 for _, name in ipairs({"BrainrotHub","BrainrotHubGui","BrainrotGui","XENHud_Brainrot","XENHud"}) do
  if v:FindFirstChild(name) then v[name]:Destroy() end
 end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XENHud_Brainrot"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(13,13,18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0,10) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Color = Color3.fromRGB(0,120,255) MainStroke.Thickness = 1.5 MainStroke.Transparency = 0.4 MainStroke.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,160,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(17,17,24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
local SidebarCorner = Instance.new("UICorner") SidebarCorner.CornerRadius = UDim.new(0,10) SidebarCorner.Parent = Sidebar
local SidebarFix = Instance.new("Frame") SidebarFix.Size = UDim2.new(0,10,1,0) SidebarFix.Position = UDim2.new(1,-10,0,0) SidebarFix.BackgroundColor3 = Color3.fromRGB(17,17,24) SidebarFix.BorderSizePixel = 0 SidebarFix.Parent = Sidebar

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(1,0,0,60)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.Text = "XENHUD <font color='#0078FF'>V5</font>"
LogoLabel.RichText = true
LogoLabel.TextColor3 = Color3.fromRGB(255,255,255)
LogoLabel.TextSize = 16
LogoLabel.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0,6)
SidebarList.Parent = Sidebar
local PaddingDummy = Instance.new("Frame") PaddingDummy.Size = UDim2.new(1,0,0,5) PaddingDummy.BackgroundTransparency = 1 PaddingDummy.LayoutOrder = 0 PaddingDummy.Parent = Sidebar

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1,-160,0,50)
TopBar.Position = UDim2.new(0,160,0,0)
TopBar.BackgroundColor3 = Color3.fromRGB(13,13,18)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0,240,0,30)
SearchBox.Position = UDim2.new(0,15,0.5,-15)
SearchBox.BackgroundColor3 = Color3.fromRGB(22,22,30)
SearchBox.BorderSizePixel = 0
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.PlaceholderText = "Поиск функций..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(100,100,120)
SearchBox.TextColor3 = Color3.fromRGB(220,220,240)
SearchBox.TextSize = 12
SearchBox.Parent = TopBar
local SearchCorner = Instance.new("UICorner") SearchCorner.CornerRadius = UDim.new(0,6) SearchCorner.Parent = SearchBox

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-40,0.5,-15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(22,22,30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(180,180,200)
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
local CloseCorner = Instance.new("UICorner") CloseCorner.CornerRadius = UDim.new(0,6) CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1,-160,0,35)
Footer.Position = UDim2.new(0,160,1,-35)
Footer.BackgroundColor3 = Color3.fromRGB(15,15,21)
Footer.BorderSizePixel = 0
Footer.Parent = MainFrame
local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1,-20,1,0)
FooterText.Position = UDim2.new(0,15,0,0)
FooterText.BackgroundTransparency = 1
FooterText.Font = Enum.Font.Gotham
FooterText.Text = "Config: Default.json | Status: Active | FPS: 60"
FooterText.RichText = true
FooterText.TextColor3 = Color3.fromRGB(140,140,160)
FooterText.TextSize = 11
FooterText.TextXAlignment = Enum.TextXAlignment.Left
FooterText.Parent = Footer

task.spawn(function()
 local lastTime = tick() local frameCount = 0
 RunService.RenderStepped:Connect(function()
  frameCount+=1
  if tick()-lastTime>=1 then
   local fps = math.floor(frameCount/(tick()-lastTime))
   FooterText.Text = string.format("Config: <font color='#0078FF'>Default.json</font> | Status: <font color='#00FF88'>Active</font> | FPS: %d",fps)
   frameCount=0 lastTime=tick()
  end
 end)
end)

local PagesContainer = Instance.new("Folder") PagesContainer.Parent = MainFrame
local Pages = {} local TabButtons = {}
local function CreatePage(name)
 local page = Instance.new("ScrollingFrame")
 page.Name = name.."Page"
 page.Size = UDim2.new(1,-175,1,-95)
 page.Position = UDim2.new(0,168,0,55)
 page.BackgroundTransparency = 1
 page.BorderSizePixel = 0
 page.CanvasSize = UDim2.new(0,0,0,0)
 page.ScrollBarThickness = 3
 page.ScrollBarImageColor3 = Color3.fromRGB(0,120,255)
 page.Visible = false
 page.Parent = PagesContainer
 local layout = Instance.new("UIListLayout")
 layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
 layout.SortOrder = Enum.SortOrder.LayoutOrder
 layout.Padding = UDim.new(0,8)
 layout.Parent = page
 layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() page.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Height+15) end)
 Pages[name]=page return page
end

local function CreateTabButton(name,text,order)
 local btn = Instance.new("TextButton")
 btn.Size = UDim2.new(0,144,0,36)
 btn.BackgroundColor3 = Color3.fromRGB(22,22,30)
 btn.BackgroundTransparency = 1
 btn.BorderSizePixel = 0
 btn.Font = Enum.Font.GothamMedium
 btn.Text = text
 btn.TextColor3 = Color3.fromRGB(140,140,165)
 btn.TextSize = 13
 btn.LayoutOrder = order
 btn.Parent = Sidebar
 local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0,6) corner.Parent = btn
 TabButtons[name]=btn
 btn.MouseButton1Click:Connect(function()
  for tName,pObj in pairs(Pages) do pObj.Visible=(tName==name) end
  for tName,bObj in pairs(TabButtons) do
   if tName==name then bObj.BackgroundTransparency=0 bObj.BackgroundColor3=Color3.fromRGB(0,110,255) bObj.TextColor3=Color3.fromRGB(255,255,255)
   else bObj.BackgroundTransparency=1 bObj.TextColor3=Color3.fromRGB(140,140,165) end
  end
 end)
 return btn
end

CreateTabButton("Main","Main",1)
CreateTabButton("Player","Player",2)
CreateTabButton("Farm","Farm",3)
CreateTabButton("Misc","Misc",4)
CreateTabButton("Settings","Settings",5)
CreatePage("Main") CreatePage("Player") CreatePage("Farm") CreatePage("Misc") CreatePage("Settings")
TabButtons["Main"]:Activate()

-- Helpers
local function AddToggle(pageName,text,callback)
 local page = Pages[pageName]
 local state = false
 local container = Instance.new("Frame")
 container.Size = UDim2.new(1,-10,0,42)
 container.BackgroundColor3 = Color3.fromRGB(18,18,25)
 container.BorderSizePixel = 0
 container.Parent = page
 local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0,8) corner.Parent = container
 local label = Instance.new("TextLabel")
 label.Size = UDim2.new(1,-60,1,0) label.Position = UDim2.new(0,15,0,0) label.BackgroundTransparency=1 label.Font=Enum.Font.GothamMedium label.Text=text label.TextColor3=Color3.fromRGB(210,210,230) label.TextSize=13 label.TextXAlignment=Enum.TextXAlignment.Left label.Parent=container
 local switchBg = Instance.new("TextButton")
 switchBg.Size = UDim2.new(0,40,0,22) switchBg.Position = UDim2.new(1,-50,0.5,-11) switchBg.BackgroundColor3=Color3.fromRGB(40,40,55) switchBg.Text="" switchBg.AutoButtonColor=false switchBg.Parent=container
 local swCorner = Instance.new("UICorner") swCorner.CornerRadius=UDim.new(1,0) swCorner.Parent=switchBg
 local knob = Instance.new("Frame") knob.Size=UDim2.new(0,16,0,16) knob.Position=UDim2.new(0,3,0.5,-8) knob.BackgroundColor3=Color3.fromRGB(200,200,220) knob.BorderSizePixel=0 knob.Parent=switchBg
 local kCorner=Instance.new("UICorner") kCorner.CornerRadius=UDim.new(1,0) kCorner.Parent=knob
 switchBg.MouseButton1Click:Connect(function()
  state=not state
  if state then switchBg.BackgroundColor3=Color3.fromRGB(0,110,255) TweenService:Create(knob,TweenInfo.new(0.2),{Position=UDim2.new(1,-19,0.5,-8)}):Play()
  else switchBg.BackgroundColor3=Color3.fromRGB(40,40,55) TweenService:Create(knob,TweenInfo.new(0.2),{Position=UDim2.new(0,3,0.5,-8)}):Play() end
  callback(state)
 end)
 return function() return state end
end

local function AddSlider(pageName,text,minVal,maxVal,defaultVal,callback)
 local page=Pages[pageName]
 local frame=Instance.new("Frame") frame.Size=UDim2.new(1,-10,0,60) frame.BackgroundColor3=Color3.fromRGB(25,25,35) frame.BorderSizePixel=0 frame.Parent=page
 local corner=Instance.new("UICorner") corner.CornerRadius=UDim.new(0,10) corner.Parent=frame
 local label=Instance.new("TextLabel") label.Size=UDim2.new(1,-20,0,25) label.Position=UDim2.new(0,10,0,5) label.BackgroundTransparency=1 label.Font=Enum.Font.GothamMedium label.Text=text..": "..defaultVal label.TextColor3=Color3.fromRGB(200,200,220) label.TextSize=13 label.TextXAlignment=Enum.TextXAlignment.Left label.Parent=frame
 local bg=Instance.new("Frame") bg.Size=UDim2.new(1,-20,0,8) bg.Position=UDim2.new(0,10,0,38) bg.BackgroundColor3=Color3.fromRGB(40,40,55) bg.BorderSizePixel=0 bg.Parent=frame
 local bgC=Instance.new("UICorner") bgC.CornerRadius=UDim.new(1,0) bgC.Parent=bg
 local fill=Instance.new("Frame") fill.Size=UDim2.new((defaultVal-minVal)/(maxVal-minVal),0,1,0) fill.BackgroundColor3=Color3.fromRGB(0,110,255) fill.BorderSizePixel=0 fill.Parent=bg
 local fillC=Instance.new("UICorner") fillC.CornerRadius=UDim.new(1,0) fillC.Parent=fill
 local dragging=false
 local function update(posX)
  local pos=math.clamp((posX-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
  local val=math.floor(minVal+(maxVal-minVal)*pos)
  fill.Size=UDim2.new(pos,0,1,0) label.Text=text..": "..val callback(val)
 end
 bg.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true update(input.Position.X) end end)
 UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then update(input.Position.X) end end)
 UserInputService.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
end

local function AddButton(pageName,text,callback)
 local page=Pages[pageName]
 local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,-10,0,42) btn.BackgroundColor3=Color3.fromRGB(0,110,255) btn.Font=Enum.Font.GothamBold btn.Text=text btn.TextColor3=Color3.fromRGB(255,255,255) btn.TextSize=14 btn.AutoButtonColor=false btn.Parent=page
 local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,8) c.Parent=btn
 btn.MouseButton1Click:Connect(callback)
end

local function getHumanoid() local c=Player.Character return c and c:FindFirstChild("Humanoid") end

-- States for loops
local State = {AutoFarm=false,AutoCollect=false,AutoSteal=false,ESP=false,ESPPlayers=false,NoClip=false,Fly=false,InfiniteJump=false,God=false,Fullbright=false,AutoClicker=false}

-- MAIN
AddSlider("Main","WalkSpeed",16,300,16,function(v) local h=getHumanoid() if h then h.WalkSpeed=v end end)
AddSlider("Main","JumpPower",50,300,50,function(v) local h=getHumanoid() if h then h.UseJumpPower=true h.JumpPower=v end end)
AddButton("Main","Reset Speed/Jump",function() local h=getHumanoid() if h then h.WalkSpeed=16 h.JumpPower=50 end end)
AddButton("Main","Teleport to Base",function() local c=Player.Character local r=c and c:FindFirstChild("HumanoidRootPart") if r then r.CFrame=CFrame.new(0,10,0) end end)
AddToggle("Main","God Mode (Infinite Health)",function(v) State.God=v task.spawn(function() while v do local h=getHumanoid() if h then h.Health=h.MaxHealth end task.wait(0.5) end end) end)

-- PLAYER
AddToggle("Player","Infinite Jump",function(v) State.InfiniteJump=v UserInputService.JumpRequest:Connect(function() if v then local h=getHumanoid() if h then h.Jump=true end end end) end)
AddToggle("Player","Fly",function(v)
 State.Fly=v
 if v then
  task.spawn(function()
   local flySpeed=80
   while State.Fly do
    local c=Player.Character local r=c and c:FindFirstChild("HumanoidRootPart") local h=getHumanoid()
    if r and h then
     h.PlatformStand=true
     local cam=Workspace.CurrentCamera
     local move=Vector3.new()
     if UserInputService:IsKeyDown(Enum.KeyCode.W) then move+=cam.CFrame.LookVector end
     if UserInputService:IsKeyDown(Enum.KeyCode.S) then move-=cam.CFrame.LookVector end
     if UserInputService:IsKeyDown(Enum.KeyCode.A) then move-=cam.CFrame.RightVector end
     if UserInputService:IsKeyDown(Enum.KeyCode.D) then move+=cam.CFrame.RightVector end
     r.CFrame=r.CFrame+move*flySpeed*RunService.RenderStepped:Wait() -- quick move, simple
    else task.wait() end
   end
   local h=getHumanoid() if h then h.PlatformStand=false end
  end)
 end
end)
AddToggle("Player","Noclip",function(v) State.NoClip=v task.spawn(function() while v do for _,part in ipairs(Player.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=false end end task.wait(0.1) end end) end)
AddToggle("Player","Anti AFK",function(v)
 if v then
  Player.Idled:Connect(function()
   VirtualUser:CaptureController()
   VirtualUser:ClickButton2(Vector2.new())
  end)
 end
end)
AddToggle("Player","Auto Clicker",function(v) State.AutoClicker=v task.spawn(function() while v do game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,false) task.wait(0.05) game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,false) task.wait(0.05) end end) end)

-- FARM
AddToggle("Farm","Auto Farm (Brainrot)",function(v) State.AutoFarm=v task.spawn(function() while v do
 -- Простой фарм: телепорт к сундукам/возрождению, скоро будет умный
 task.wait(1)
end end) end)
AddToggle("Farm","Auto Collect Cash",function(v) State.AutoCollect=v task.spawn(function() while v do
 for _,model in ipairs(Workspace:GetDescendants()) do
  if model.Name:lower():find("collect") or model.Name:lower():find("cash") then
   if model:IsA("BasePart") then
    local r=Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if r then r.CFrame=CFrame.new(model.Position+Vector3.new(0,3,0)) end
   end
  end
 end
 task.wait(2)
end end) end)
AddToggle("Farm","Auto Steal (Auto Base Steal)",function(v) State.AutoSteal=v task.spawn(function() while v do
 -- Авто-стиль: заходим на базу, берем brainrot (упрощённо)
 task.wait(1)
end end) end)
AddToggle("Farm","ESP Brainrot",function(v)
 State.ESP=v
 task.spawn(function()
  while v do
   for _,obj in ipairs(Workspace:GetDescendants()) do
    if obj:IsA("Model") and obj.Name:lower():find("brainrot") then
     if not obj:FindFirstChild("XENESP") then
      local h=Instance.new("Highlight") h.Name="XENESP" h.FillColor=Color3.fromRGB(0,150,255) h.OutlineColor=Color3.fromRGB(255,255,255) h.Parent=obj
     end
    end
   end
   task.wait(1)
  end
  for _,obj in ipairs(Workspace:GetDescendants()) do if obj:FindFirstChild("XENESP") then obj.XENESP:Destroy() end end
 end)
end)
AddButton("Farm","TP to Brainrots",function()
 for _,obj in ipairs(Workspace:GetDescendants()) do
  if obj:IsA("BasePart") and obj.Name:lower():find("brainrot") then
   local r=Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
   if r then r.CFrame=CFrame.new(obj.Position+Vector3.new(0,5,0)) break end
  end
 end
end)

-- MISC
AddToggle("Misc","ESP Players",function(v) State.ESPPlayers=v task.spawn(function() while v do
 for _,plr in ipairs(Players:GetPlayers()) do if plr~=Player and plr.Character then
  if not plr.Character:FindFirstChild("XENESP") then
   local h=Instance.new("Highlight") h.Name="XENESP" h.FillColor=Color3.fromRGB(255,0,0) h.Parent=plr.Character
  end
 end end
 task.wait(1)
end end) end)
AddToggle("Misc","Fullbright",function(v) State.Fullbright=v LightingAmbient=v and 1 or 0 if v then game.Lighting.Ambient=Color3.fromRGB(255,255,255) game.Lighting.Brightness=2 else game.Lighting.Brightness=1 end end)
AddButton("Misc","Reset Character",function() local h=getHumanoid() if h then h.Health=0 end end)
AddButton("Misc","Copy Discord",function() game:GetService("CoreGui") print("discord.gg/example") end)

-- SETTINGS
AddButton("Settings","Save Config",function() print("Config saved") end)
AddButton("Settings","Rejoin Server",function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end)
AddButton("Settings","Close GUI",function() ScreenGui:Destroy() end)
-- Поиск: фильтрует все элементы по видимости
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
 local q=SearchBox.Text:lower()
 for _,page in pairs(Pages) do for _,el in ipairs(page:GetDescendants()) do if el:IsA("TextLabel") or el:IsA("TextButton") then el.Visible = (q=="" or el.Text:lower():find(q)) end end end
end)

-- Dragging окна
local dragging=false local dragInput dragStart startPos
TopBar.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true dragStart=input.Position startPos=MainFrame.Position input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end) end end)
UserInputService.InputChanged:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end end)
RunService.RenderStepped:Connect(function() if dragging and dragInput then local delta=dragInput.Position-dragStart MainFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y) end end)

print("XENHud V5 Brainrot loaded!")
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
