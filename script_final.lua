-- ============================================================
--  BRAINROT HUB | Steal a Brainrot (Claude Edition)
--  Одно окно, боковая панель: Main / Player / Farm / Visuals / Settings
--  Меню скрывается и показывается клавишей RightShift
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")

local LP = Players.LocalPlayer

local T = {
	bg = Color3.fromRGB(18, 18, 23),
	side = Color3.fromRGB(13, 13, 17),
	top = Color3.fromRGB(13, 13, 17),
	element = Color3.fromRGB(27, 27, 34),
	elementHover = Color3.fromRGB(35, 35, 44),
	accent = Color3.fromRGB(56, 132, 255),
	accentDim = Color3.fromRGB(30, 56, 105),
	off = Color3.fromRGB(48, 48, 58),
	text = Color3.fromRGB(235, 235, 240),
	textDim = Color3.fromRGB(150, 150, 165),
	track = Color3.fromRGB(45, 45, 56),
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do
		o[k] = v
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function corner(o, r)
	return new("UICorner", { CornerRadius = UDim.new(0, r or 6) }, o)
end

local function getGuiParent()
	local ok, res = pcall(function()
		if gethui then
			return gethui()
		end
		return nil
	end)
	if ok and res then
		return res
	end
	local ok2 = pcall(function()
		local t = Instance.new("Folder")
		t.Parent = CoreGui
		t:Destroy()
	end)
	if ok2 then
		return CoreGui
	end
	return LP:WaitForChild("PlayerGui")
end

local GUI_NAME = "BrainrotHub_UI"
local guiParent = getGuiParent()
pcall(function()
	local old = guiParent:FindFirstChild(GUI_NAME)
	if old then
		old:Destroy()
	end
end)

-- удалить старые окна
for _, v in ipairs({CoreGui, LP:WaitForChild("PlayerGui")}) do
	for _, name in ipairs({"BrainrotHub","BrainrotHubGui","XENHud_Brainrot","XENHud"}) do
		if v:FindFirstChild(name) then v[name]:Destroy() end
	end
end

local S = {
	alive = true,
	walkSpeed = nil,
	jumpPower = nil,
	god = false,
	infJump = false,
	fly = false,
	flySpeed = 60,
	noclip = false,
	antiAfk = false,
	autoFarm = false,
	autoCollect = false,
	collectRange = 40,
	farmDelay = 2,
	espBrainrot = false,
	espPlayers = false,
	fullbright = false,
	basePos = nil,
	keywords = {
		"brainrot", "sahur", "tralalero", "bombardiro", "lirili", "cappuccino",
		"assassino", "chimpanzini", "frigo", "camelo", "glorbo", "orcalero",
		"bombombini", "burbaloni",
	},
}

local conns = {}
local function bind(signal, fn)
	local c = signal:Connect(fn)
	table.insert(conns, c)
	return c
end

local function getChar()
	return LP.Character
end
local function getHum()
	local c = LP.Character
	return c and c:FindFirstChildOfClass("Humanoid")
end
local function getRoot()
	local c = LP.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end

local gui = new("ScreenGui", {
	Name = GUI_NAME,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 999,
	IgnoreGuiInset = true,
}, guiParent)

local main = new("Frame", {
	Name = "Main",
	Size = UDim2.new(0, 660, 0, 420),
	Position = UDim2.new(0.5, -330, 0.5, -210),
	BackgroundColor3 = T.bg,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, gui)
corner(main, 10)
new("UIStroke", { Color = Color3.fromRGB(40, 40, 52), Thickness = 1 }, main)

local topbar = new("Frame", {
	Name = "Top",
	Size = UDim2.new(1, 0, 0, 40),
	BackgroundColor3 = T.top,
	BorderSizePixel = 0,
}, main)

new("TextLabel", {
	Text = "BRAINROT",
	Font = Enum.Font.GothamBlack,
	TextSize = 16,
	TextColor3 = T.text,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 14, 0, 0),
	Size = UDim2.new(0, 80, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Left,
}, topbar)

new("TextLabel", {
	Text = "HUB",
	Font = Enum.Font.GothamBlack,
	TextSize = 16,
	TextColor3 = T.accent,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 92, 0, 0),
	Size = UDim2.new(0, 50, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Left,
}, topbar)

local searchFrame = new("Frame", {
	Size = UDim2.new(0, 230, 0, 26),
	Position = UDim2.new(0.5, -90, 0.5, -13),
	BackgroundColor3 = T.element,
	BorderSizePixel = 0,
}, topbar)
corner(searchFrame, 6)

new("TextLabel", {
	Text = "Search",
	Font = Enum.Font.GothamMedium,
	TextSize = 11,
	TextColor3 = T.accent,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 8, 0, 0),
	Size = UDim2.new(0, 40, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Left,
}, searchFrame)

local searchBox = new("TextBox", {
	Text = "",
	PlaceholderText = "type a function name...",
	PlaceholderColor3 = T.textDim,
	Font = Enum.Font.Gotham,
	TextSize = 13,
	TextColor3 = T.text,
	BackgroundTransparency = 1,
	ClearTextOnFocus = false,
	Position = UDim2.new(0, 52, 0, 0),
	Size = UDim2.new(1, -60, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Left,
}, searchFrame)

local closeBtn = new("TextButton", {
	Text = "X",
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	TextColor3 = T.text,
	BackgroundColor3 = T.element,
	BorderSizePixel = 0,
	AutoButtonColor = false,
	Size = UDim2.new(0, 28, 0, 26),
	Position = UDim2.new(1, -38, 0.5, -13),
}, topbar)
corner(closeBtn, 6)

local miniBtn = new("TextButton", {
	Text = "-",
	Font = Enum.Font.GothamBold,
	TextSize = 18,
	TextColor3 = T.text,
	BackgroundColor3 = T.element,
	BorderSizePixel = 0,
	AutoButtonColor = false,
	Size = UDim2.new(0, 28, 0, 26),
	Position = UDim2.new(1, -72, 0.5, -13),
}, topbar)
corner(miniBtn, 6)

local sidebar = new("Frame", {
	Name = "Sidebar",
	Size = UDim2.new(0, 140, 1, -66),
	Position = UDim2.new(0, 0, 0, 40),
	BackgroundColor3 = T.side,
	BorderSizePixel = 0,
}, main)
new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, sidebar)
new("UIPadding", { PaddingTop = UDim.new(0, 10), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, sidebar)

local content = new("Frame", {
	Name = "Content",
	Size = UDim2.new(1, -140, 1, -66),
	Position = UDim2.new(0, 140, 0, 40),
	BackgroundColor3 = T.bg,
	BorderSizePixel = 0,
}, main)

local bottom = new("Frame", {
	Name = "Bottom",
	Size = UDim2.new(1, 0, 0, 26),
	Position = UDim2.new(0, 0, 1, -26),
	BackgroundColor3 = T.top,
	BorderSizePixel = 0,
}, main)

local fpsLabel = new("TextLabel", {
	Text = "FPS: --",
	Font = Enum.Font.GothamMedium,
	TextSize = 12,
	TextColor3 = T.accent,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 12, 0, 0),
	Size = UDim2.new(0, 170, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Left,
}, bottom)

local statusLabel = new("TextLabel", {
	Text = "Ready",
	Font = Enum.Font.Gotham,
	TextSize = 12,
	TextColor3 = T.textDim,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 190, 0, 0),
	Size = UDim2.new(1, -400, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Center,
}, bottom)

new("TextLabel", {
	Text = "RightShift - hide/show",
	Font = Enum.Font.Gotham,
	TextSize = 12,
	TextColor3 = T.textDim,
	BackgroundTransparency = 1,
	Position = UDim2.new(1, -200, 0, 0),
	Size = UDim2.new(0, 190, 1, 0),
	TextXAlignment = Enum.TextXAlignment.Right,
}, bottom)

local statusToken = 0
local function notify(text)
	statusToken = statusToken + 1
	local my = statusToken
	statusLabel.Text = text
	task.delay(3, function()
		if statusToken == my and statusLabel.Parent then
			statusLabel.Text = "Ready"
		end
	end)
end

local dragging = false
local dragStart = nil
local startPos = nil
topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)
bind(UIS.InputChanged, function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local d = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
	end
end)
bind(UIS.InputEnded, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local pages = {}
local tabButtons = {}
local currentTab = "Main"
local rows = {}
local rowCounter = 0

local function makePage(name)
	local p = new("ScrollingFrame", {
		Name = name,
		Size = UDim2.new(1, -16, 1, -16),
		Position = UDim2.new(0, 8, 0, 8),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = T.accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
	}, content)
	new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, p)
	pages[name] = p
	return p
end

local searchPage = makePage("SearchResults")

local function addRow(page, name, height)
	rowCounter = rowCounter + 1
	local f = new("Frame", {
		Size = UDim2.new(1, -6, 0, height or 36),
		BackgroundColor3 = T.element,
		BorderSizePixel = 0,
		LayoutOrder = rowCounter,
	}, page)
	corner(f, 6)
	table.insert(rows, { frame = f, page = page, name = string.lower(name) })
	return f
end

local function section(page, text)
	rowCounter = rowCounter + 1
	new("TextLabel", {
		Text = string.upper(text),
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = T.accent,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -6, 0, 20),
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = rowCounter,
	}, page)
end

local function infoLabel(page, text)
	rowCounter = rowCounter + 1
	new("TextLabel", {
		Text = text,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = T.textDim,
		BackgroundTransparency = 1,
		TextWrapped = true,
		Size = UDim2.new(1, -6, 0, 34),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		LayoutOrder = rowCounter,
	}, page)
end

local function makeToggle(page, name, default, cb)
	local f = addRow(page, name, 36)
	new("TextLabel", {
		Text = name,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextColor3 = T.text,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(1, -90, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, f)
	local sw = new("TextButton", {
		Text = "OFF",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = T.text,
		BackgroundColor3 = T.off,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Size = UDim2.new(0, 56, 0, 22),
		Position = UDim2.new(1, -68, 0.5, -11),
	}, f)
	corner(sw, 6)
	local state = default
	local function set(v, silent)
		state = v
		if v then
			sw.Text = "ON"
			TweenService:Create(sw, TweenInfo.new(0.15), { BackgroundColor3 = T.accent }):Play()
		else
			sw.Text = "OFF"
			TweenService:Create(sw, TweenInfo.new(0.15), { BackgroundColor3 = T.off }):Play()
		end
		if not silent then
			cb(v)
		end
	end
	sw.MouseButton1Click:Connect(function()
		set(not state, false)
	end)
	set(default, true)
	return set
end

local function makeSlider(page, name, min, max, default, cb)
	local f = addRow(page, name, 54)
	local lbl = new("TextLabel", {
		Text = name .. ": " .. tostring(default),
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextColor3 = T.text,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 5),
		Size = UDim2.new(1, -24, 0, 18),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, f)
	local hit = new("TextButton", {
		Text = "",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 26),
		Size = UDim2.new(1, -24, 0, 22),
	}, f)
	local track = new("Frame", {
		Size = UDim2.new(1, 0, 0, 6),
		Position = UDim2.new(0, 0, 0.5, -3),
		BackgroundColor3 = T.track,
		BorderSizePixel = 0,
	}, hit)
	corner(track, 3)
	local fill = new("Frame", {
		Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = T.accent,
		BorderSizePixel = 0,
	}, track)
	corner(fill, 3)
	local function apply(val, silent)
		local rel = math.clamp((val - min) / (max - min), 0, 1)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		lbl.Text = name .. ": " .. tostring(val)
		if not silent then
			cb(val)
		end
	end
	local sliding = false
	local function fromX(x)
		local w = track.AbsoluteSize.X
		if w <= 0 then
			return
		end
		local rel = math.clamp((x - track.AbsolutePosition.X) / w, 0, 1)
		local val = math.floor(min + (max - min) * rel + 0.5)
		apply(val, false)
	end
	hit.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliding = true
			fromX(input.Position.X)
		end
	end)
	bind(UIS.InputChanged, function(input)
		if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			fromX(input.Position.X)
		end
	end)
	bind(UIS.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliding = false
		end
	end)
	return apply
end

local function makeButton(page, name, cb)
	local f = addRow(page, name, 36)
	f.BackgroundColor3 = T.accentDim
	local b = new("TextButton", {
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = T.text,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Size = UDim2.new(1, 0, 1, 0),
	}, f)
	b.MouseEnter:Connect(function()
		TweenService:Create(f, TweenInfo.new(0.12), { BackgroundColor3 = T.accent }):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(f, TweenInfo.new(0.12), { BackgroundColor3 = T.accentDim }):Play()
	end)
	b.MouseButton1Click:Connect(cb)
end

local function makeInput(page, name, placeholder, cb)
	local f = addRow(page, name, 36)
	new("TextLabel", {
		Text = name,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextColor3 = T.text,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(0.5, -12, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, f)
	local boxFrame = new("Frame", {
		Size = UDim2.new(0.5, -20, 0, 24),
		Position = UDim2.new(0.5, 8, 0.5, -12),
		BackgroundColor3 = T.bg,
		BorderSizePixel = 0,
	}, f)
	corner(boxFrame, 5)
	local box = new("TextBox", {
		Text = "",
		PlaceholderText = placeholder,
		PlaceholderColor3 = T.textDim,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = T.text,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		Size = UDim2.new(1, -12, 1, 0),
		Position = UDim2.new(0, 6, 0, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, boxFrame)
	box.FocusLost:Connect(function(enter)
		if enter and box.Text ~= "" then
			cb(box.Text)
			box.Text = ""
		end
	end)
end

local tabNames = { "Main", "Player", "Farm", "Visuals", "Settings" }

local function showTab(name)
	for n, p in pairs(pages) do
		if n ~= "SearchResults" then
			p.Visible = (n == name)
		end
	end
	for n, b in pairs(tabButtons) do
		local active = (n == name)
		b.btn.BackgroundColor3 = active and T.element or T.side
		b.btn.TextColor3 = active and T.text or T.textDim
		b.bar.Visible = active
	end
end

for i, name in ipairs(tabNames) do
	makePage(name)
	local btn = new("TextButton", {
		Text = name,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextColor3 = T.textDim,
		BackgroundColor3 = T.side,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Size = UDim2.new(1, 0, 0, 34),
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = i,
	}, sidebar)
	corner(btn, 6)
	new("UIPadding", { PaddingLeft = UDim.new(0, 16) }, btn)
	local bar = new("Frame", {
		Size = UDim2.new(0, 3, 0, 18),
		Position = UDim2.new(0, -12, 0.5, -9),
		BackgroundColor3 = T.accent,
		BorderSizePixel = 0,
		Visible = false,
	}, btn)
	corner(bar, 2)
	tabButtons[name] = { btn = btn, bar = bar }
	btn.MouseButton1Click:Connect(function()
		currentTab = name
		searchBox.Text = ""
		showTab(name)
	end)
end

local function applySearch()
	local q = string.lower(searchBox.Text)
	if q == "" then
		for _, r in ipairs(rows) do
			r.frame.Parent = r.page
		end
		searchPage.Visible = false
		showTab(currentTab)
	else
		for n, p in pairs(pages) do
			if n ~= "SearchResults" then
				p.Visible = false
			end
		end
		searchPage.Visible = true
		for _, r in ipairs(rows) do
			if string.find(r.name, q, 1, true) then
				r.frame.Parent = searchPage
			else
				r.frame.Parent = r.page
			end
		end
	end
end
searchBox:GetPropertyChangedSignal("Text"):Connect(applySearch)

bind(RunService.Heartbeat, function()
	local h = getHum()
	if not h then
		return
	end
	if S.walkSpeed then
		h.WalkSpeed = S.walkSpeed
	end
	if S.jumpPower then
		h.UseJumpPower = true
		h.JumpPower = S.jumpPower
	end
end)

local godConn = nil
local function hookGod()
	if godConn then
		godConn:Disconnect()
		godConn = nil
	end
	local ch = getChar()
	local h = getHum()
	if ch then
		local ff = ch:FindFirstChild("BH_FF")
		if ff then
			ff:Destroy()
		end
	end
	if not S.god or not h then
		return
	end
	new("ForceField", { Name = "BH_FF", Visible = false }, ch)
	h.Health = h.MaxHealth
	godConn = h.HealthChanged:Connect(function()
		if S.god and h.Health > 0 and h.Health < h.MaxHealth then
			h.Health = h.MaxHealth
		end
	end)
end

bind(UIS.JumpRequest, function()
	if S.infJump then
		local h = getHum()
		if h then
			h:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

local flyBV, flyBG, flyConn = nil, nil, nil
local function stopFly()
	if flyConn then
		flyConn:Disconnect()
		flyConn = nil
	end
	if flyBV then
		flyBV:Destroy()
		flyBV = nil
	end
	if flyBG then
		flyBG:Destroy()
		flyBG = nil
	end
	local h = getHum()
	if h then
		h.PlatformStand = false
	end
end

local function startFly()
	stopFly()
	local root = getRoot()
	local h = getHum()
	if not root or not h then
		return
	end
	flyBV = new("BodyVelocity", {
		MaxForce = Vector3.new(1e9, 1e9, 1e9),
		Velocity = Vector3.new(0, 0, 0),
	}, root)
	flyBG = new("BodyGyro", {
		MaxTorque = Vector3.new(1e9, 1e9, 1e9),
		P = 90000,
		CFrame = root.CFrame,
	}, root)
	h.PlatformStand = true
	flyConn = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		if not cam or not flyBV or not flyBG then
			return
		end
		local dir = Vector3.new(0, 0, 0)
		if UIS:IsKeyDown(Enum.KeyCode.W) then
			dir = dir + cam.CFrame.LookVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.S) then
			dir = dir - cam.CFrame.LookVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.D) then
			dir = dir + cam.CFrame.RightVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.A) then
			dir = dir - cam.CFrame.RightVector
		end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			dir = dir + Vector3.new(0, 1, 0)
		end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
			dir = dir - Vector3.new(0, 1, 0)
		end
		if dir.Magnitude > 0 then
			flyBV.Velocity = dir.Unit * S.flySpeed
		else
			flyBV.Velocity = Vector3.new(0, 0, 0)
		end
		flyBG.CFrame = cam.CFrame
	end)
end

bind(RunService.Stepped, function()
	if S.noclip then
		local ch = getChar()
		if ch then
			for _, p in ipairs(ch:GetDescendants()) do
				if p:IsA("BasePart") and p.CanCollide then
					p.CanCollide = false
				end
			end
		end
	end
end)

bind(LP.Idled, function()
	if S.antiAfk then
		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new(0, 0))
		end)
	end
end)

bind(LP.CharacterAdded, function()
	task.wait(0.6)
	hookGod()
	if S.fly then
		startFly()
	end
end)

local function pivotOf(inst)
	if inst:IsA("Model") then
		return inst:GetPivot().Position
	end
	if inst:IsA("BasePart") then
		return inst.Position
	end
	local bp = inst:FindFirstChildWhichIsA("BasePart", true)
	if bp then
		return bp.Position
	end
	return nil
end

local function ownedByMe(v)
	if v == nil then
		return false
	end
	return v == LP.Name or v == LP.DisplayName or v == LP.UserId or v == LP
end

local function findBase()
	if S.basePos then
		return S.basePos
	end
	local attrKeys = { "Owner", "OwnerName", "OwnerId", "OwnerUserId", "UserId", "Player" }
	for _, d in ipairs(workspace:GetDescendants()) do
		if d:IsA("StringValue") or d:IsA("ObjectValue") or d:IsA("IntValue") then
			local n = string.lower(d.Name)
			if string.find(n, "owner", 1, true) and ownedByMe(d.Value) and d.Parent then
				local pos = pivotOf(d.Parent)
				if pos then
					return pos
				end
			end
		elseif d:IsA("Model") or d:IsA("Folder") then
			for _, key in ipairs(attrKeys) do
				if ownedByMe(d:GetAttribute(key)) then
					local pos = pivotOf(d)
					if pos then
						return pos
					end
				end
			end
		end
	end
	return nil
end

local function tpToBase()
	local root = getRoot()
	if not root then
		notify("Character not found")
		return false
	end
	local ok, pos = pcall(findBase)
	if ok and pos then
		root.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
		notify("Teleported to base")
		return true
	end
	notify("Base not found - use Set Base Here")
	return false
end

local promptCache = {}
local function refreshPrompts()
	local list = {}
	for _, d in ipairs(workspace:GetDescendants()) do
		if d:IsA("ProximityPrompt") then
			table.insert(list, d)
		end
	end
	promptCache = list
end

local function promptPos(p)
	local par = p.Parent
	if not par then
		return nil
	end
	if par:IsA("BasePart") then
		return par.Position
	end
	if par:IsA("Attachment") then
		return par.WorldPosition
	end
	if par:IsA("Model") then
		return par:GetPivot().Position
	end
	local bp = par:FindFirstAncestorWhichIsA("BasePart")
	if bp then
		return bp.Position
	end
	return nil
end

local function matchAction(p, words)
	local t = string.lower(p.ActionText .. " " .. p.ObjectText)
	for _, w in ipairs(words) do
		if string.find(t, w, 1, true) then
			return true
		end
	end
	return false
end

local collectWords = { "collect", "claim", "cash", "money" }
local farmWords = { "steal", "grab", "take" }
local lastFire = setmetatable({}, { __mode = "k" })

task.spawn(function()
	while S.alive do
		if S.autoFarm or S.autoCollect then
			pcall(refreshPrompts)
		end
		task.wait(3)
	end
end)

task.spawn(function()
	while S.alive do
		if S.autoCollect and fireproximityprompt then
			local root = getRoot()
			if root then
				local now = os.clock()
				for _, p in ipairs(promptCache) do
					if p.Parent and p.Enabled and matchAction(p, collectWords) then
						local pos = promptPos(p)
						if pos and (pos - root.Position).Magnitude <= S.collectRange then
							if not lastFire[p] or now - lastFire[p] > 1 then
								lastFire[p] = now
								pcall(fireproximityprompt, p)
							end
						end
					end
				end
			end
		end
		task.wait(0.3)
	end
end)

local warnedBase = false
task.spawn(function()
	while S.alive do
		if S.autoFarm and fireproximityprompt then
			local root = getRoot()
			if root then
				local best = nil
				local bestPos = nil
				local bestD = math.huge
				for _, p in ipairs(promptCache) do
					if p.Parent and p.Enabled and matchAction(p, farmWords) then
						local ch = getChar()
						local pos = promptPos(p)
						if pos and ch and not p:IsDescendantOf(ch) then
							local d = (pos - root.Position).Magnitude
							if d < bestD then
								best = p
								bestPos = pos
								bestD = d
							end
						end
					end
				end
				if best and bestPos then
					root.CFrame = CFrame.new(bestPos + Vector3.new(0, 3, 0))
					task.wait(0.25)
					pcall(fireproximityprompt, best)
					task.wait(0.4)
					local okBase, basePos = pcall(findBase)
					if okBase and basePos then
						local r2 = getRoot()
						if r2 then
							r2.CFrame = CFrame.new(basePos + Vector3.new(0, 5, 0))
						end
					elseif not warnedBase then
						warnedBase = true
						notify("Set Base Here for Auto Farm return")
					end
				end
			end
			task.wait(S.farmDelay)
		else
			task.wait(0.3)
		end
	end
end)

local espFolder = new("Folder", { Name = "ESP" }, gui)

local function makeEsp(target, adornee, color, text, useHighlight)
	local hl = nil
	if useHighlight then
		hl = new("Highlight", {
			Adornee = target,
			FillColor = color,
			OutlineColor = Color3.new(1, 1, 1),
			FillTransparency = 0.55,
			OutlineTransparency = 0,
			DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
		}, espFolder)
	end
	local bb = new("BillboardGui", {
		Adornee = adornee,
		AlwaysOnTop = true,
		Size = UDim2.new(0, 180, 0, 26),
		StudsOffset = Vector3.new(0, 3, 0),
	}, espFolder)
	local lb = new("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = text,
		TextColor3 = color,
		TextStrokeTransparency = 0.4,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
	}, bb)
	return { hl = hl, bb = bb, lb = lb, adornee = adornee, target = target }
end

local function destroyEsp(e)
	if not e then
		return
	end
	if e.hl then
		pcall(function() e.hl:Destroy() end)
	end
	pcall(function() e.bb:Destroy() end)
end

local espPlayers = {}
local function clearPlayerEsp()
	for p, e in pairs(espPlayers) do
		destroyEsp(e)
		espPlayers[p] = nil
	end
end

local function refreshPlayerEsp()
	local root = getRoot()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			local ch = p.Character
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
			local e = espPlayers[p]
			if ch and hrp then
				if not e or e.target ~= ch then
					destroyEsp(e)
					e = makeEsp(ch, hrp, Color3.fromRGB(255, 80, 80), p.DisplayName, true)
					espPlayers[p] = e
				end
				local dist = 0
				if root then
					dist = math.floor((hrp.Position - root.Position).Magnitude)
				end
				e.lb.Text = p.DisplayName .. " [" .. tostring(dist) .. "m]"
			elseif e then
				destroyEsp(e)
				espPlayers[p] = nil
			end
		end
	end
	for p, e in pairs(espPlayers) do
		if not p.Parent then
			destroyEsp(e)
			espPlayers[p] = nil
		end
	end
end

task.spawn(function()
	while S.alive do
		if S.espPlayers then
			pcall(refreshPlayerEsp)
		end
		task.wait(0.5)
	end
end)

local espBrain = {}
local function clearBrainEsp()
	for m, e in pairs(espBrain) do
		destroyEsp(e)
		espBrain[m] = nil
	end
end

local function matchesKeyword(name)
	local l = string.lower(name)
	for _, k in ipairs(S.keywords) do
		if string.find(l, k, 1, true) then
			return true
		end
	end
	return false
end

local function scanBrainrots()
	local found = {}
	for _, d in ipairs(workspace:GetDescendants()) do
		if d:IsA("ProximityPrompt") then
			local at = string.lower(d.ActionText)
			if string.find(at, "steal", 1, true) or string.find(at, "buy", 1, true) or string.find(at, "purchase", 1, true) then
				local m = d:FindFirstAncestorOfClass("Model")
				if m and not Players:GetPlayerFromCharacter(m) then
					if d.ObjectText ~= "" then
						found[m] = d.ObjectText
					else
						found[m] = m.Name
					end
				end
			end
		elseif d:IsA("Model") and not Players:GetPlayerFromCharacter(d) and matchesKeyword(d.Name) then
			found[d] = d.Name
		end
	end
	return found
end

local function syncBrainrot()
	local found = scanBrainrots()
	for m, e in pairs(espBrain) do
		if not found[m] or not m.Parent then
			destroyEsp(e)
			espBrain[m] = nil
		end
	end
	local count = 0
	for _ in pairs(espBrain) do
		count = count + 1
	end
	for m, label in pairs(found) do
		if not espBrain[m] and count < 60 then
			local part = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true)
			if part then
				local e = makeEsp(m, part, Color3.fromRGB(255, 215, 70), label, false)
				e.name = label
				espBrain[m] = e
				count = count + 1
			end
		end
	end
end

local brainScanTimer = 0
task.spawn(function()
	while S.alive do
		if S.espBrainrot then
			brainScanTimer = brainScanTimer - 0.5
			if brainScanTimer <= 0 then
				brainScanTimer = 3
				pcall(syncBrainrot)
			end
			local root = getRoot()
			for m, e in pairs(espBrain) do
				if e.adornee and e.adornee.Parent then
					local dist = 0
					if root then
						dist = math.floor((e.adornee.Position - root.Position).Magnitude)
					end
					e.lb.Text = tostring(e.name) .. " [" .. tostring(dist) .. "m]"
				else
					destroyEsp(e)
					espBrain[m] = nil
				end
			end
		end
		task.wait(0.5)
	end
end)

local origLight = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
}

local function restoreLight()
	for k, v in pairs(origLight) do
		pcall(function() Lighting[k] = v end)
	end
end

bind(RunService.Heartbeat, function()
	if S.fullbright then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(178, 178, 178)
		Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
	end
end)

local pMain = pages["Main"]
section(pMain, "Quick actions")
makeButton(pMain, "TP to Base", function() tpToBase() end)
makeButton(pMain, "Set Base Here", function()
	local root = getRoot()
	if root then
		S.basePos = root.Position
		notify("Base position saved")
	else
		notify("Character not found")
	end
end)
section(pMain, "Protection")
makeToggle(pMain, "God Mode", false, function(v)
	S.god = v
	hookGod()
	notify("God Mode: " .. (v and "ON" or "OFF"))
end)
makeToggle(pMain, "Anti AFK", false, function(v)
	S.antiAfk = v
	notify("Anti AFK: " .. (v and "ON" or "OFF"))
end)
makeToggle(pMain, "Infinite Jump", false, function(v)
	S.infJump = v
	notify("Infinite Jump: " .. (v and "ON" or "OFF"))
end)

local pPlayer = pages["Player"]
section(pPlayer, "Movement")
local setWS = makeSlider(pPlayer, "WalkSpeed", 16, 200, 16, function(v) S.walkSpeed = v end)
local setJP = makeSlider(pPlayer, "JumpPower", 50, 300, 50, function(v) S.jumpPower = v end)
makeButton(pPlayer, "Reset Speed and Jump", function()
	S.walkSpeed = nil
	S.jumpPower = nil
	setWS(16, true)
	setJP(50, true)
	local h = getHum()
	if h then
		h.WalkSpeed = 16
		h.UseJumpPower = true
		h.JumpPower = 50
	end
	notify("Speed and jump reset")
end)
section(pPlayer, "Flight and collision")
makeToggle(pPlayer, "Fly (WASD / Space / Shift)", false, function(v)
	S.fly = v
	if v then startFly() else stopFly() end
	notify("Fly: " .. (v and "ON" or "OFF"))
end)
makeSlider(pPlayer, "Fly Speed", 10, 200, 60, function(v) S.flySpeed = v end)
makeToggle(pPlayer, "Noclip", false, function(v)
	S.noclip = v
	notify("Noclip: " .. (v and "ON" or "OFF"))
end)

local pFarm = pages["Farm"]
section(pFarm, "Automation")
makeToggle(pFarm, "Auto Farm", false, function(v)
	if v and not fireproximityprompt then notify("Executor has no fireproximityprompt") end
	S.autoFarm = v
	if v then pcall(refreshPrompts) end
	notify("Auto Farm: " .. (v and "ON" or "OFF"))
end)
makeToggle(pFarm, "Auto Collect", false, function(v)
	if v and not fireproximityprompt then notify("Executor has no fireproximityprompt") end
	S.autoCollect = v
	if v then pcall(refreshPrompts) end
	notify("Auto Collect: " .. (v and "ON" or "OFF"))
end)
section(pFarm, "Settings")
makeSlider(pFarm, "Collect Range", 10, 100, 40, function(v) S.collectRange = v end)
makeSlider(pFarm, "Farm Delay (sec)", 1, 10, 2, function(v) S.farmDelay = v end)
makeButton(pFarm, "Rescan Prompts", function()
	pcall(refreshPrompts)
	notify("Prompts found: " .. tostring(#promptCache))
end)
infoLabel(pFarm, "Auto Farm teleports to the nearest Steal/Grab prompt, fires it, then returns to your base. Set the base first.")

local pVis = pages["Visuals"]
section(pVis, "ESP")
makeToggle(pVis, "ESP Brainrot", false, function(v)
	S.espBrainrot = v
	if v then brainScanTimer = 0 else clearBrainEsp() end
	notify("ESP Brainrot: " .. (v and "ON" or "OFF"))
end)
makeToggle(pVis, "ESP Players", false, function(v)
	S.espPlayers = v
	if not v then clearPlayerEsp() end
	notify("ESP Players: " .. (v and "ON" or "OFF"))
end)
makeInput(pVis, "Add ESP keyword", "name + Enter", function(text)
	table.insert(S.keywords, string.lower(text))
	brainScanTimer = 0
	notify("Keyword added: " .. text)
end)
section(pVis, "World")
makeToggle(pVis, "Fullbright", false, function(v)
	S.fullbright = v
	if not v then restoreLight() end
	notify("Fullbright: " .. (v and "ON" or "OFF"))
end)

local pSet = pages["Settings"]
section(pSet, "Interface")
infoLabel(pSet, "RightShift hides and shows the menu. Drag the top bar to move the window. Type in the search box to find any function.")
section(pSet, "Session")
makeButton(pSet, "Rejoin Server", function()
	pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
end)

local function unload()
	S.alive = false
	S.god = false
	hookGod()
	S.fly = false
	stopFly()
	S.noclip = false
	S.fullbright = false
	restoreLight()
	clearPlayerEsp()
	clearBrainEsp()
	for _, c in ipairs(conns) do
		pcall(function() c:Disconnect() end)
	end
	gui:Destroy()
end

makeButton(pSet, "Unload GUI", unload)

closeBtn.MouseButton1Click:Connect(unload)
miniBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	notify("Hidden (RightShift to show)")
end)

bind(UIS.InputBegan, function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		main.Visible = not main.Visible
	end
end)

local frames = 0
local acc = 0
bind(RunService.RenderStepped, function(dt)
	frames = frames + 1
	acc = acc + dt
	if acc >= 0.5 then
		local fps = math.floor(frames / acc + 0.5)
		local pingText = ""
		pcall(function()
			local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
			pingText = "  |  Ping: " .. tostring(math.floor(ping)) .. " ms"
		end)
		fpsLabel.Text = "FPS: " .. tostring(fps) .. pingText
		frames = 0
		acc = 0
	end
end)

showTab("Main")
notify("Brainrot Hub loaded")
