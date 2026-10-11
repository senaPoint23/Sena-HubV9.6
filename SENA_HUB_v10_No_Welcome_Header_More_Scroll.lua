-- SENA HUB - Neon Blue UI Prototype v2 (responsive + scroll fixes)
-- For your own Roblox Studio experience / authorized testing.
-- This is a UI shell only; it does not download or execute external code.
-- Put this LocalScript in StarterPlayer > StarterPlayerScripts in your own experience.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("SenaHubUI")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(5, 12, 29),
    panel = Color3.fromRGB(8, 20, 44),
    panel2 = Color3.fromRGB(10, 30, 61),
    blue = Color3.fromRGB(0, 128, 255),
    cyan = Color3.fromRGB(0, 220, 255),
    text = Color3.fromRGB(235, 247, 255),
    muted = Color3.fromRGB(140, 179, 211),
    violet = Color3.fromRGB(119, 87, 255),
    mint = Color3.fromRGB(66, 255, 210),
    card = Color3.fromRGB(8, 27, 55),
}

local gui = Instance.new("ScreenGui")
gui.Name = "SenaHubUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false -- respect Roblox top bar safe area
gui.DisplayOrder = 100
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    return make("UICorner", {CornerRadius = UDim.new(0, radius or 12)}, parent)
end

local function stroke(parent, color, thickness, transparency)
    return make("UIStroke", {
        Color = color or C.blue,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, parent)
end

local function label(parent, text, size, pos, font, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = size or 14,
        Font = font or Enum.Font.Gotham,
        TextColor3 = color or C.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Position = pos or UDim2.new(),
        Size = UDim2.new(1, 0, 0, 24),
        TextWrapped = true
    }, parent)
end

local function button(parent, text, size, pos)
    local b = make("TextButton", {
        AutoButtonColor = false,
        Text = text,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = C.text,
        BackgroundColor3 = C.panel2,
        Size = size,
        Position = pos
    }, parent)
    corner(b, 10)
    stroke(b, C.blue, 1, 0.15)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(13, 48, 91)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = C.panel2}):Play()
    end)
    return b
end

local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.53),
    Size = UDim2.new(0.78, 0, 0.72, 0),
    BackgroundColor3 = C.bg,
    ClipsDescendants = true,
    Visible = false
}, gui)
corner(main, 24)
stroke(main, C.cyan, 1.2, 0.12)
make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(7, 18, 42)),
        ColorSequenceKeypoint.new(0.55, Color3.fromRGB(5, 12, 29)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 24, 52))
    }),
    Rotation = 25
}, main)

make("UISizeConstraint", {
    MinSize = Vector2.new(300, 280),
    MaxSize = Vector2.new(1040, 680)
}, main)

local top = make("Frame", {
    Name = "Header",
    BackgroundColor3 = C.panel,
    Size = UDim2.new(1, 0, 0, 64),
    ZIndex = 2
}, main)
corner(top, 24)
make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 34, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 18, 40))
    }),
    Rotation = 0
}, top)

local logo = make("ImageLabel", {
    Name = "Logo",
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(44, 44),
    Position = UDim2.fromOffset(16, 10),
    Image = "rbxassetid://111099731853513",
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 3
}, top)

local title = label(top, "SENA HUB", 24, UDim2.fromOffset(70, 7), Enum.Font.GothamBlack, C.text)
title.Size = UDim2.new(1, -190, 0, 29)
title.ZIndex = 3
local subtitle = label(top, "NEON BLUE INTERFACE", 9, UDim2.fromOffset(71, 35), Enum.Font.GothamMedium, C.cyan)
subtitle.Size = UDim2.new(1, -190, 0, 14)
subtitle.ZIndex = 3

local statusPill = make("Frame", {
    Name = "StatusPill",
    BackgroundColor3 = Color3.fromRGB(7, 48, 57),
    BackgroundTransparency = 0.05,
    Position = UDim2.new(1, -132, 0, 21),
    Size = UDim2.fromOffset(76, 22),
    ZIndex = 3
}, top)
corner(statusPill, 11)
stroke(statusPill, C.mint, 1, 0.35)
local statusDot = make("Frame", {
    BackgroundColor3 = C.mint,
    Position = UDim2.fromOffset(8, 8),
    Size = UDim2.fromOffset(6, 6),
    ZIndex = 4
}, statusPill)
corner(statusDot, 6)
local statusText = label(statusPill, "READY", 8, UDim2.fromOffset(19, 2), Enum.Font.GothamBold, C.mint)
statusText.Size = UDim2.new(1, -21, 1, -4)
statusText.ZIndex = 4

local close = button(top, "×", UDim2.fromOffset(34, 34), UDim2.new(1, -46, 0, 15))
close.TextSize = 25
close.ZIndex = 4
-- Floating reopen button stays visible when the main panel is hidden.
local reopen = make("ImageButton", {
    Name = "FloatingReopen",
    Image = "rbxassetid://111099731853513",
    ScaleType = Enum.ScaleType.Fit,
    BackgroundColor3 = C.panel,
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.new(0, 18, 0.45, 0),
    Size = UDim2.fromOffset(46, 46),
    Visible = false,
    ZIndex = 20,
}, gui)
corner(reopen, 15)
stroke(reopen, C.cyan, 2, 0)

-- Allow the floating logo to be moved with touch or mouse.
-- A short tap still reopens the hub; movement beyond the threshold is treated as dragging.
local reopenDragging = false
local reopenMoved = false
local reopenStartInput = nil
local reopenStartPos = nil
local reopenStartPoint = nil
local reopenDragThreshold = 8

reopen.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.Touch
        and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return
    end

    reopenDragging = true
    reopenMoved = false
    reopenStartInput = input
    reopenStartPoint = input.Position
    reopenStartPos = reopen.Position
end)

UserInputService.InputChanged:Connect(function(input)
    if not reopenDragging or not reopenStartPoint or not reopenStartPos then
        return
    end

    local isRelevant = input.UserInputType == Enum.UserInputType.MouseMovement
        or (input.UserInputType == Enum.UserInputType.Touch and input == reopenStartInput)
    if not isRelevant then return end

    local delta = input.Position - reopenStartPoint
    if math.abs(delta.X) + math.abs(delta.Y) > reopenDragThreshold then
        reopenMoved = true
    end

    if reopenMoved then
        local camera = workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
        local size = reopen.AbsoluteSize
        local x = math.clamp(reopenStartPos.X.Offset + delta.X, 0, math.max(0, viewport.X - size.X))
        local y = math.clamp(reopenStartPos.Y.Offset + delta.Y, 0, math.max(0, viewport.Y - size.Y))
        reopen.Position = UDim2.fromOffset(x, y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not reopenDragging then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or (input.UserInputType == Enum.UserInputType.Touch and input == reopenStartInput) then
        local wasMoved = reopenMoved
        reopenDragging = false
        reopenStartInput = nil
        reopenStartPoint = nil
        reopenStartPos = nil
        -- Suppress the Activated reopen action after a drag; taps are handled by Activated below.
        reopen:SetAttribute("WasDragged", wasMoved)
        task.defer(function()
            if reopen.Parent then
                reopen:SetAttribute("WasDragged", false)
            end
        end)
    end
end)

local function hideHub()
    main.Visible = false
    reopen.Visible = true
end

local function showHub()
    main.Visible = true
    reopen.Visible = false
end

close.Activated:Connect(hideHub)
reopen.Activated:Connect(function()
    if reopen:GetAttribute("WasDragged") then return end
    showHub()
end)

local body = make("Frame", {
    Name = "Body",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 78),
    Size = UDim2.new(1, -28, 1, -92)
}, main)

-- New layout: horizontal navigation across the top, not the old tall sidebar.
local nav = make("Frame", {
    Name = "Navigation",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 42),
    ClipsDescendants = true
}, body)

local navScroll = make("ScrollingFrame", {
    Name = "NavScroll",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.X,
    ScrollingDirection = Enum.ScrollingDirection.X,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.cyan,
    ScrollBarImageTransparency = 0.18,
    ScrollingEnabled = true,
    Active = true
}, nav)
local navLayout = make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center
}, navScroll)
make("UIPadding", {
    PaddingLeft = UDim.new(0, 1),
    PaddingRight = UDim.new(0, 4)
}, navScroll)

local content = make("Frame", {
    Name = "Content",
    BackgroundColor3 = Color3.fromRGB(6, 16, 36),
    Position = UDim2.new(0, 0, 0, 54),
    Size = UDim2.new(1, 0, 1, -54),
    ClipsDescendants = true
}, body)
corner(content, 20)
stroke(content, Color3.fromRGB(31, 92, 151), 1, 0.35)

-- Header judul halaman dihilangkan agar area konten/scroll lebih luas.

local pageArea = make("ScrollingFrame", {
    Name = "PageArea",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(12, 12),
    Size = UDim2.new(1, -24, 1, -24),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = C.cyan,
    ScrollingEnabled = true,
    Active = true,
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
    ScrollBarImageTransparency = 0.05
}, content)
make("UIListLayout", {
    Padding = UDim.new(0, 12),
    SortOrder = Enum.SortOrder.LayoutOrder
}, pageArea)
make("UIPadding", {
    PaddingTop = UDim.new(0, 2),
    PaddingBottom = UDim.new(0, 14)
}, pageArea)

local function clearPage()
    for _, child in ipairs(pageArea:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function card(titleText, bodyText)
    local f = make("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 29, 58),
        BackgroundTransparency = 0.04,
        Size = UDim2.new(1, -10, 0, 94)
    }, pageArea)
    corner(f, 16)
    stroke(f, Color3.fromRGB(30, 82, 132), 1, 0.38)
    local accent = make("Frame", {
        BackgroundColor3 = C.cyan,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 15),
        Size = UDim2.new(0, 3, 0, 30)
    }, f)
    corner(accent, 2)
    local t = label(f, titleText, 13, UDim2.fromOffset(16, 10), Enum.Font.GothamBold, C.cyan)
    t.Size = UDim2.new(1, -30, 0, 20)
    local d = label(f, bodyText, 11, UDim2.fromOffset(16, 34), Enum.Font.Gotham, C.muted)
    d.Size = UDim2.new(1, -30, 0, 52)
    d.TextWrapped = true
    d.TextYAlignment = Enum.TextYAlignment.Top
    return f
end

local tabs = {"Home", "Farm", "Player", "Progress", "Settings", "About"}
local tabIcons = {
    Home = "⌂",
    Farm = "✦",
    Player = "◉",
    Progress = "▥",
    Settings = "⚙",
    About = "ⓘ",
}
local navButtons = {}

local function showPage(name)
    clearPage()
    pageArea.CanvasPosition = Vector2.new(0, 0)

    if name == "Home" then
        card("SYSTEM ONLINE", "Sena Hub siap digunakan. Pilih tab di atas untuk membuka halaman yang tersedia.")
        card("NAVIGASI", "Semua menu utama berada di bagian atas. Geser tab ke samping jika sebagian menu belum terlihat.")
        card("TAMPILAN", "Panel menggunakan tema gelap dengan aksen biru neon, kontras yang jelas, dan jarak antarkartu lebih lega.")
        card("SCROLL KONTEN", "Geser area isi ke atas atau bawah untuk melihat semua kartu pada halaman ini.")
        card("CATATAN", "Ini masih kerangka UI. Tombol fitur belum menjalankan aksi game sampai logika fitur ditambahkan.")
    elseif name == "Farm" then
        card("FARM OVERVIEW", "Tempat untuk mengelompokkan opsi farm dalam bagian yang mudah dibaca.")
        card("PENGATURAN FARM", "Slot pengaturan farm. Kontrol nyata perlu dihubungkan ke logika fitur yang sesuai.")
        card("MODE FARM", "Bagian untuk memilih mode farm setelah perilaku fiturnya ditentukan.")
        card("JADWAL / BATAS", "Tempat opsi batas atau interval, jika fitur farm membutuhkannya.")
        card("STATUS FARM", "Status akan menampilkan informasi nyata setelah sistem farm diimplementasikan.")
        card("INFORMASI", "Belum ada aksi otomatis yang dijalankan oleh kartu placeholder ini.")
    elseif name == "Player" then
        card("PLAYER OVERVIEW", "Bagian pengaturan yang berhubungan dengan karakter pemain.")
        card("MOVEMENT", "Slot untuk opsi gerakan pemain, jika diperlukan dan diizinkan dalam pengalaman game milikmu.")
        card("CHARACTER", "Tempat untuk kontrol karakter dan preferensi pemain.")
        card("PLAYER STATUS", "Informasi status akan muncul setelah fungsi yang sesuai dihubungkan.")
        card("INFORMASI", "Kartu ini adalah placeholder antarmuka, bukan fitur yang sudah aktif.")
    elseif name == "Progress" then
        card("PROGRESS OVERVIEW", "Ringkasan progres dan statistik dapat ditampilkan di halaman ini.")
        card("STATISTIK", "Slot untuk data statistik yang benar-benar tersedia dari pengalaman game.")
        card("RIWAYAT", "Tempat untuk riwayat sesi atau pencapaian jika datanya disediakan.")
        card("PENCAPAIAN", "Bagian untuk ringkasan pencapaian pemain.")
        card("INFORMASI", "Data belum ditautkan; halaman ini masih berupa kerangka UI.")
    elseif name == "Settings" then
        card("PREFERENSI UI", "Tempat pengaturan tampilan antarmuka SENA HUB.")
        card("UKURAN & POSISI", "Slot untuk preferensi ukuran panel dan posisi tombol mengambang.")
        card("TAMPILAN", "Slot untuk tema dan preferensi visual antarmuka.")
        card("KONTROL", "Pengaturan akan berfungsi setelah kontrolnya dihubungkan ke kode terkait.")
        local hideButton = button(pageArea, "Tutup SENA HUB", UDim2.new(1, -10, 0, 42), UDim2.new())
        hideButton.LayoutOrder = 10
        hideButton.Activated:Connect(hideHub)
    else
        card("ABOUT SENA HUB", "Informasi singkat mengenai antarmuka dan versi UI.")
        card("VERSI", "SENA HUB — Neon Blue Interface.")
        card("CATATAN", "UI shell ini tidak mengunduh atau menjalankan kode eksternal.")
        card("KETERBATASAN", "Fitur game perlu diimplementasikan secara terpisah untuk pengalaman Roblox milikmu sendiri.")
    end

    for tabName, b in pairs(navButtons) do
        local selected = tabName == name
        b.BackgroundColor3 = selected and Color3.fromRGB(0, 91, 139) or Color3.fromRGB(9, 26, 52)
        b.TextColor3 = selected and C.cyan or C.muted
        local outline = b:FindFirstChildOfClass("UIStroke")
        if outline then
            outline.Color = selected and C.cyan or Color3.fromRGB(33, 75, 119)
            outline.Transparency = selected and 0.12 or 0.48
        end
        local indicator = b:FindFirstChild("ActiveIndicator")
        if indicator then indicator.Visible = selected end
    end
end

for i, tabName in ipairs(tabs) do
    local b = button(navScroll, tabIcons[tabName] .. "   " .. tabName, UDim2.fromOffset(104, 38), UDim2.new())
    b.LayoutOrder = i
    b.TextXAlignment = Enum.TextXAlignment.Center
    b.TextSize = 11
    b.BackgroundColor3 = Color3.fromRGB(9, 26, 52)
    corner(b, 19)
    local indicator = make("Frame", {
        Name = "ActiveIndicator",
        BackgroundColor3 = C.cyan,
        Position = UDim2.new(0.28, 0, 1, -3),
        Size = UDim2.new(0.44, 0, 0, 2),
        Visible = tabName == "Home",
        ZIndex = b.ZIndex + 2
    }, b)
    corner(indicator, 2)

    navButtons[tabName] = b
    b.Activated:Connect(function() showPage(tabName) end)
end

-- Drag the panel by its header using mouse or touch.
-- Ignore drags that begin on interactive header controls such as the close button.
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

top.InputBegan:Connect(function(input)
    local isPointer = input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
    if not isPointer then return end

    -- The close button is a child of the header; don't start a drag from its area.
    local p = input.Position
    local closePos, closeSize = close.AbsolutePosition, close.AbsoluteSize
    local overClose = p.X >= closePos.X and p.X <= closePos.X + closeSize.X
        and p.Y >= closePos.Y and p.Y <= closePos.Y + closeSize.Y
    if overClose then return end

    dragging = true
    dragInput = input
    dragStart = input.Position
    startPos = main.Position
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or (input.UserInputType == Enum.UserInputType.Touch and input == dragInput) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or (input.UserInputType == Enum.UserInputType.Touch and input == dragInput) then
        dragging = false
        dragInput = nil
    end
end)

-- Compact layout on narrow screens.
local function applyResponsive()
    local width = main.AbsoluteSize.X
    if width < 520 then
        pageTitle.TextSize = 17
        pageSub.TextSize = 9
        title.TextSize = 20
        for _, b in pairs(navButtons) do
            b.Size = UDim2.fromOffset(88, 36)
            b.TextSize = 10
        end
    else
        pageTitle.TextSize = 21
        pageSub.TextSize = 11
        title.TextSize = 24
        for _, b in pairs(navButtons) do
            b.Size = UDim2.fromOffset(104, 38)
            b.TextSize = 11
        end
    end
end
main:GetPropertyChangedSignal("AbsoluteSize"):Connect(applyResponsive)
task.defer(applyResponsive)
showPage("Home")


-- Full-screen loading screen shown every time this LocalScript runs.
-- It covers the entire screen, then fades away to reveal the Sena Hub menu.
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "SenaHubLoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 10000
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.Parent = playerGui

-- Hide the hub ScreenGui during loading so its floating toggle cannot overlap the logo.
gui.Enabled = false

local loadingBg = Instance.new("Frame")
loadingBg.Name = "Background"
loadingBg.Size = UDim2.fromScale(1, 1)
loadingBg.Position = UDim2.fromScale(0, 0)
loadingBg.BorderSizePixel = 0
loadingBg.BackgroundColor3 = Color3.fromRGB(3, 8, 22)
loadingBg.ZIndex = 1
loadingBg.Parent = loadingGui

local loadingGradient = Instance.new("UIGradient")
loadingGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 15, 38)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(7, 25, 54)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(3, 8, 22))
})
loadingGradient.Rotation = 35
loadingGradient.Parent = loadingBg

local loadingPanel = Instance.new("Frame")
loadingPanel.Name = "LoadingPanel"
loadingPanel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingPanel.Position = UDim2.fromScale(0.5, 0.5)
loadingPanel.Size = UDim2.new(0.78, 0, 0.78, 0)
loadingPanel.BackgroundColor3 = Color3.fromRGB(5, 17, 38)
loadingPanel.BackgroundTransparency = 0.18
loadingPanel.BorderSizePixel = 0
loadingPanel.ZIndex = 2
loadingPanel.Parent = loadingBg
local panelConstraint = Instance.new("UISizeConstraint")
panelConstraint.MinSize = Vector2.new(290, 330)
panelConstraint.MaxSize = Vector2.new(560, 500)
panelConstraint.Parent = loadingPanel
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 24)
panelCorner.Parent = loadingPanel
local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(0, 174, 255)
panelStroke.Thickness = 1.2
panelStroke.Transparency = 0.48
panelStroke.Parent = loadingPanel

local panelInset = Instance.new("UIPadding")
panelInset.PaddingLeft = UDim.new(0, 20)
panelInset.PaddingRight = UDim.new(0, 20)
panelInset.Parent = loadingPanel

local glow = Instance.new("Frame")
glow.Name = "Glow"
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Position = UDim2.fromScale(0.5, 0.31)
glow.Size = UDim2.fromOffset(170, 170)
glow.BackgroundColor3 = Color3.fromRGB(0, 133, 255)
glow.BackgroundTransparency = 0.91
glow.BorderSizePixel = 0
glow.ZIndex = 3
glow.Parent = loadingPanel
local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glow

local logoRing = Instance.new("Frame")
logoRing.Name = "LogoRing"
logoRing.AnchorPoint = Vector2.new(0.5, 0.5)
logoRing.Position = UDim2.fromScale(0.5, 0.28)
logoRing.Size = UDim2.fromOffset(96, 96)
logoRing.BackgroundColor3 = Color3.fromRGB(6, 24, 52)
logoRing.BorderSizePixel = 0
logoRing.ZIndex = 4
logoRing.Parent = loadingPanel
local ringCorner = Instance.new("UICorner")
ringCorner.CornerRadius = UDim.new(1, 0)
ringCorner.Parent = logoRing
local ringStroke = Instance.new("UIStroke")
ringStroke.Color = C.cyan
ringStroke.Thickness = 2
ringStroke.Transparency = 0.08
ringStroke.Parent = logoRing

local loadingLogo = Instance.new("ImageLabel")
loadingLogo.Name = "Logo"
loadingLogo.BackgroundTransparency = 1
loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLogo.Position = UDim2.fromScale(0.5, 0.5)
loadingLogo.Size = UDim2.fromOffset(78, 78)
loadingLogo.Image = "rbxassetid://111099731853513"
loadingLogo.ScaleType = Enum.ScaleType.Fit
loadingLogo.ZIndex = 5
loadingLogo.Parent = logoRing

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Name = "Title"
loadingTitle.BackgroundTransparency = 1
loadingTitle.AnchorPoint = Vector2.new(0.5, 0)
loadingTitle.Position = UDim2.new(0.5, 0, 0.43, 0)
loadingTitle.Size = UDim2.new(1, 0, 0, 38)
loadingTitle.Font = Enum.Font.GothamBlack
loadingTitle.Text = "SENA HUB"
loadingTitle.TextColor3 = Color3.fromRGB(235, 247, 255)
loadingTitle.TextSize = 27
loadingTitle.TextXAlignment = Enum.TextXAlignment.Center
loadingTitle.ZIndex = 4
loadingTitle.Parent = loadingPanel

local loadingSubtitle = Instance.new("TextLabel")
loadingSubtitle.Name = "Subtitle"
loadingSubtitle.BackgroundTransparency = 1
loadingSubtitle.AnchorPoint = Vector2.new(0.5, 0)
loadingSubtitle.Position = UDim2.new(0.5, 0, 0.43, 39)
loadingSubtitle.Size = UDim2.new(1, 0, 0, 20)
loadingSubtitle.Font = Enum.Font.GothamMedium
loadingSubtitle.Text = "NEON BLUE INTERFACE"
loadingSubtitle.TextColor3 = C.cyan
loadingSubtitle.TextSize = 11
loadingSubtitle.TextXAlignment = Enum.TextXAlignment.Center
loadingSubtitle.ZIndex = 4
loadingSubtitle.Parent = loadingPanel

local progressBack = Instance.new("Frame")
progressBack.Name = "ProgressBackground"
progressBack.AnchorPoint = Vector2.new(0.5, 0)
progressBack.Position = UDim2.new(0.5, 0, 0.68, 0)
progressBack.Size = UDim2.new(0.84, 0, 0, 7)
progressBack.BackgroundColor3 = Color3.fromRGB(17, 38, 68)
progressBack.BorderSizePixel = 0
progressBack.ZIndex = 4
progressBack.Parent = loadingPanel
local progressBackCorner = Instance.new("UICorner")
progressBackCorner.CornerRadius = UDim.new(1, 0)
progressBackCorner.Parent = progressBack

local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = C.cyan
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 5
progressFill.Parent = progressBack
local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(1, 0)
progressFillCorner.Parent = progressFill
local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 128, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 255, 210))
})
progressGradient.Parent = progressFill

local progressStatus = Instance.new("TextLabel")
progressStatus.Name = "LoadingStatus"
progressStatus.BackgroundTransparency = 1
progressStatus.AnchorPoint = Vector2.new(0.5, 0)
progressStatus.Position = UDim2.new(0.5, 0, 0.68, 15)
progressStatus.Size = UDim2.new(0.84, 0, 0, 22)
progressStatus.Font = Enum.Font.GothamMedium
progressStatus.Text = "Menyiapkan antarmuka..."
progressStatus.TextColor3 = Color3.fromRGB(140, 179, 211)
progressStatus.TextSize = 11
progressStatus.TextXAlignment = Enum.TextXAlignment.Center
progressStatus.ZIndex = 4
progressStatus.Parent = loadingPanel

local percentLabel = Instance.new("TextLabel")
percentLabel.Name = "Percentage"
percentLabel.BackgroundTransparency = 1
percentLabel.AnchorPoint = Vector2.new(0.5, 0)
percentLabel.Position = UDim2.new(0.5, 0, 0.68, 39)
percentLabel.Size = UDim2.new(0.84, 0, 0, 20)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.Text = "0%"
percentLabel.TextColor3 = C.text
percentLabel.TextSize = 10
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
percentLabel.ZIndex = 4
percentLabel.Parent = loadingPanel

local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.BackgroundTransparency = 1
footer.AnchorPoint = Vector2.new(0.5, 1)
footer.Position = UDim2.new(0.5, 0, 1, -18)
footer.Size = UDim2.new(0.9, 0, 0, 18)
footer.Font = Enum.Font.Gotham
footer.Text = "SENA HUB  •  NEON BLUE UI"
footer.TextColor3 = Color3.fromRGB(73, 112, 155)
footer.TextSize = 9
footer.TextXAlignment = Enum.TextXAlignment.Center
footer.ZIndex = 4
footer.Parent = loadingPanel

-- A brief, staged progress animation plays on every script run.
task.spawn(function()
    local stages = {
        {value = 22, text = "Memuat komponen UI..."},
        {value = 48, text = "Menyiapkan navigasi..."},
        {value = 76, text = "Menyelaraskan tampilan..."},
        {value = 100, text = "Sena Hub siap digunakan!"}
    }

    for _, stage in ipairs(stages) do
        progressStatus.Text = stage.text
        local duration = stage.value == 100 and 0.45 or 0.62
        local tween = TweenService:Create(
            progressFill,
            TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(stage.value / 100, 0, 1, 0)}
        )
        tween:Play()
        local startValue = tonumber(string.match(percentLabel.Text, "%d+")) or 0
        local startedAt = os.clock()
        while true do
            local elapsed = os.clock() - startedAt
            local alpha = math.clamp(elapsed / duration, 0, 1)
            local current = math.floor(startValue + (stage.value - startValue) * alpha)
            percentLabel.Text = tostring(current) .. "%"
            if alpha >= 1 then break end
            task.wait(0.03)
        end
        percentLabel.Text = tostring(stage.value) .. "%"
        -- Do not wait on Completed here: the tween may finish during the
        -- progress-label loop, before a Completed:Wait() listener is attached.
        -- That race could leave the loading screen stuck at 22%.
        if tween.PlaybackState ~= Enum.PlaybackState.Completed then
            local remaining = math.max(0, duration - (os.clock() - startedAt))
            if remaining > 0 then task.wait(remaining) end
        end
    end

    task.wait(0.35)
    main.Visible = true
    gui.Enabled = true

    local fadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for _, item in ipairs(loadingBg:GetDescendants()) do
        if item:IsA("Frame") then
            TweenService:Create(item, fadeInfo, {BackgroundTransparency = 1}):Play()
        elseif item:IsA("TextLabel") then
            TweenService:Create(item, fadeInfo, {TextTransparency = 1}):Play()
        elseif item:IsA("ImageLabel") then
            TweenService:Create(item, fadeInfo, {ImageTransparency = 1}):Play()
        elseif item:IsA("UIStroke") then
            TweenService:Create(item, fadeInfo, {Transparency = 1}):Play()
        end
    end
    TweenService:Create(loadingBg, fadeInfo, {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    loadingGui:Destroy()
end)
