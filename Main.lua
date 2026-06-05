-- ============================================
-- F脚本中心 - 作者尊享版 v4.2
-- 彩色边框 + 动画 + 玩家信息 + 作者识别 + 启动提示
-- ============================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera

-- ★ 作者用户名
local AUTHOR_NAME = "noobnewfggg"

-- ★ 你的收款码图片直链
local IMAGE_URL = "https://i.imgur.com/h35hvJb.png"

-- ★ VIP 用户ID列表（数字ID）
local VIP_USERS = {
    [000000000] = true,  -- 可添加更多VIP用户ID
}

-- ============================================
-- 判断当前玩家身份
-- ============================================
local isAuthor = (LocalPlayer.Name == AUTHOR_NAME)
local roleText, roleColor
if isAuthor then
    roleText = "👑 作者"
    roleColor = Color3.fromRGB(255, 215, 0)
elseif VIP_USERS[LocalPlayer.UserId] then
    roleText = "🌟 VIP 用户"
    roleColor = Color3.fromRGB(255, 215, 0)
else
    roleText = "普通用户"
    roleColor = Color3.fromRGB(200, 200, 200)
end

-- ============================================
-- 启动时欢迎提示
-- ============================================
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "F脚本中心 v4.2",
    Text = isAuthor and "欢迎 F脚本作者" or "欢迎使用，作者："..AUTHOR_NAME,
    Duration = 5,
    Icon = "rbxassetid://7734068321"
})

-- ============================================
-- 创建主界面
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FScriptHub"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- 彩色流光边框
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 3
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame
coroutine.wrap(function()
    while MainStroke and MainStroke.Parent do
        local hue = (tick() * 0.5) % 1
        MainStroke.Color = Color3.fromHSV(hue, 1, 1)
        RunService.RenderStepped:Wait()
    end
end)()

-- 左上角 F 图标
local FIcon = Instance.new("TextLabel")
FIcon.Name = "FIcon"
FIcon.Parent = MainFrame
FIcon.Size = UDim2.new(0, 60, 0, 60)
FIcon.Position = UDim2.new(0, 15, 0, 10)
FIcon.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
FIcon.Text = "F"
FIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
FIcon.TextSize = 36
FIcon.Font = Enum.Font.GothamBlack
local FIconCorner = Instance.new("UICorner"); FIconCorner.CornerRadius = UDim.new(0,10); FIconCorner.Parent = FIcon

-- 标题
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(0, 200, 0, 30)
TitleLabel.Position = UDim2.new(0, 85, 0, 15)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "脚本中心"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.Size = UDim2.new(0, 200, 0, 18)
SubTitle.Position = UDim2.new(0, 85, 0, 45)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "作者尊享版 v4.2"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 160)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- 关闭按钮
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner"); CloseCorner.CornerRadius = UDim.new(0,8); CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- 右侧滑动栏
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(0, 180, 1, -80)
ScrollFrame.Position = UDim2.new(1, -195, 0, 70)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 650)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
local ScrollCorner = Instance.new("UICorner"); ScrollCorner.CornerRadius = UDim.new(0,8); ScrollCorner.Parent = ScrollFrame
local ScrollLayout = Instance.new("UIListLayout"); ScrollLayout.Parent = ScrollFrame; ScrollLayout.Padding = UDim.new(0,8); ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- 左侧内容区（包含玩家信息和功能描述）
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -210, 1, -80)
ContentFrame.Position = UDim2.new(0, 10, 0, 70)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ContentFrame.BorderSizePixel = 0
local ContentCorner = Instance.new("UICorner"); ContentCorner.CornerRadius = UDim.new(0,8); ContentCorner.Parent = ContentFrame

-- 玩家信息面板
local PlayerInfoFrame = Instance.new("Frame")
PlayerInfoFrame.Parent = ContentFrame
PlayerInfoFrame.Size = UDim2.new(1, -10, 0, 80)
PlayerInfoFrame.Position = UDim2.new(0, 5, 0, 5)
PlayerInfoFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
PlayerInfoFrame.BorderSizePixel = 0
local PlayerInfoCorner = Instance.new("UICorner"); PlayerInfoCorner.CornerRadius = UDim.new(0,8); PlayerInfoCorner.Parent = PlayerInfoFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = PlayerInfoFrame
AvatarImage.Size = UDim2.new(0, 60, 0, 60)
AvatarImage.Position = UDim2.new(0, 10, 0, 10)
AvatarImage.BackgroundTransparency = 1
coroutine.wrap(function()
    local userId = LocalPlayer.UserId
    local content = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    AvatarImage.Image = content
end)()

local NameLabel = Instance.new("TextLabel")
NameLabel.Parent = PlayerInfoFrame
NameLabel.Size = UDim2.new(1, -80, 0, 22)
NameLabel.Position = UDim2.new(0, 80, 0, 10)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = LocalPlayer.DisplayName.." (@"..LocalPlayer.Name..")"
NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NameLabel.TextSize = 16
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextXAlignment = Enum.TextXAlignment.Left

local RoleLabel = Instance.new("TextLabel")
RoleLabel.Parent = PlayerInfoFrame
RoleLabel.Size = UDim2.new(1, -80, 0, 18)
RoleLabel.Position = UDim2.new(0, 80, 0, 35)
RoleLabel.BackgroundTransparency = 1
RoleLabel.Text = roleText
RoleLabel.TextColor3 = roleColor
RoleLabel.TextSize = 14
RoleLabel.Font = Enum.Font.Gotham
RoleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Parent = PlayerInfoFrame
TimeLabel.Size = UDim2.new(1, -80, 0, 18)
TimeLabel.Position = UDim2.new(0, 80, 0, 55)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = ""
TimeLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
TimeLabel.TextSize = 13
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
coroutine.wrap(function()
    while TimeLabel and TimeLabel.Parent do
        TimeLabel.Text = os.date("%Y-%m-%d %H:%M:%S")
        task.wait(1)
    end
end)()

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = ContentFrame
WelcomeLabel.Size = UDim2.new(1, -20, 0, 30)
WelcomeLabel.Position = UDim2.new(0, 10, 0, 90)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "欢迎使用 F脚本中心"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 16
WelcomeLabel.Font = Enum.Font.GothamBold

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = ContentFrame
InfoLabel.Size = UDim2.new(1, -20, 0, 80)
InfoLabel.Position = UDim2.new(0, 10, 0, 125)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "点击右侧按钮选择功能\n按住飞行按钮 + 摇杆控制飞行\n作者: "..AUTHOR_NAME
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
InfoLabel.TextSize = 12
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextWrapped = true

-- 环绕选择面板（默认隐藏）
local PlayerSelectFrame = Instance.new("Frame")
PlayerSelectFrame.Name = "PlayerSelectFrame"
PlayerSelectFrame.Parent = MainFrame
PlayerSelectFrame.Size = UDim2.new(1, -20, 1, -20)
PlayerSelectFrame.Position = UDim2.new(0, 10, 0, 10)
PlayerSelectFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
PlayerSelectFrame.BorderSizePixel = 0
PlayerSelectFrame.Visible = false
local PlayerSelectCorner = Instance.new("UICorner"); PlayerSelectCorner.CornerRadius = UDim.new(0,12); PlayerSelectCorner.Parent = PlayerSelectFrame
local SelectTitle = Instance.new("TextLabel"); SelectTitle.Parent = PlayerSelectFrame; SelectTitle.Size = UDim2.new(1,0,0,40); SelectTitle.Position = UDim2.new(0,0,0,10); SelectTitle.BackgroundTransparency = 1; SelectTitle.Text = "选择环绕目标玩家"; SelectTitle.TextColor3 = Color3.fromRGB(255,255,255); SelectTitle.TextSize = 20; SelectTitle.Font = Enum.Font.GothamBold
local SelectCloseBtn = Instance.new("TextButton"); SelectCloseBtn.Parent = PlayerSelectFrame; SelectCloseBtn.Size = UDim2.new(0,30,0,30); SelectCloseBtn.Position = UDim2.new(1,-40,0,10); SelectCloseBtn.BackgroundColor3 = Color3.fromRGB(255,70,70); SelectCloseBtn.Text = "✕"; SelectCloseBtn.TextColor3 = Color3.fromRGB(255,255,255); SelectCloseBtn.TextSize = 16; SelectCloseBtn.Font = Enum.Font.GothamBold; SelectCloseBtn.BorderSizePixel = 0; local SelectCloseCorner = Instance.new("UICorner"); SelectCloseCorner.CornerRadius = UDim.new(0,8); SelectCloseCorner.Parent = SelectCloseBtn
SelectCloseBtn.MouseButton1Click:Connect(function() PlayerSelectFrame.Visible = false end)
local PlayerScroll = Instance.new("ScrollingFrame"); PlayerScroll.Parent = PlayerSelectFrame; PlayerScroll.Size = UDim2.new(1,-20,1,-60); PlayerScroll.Position = UDim2.new(0,10,0,55); PlayerScroll.BackgroundColor3 = Color3.fromRGB(40,40,48); PlayerScroll.BorderSizePixel = 0; PlayerScroll.ScrollBarThickness = 6; PlayerScroll.CanvasSize = UDim2.new(0,0,0,0); PlayerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local PlayerListLayout = Instance.new("UIListLayout"); PlayerListLayout.Parent = PlayerScroll; PlayerListLayout.Padding = UDim.new(0,5)

-- ============================================
-- 功能按钮列表
-- ============================================
local scripts = {
    {name = "✈️ 启用飞行", color = Color3.fromRGB(0, 162, 255), id = "fly"},
    {name = "🔄 旋转脚本", color = Color3.fromRGB(255, 100, 50), id = "spin"},
    {name = "🌀 环绕旋转", color = Color3.fromRGB(150, 50, 255), id = "orbit"},
    {name = "👻 无头效果", color = Color3.fromRGB(100, 100, 100), id = "headless"},
    {name = "🔥 燃烧效果", color = Color3.fromRGB(255, 50, 0), id = "fire"},
    {name = "💨 烟雾效果", color = Color3.fromRGB(150, 150, 150), id = "smoke"},
    {name = "⚡ 加速脚本", color = Color3.fromRGB(255, 220, 0), id = "speed"},
    {name = "🦘 跳跃增强", color = Color3.fromRGB(50, 255, 100), id = "jump"},
    {name = "🧱 穿墙脚本", color = Color3.fromRGB(180, 100, 50), id = "noclip"},
    {name = "👁️ ESP透视", color = Color3.fromRGB(255, 50, 100), id = "esp"},
    {name = "💰 赞助作者", color = Color3.fromRGB(255, 215, 0), id = "sponsor"},
}

-- 创建按钮（含缩放动画）
for i, scriptInfo in ipairs(scripts) do
    local btn = Instance.new("TextButton")
    btn.Name = scriptInfo.id .. "Btn"
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -16, 0, 40)
    btn.Position = UDim2.new(0, 8, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Text = scriptInfo.name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    btn.AutoButtonColor = false

    local btnCorner = Instance.new("UICorner"); btnCorner.CornerRadius = UDim.new(0,8); btnCorner.Parent = btn
    local colorBar = Instance.new("Frame"); colorBar.Size = UDim2.new(0,4,1,0); colorBar.BackgroundColor3 = scriptInfo.color; colorBar.BorderSizePixel = 0; colorBar.Parent = btn
    local colorBarCorner = Instance.new("UICorner"); colorBarCorner.CornerRadius = UDim.new(0,8); colorBarCorner.Parent = colorBar

    local enterTween = TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, 44)})
    local leaveTween = TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -16, 0, 40)})

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55,55,70)}):Play()
        enterTween:Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45,45,55)}):Play()
        leaveTween:Play()
    end)
end

-- ============================================
-- 赞助图片显示（带失败处理）
-- ============================================
local sponsorImage = nil
local sponsorCloseBtn = {}
local sponsorBg = nil

local function clearSponsorDrawings()
    if sponsorImage then sponsorImage:Remove(); sponsorImage = nil end
    for _, d in ipairs(sponsorCloseBtn) do d:Remove() end
    sponsorCloseBtn = {}
    if sponsorBg then sponsorBg:Remove(); sponsorBg = nil end
end

local function showSponsorImage()
    clearSponsorDrawings()
    local imageData
    local success = pcall(function()
        imageData = HttpService:GetAsync(IMAGE_URL)
    end)

    if not success or not imageData then
        pcall(function() setclipboard(IMAGE_URL) end)
        local screenSize = Camera.ViewportSize
        local failBg = Drawing.new("Square"); failBg.Size = Vector2.new(screenSize.X, screenSize.Y); failBg.Position = Vector2.new(0,0); failBg.Color = Color3.fromRGB(0,0,0); failBg.Transparency = 0.7; failBg.Visible = true; table.insert(sponsorCloseBtn, failBg)
        local failText = Drawing.new("Text"); failText.Text = "赞助图片加载失败\n链接已复制到剪贴板\n请用浏览器打开链接查看"; failText.Size = 50; failText.Color = Color3.fromRGB(255,50,50); failText.Font = Drawing.Fonts.System; failText.Center = true; failText.Position = Vector2.new(screenSize.X/2, screenSize.Y/2-50); failText.Visible = true; table.insert(sponsorCloseBtn, failText)
        local linkText = Drawing.new("Text"); linkText.Text = IMAGE_URL; linkText.Size = 20; linkText.Color = Color3.fromRGB(255,255,255); linkText.Font = Drawing.Fonts.System; linkText.Center = true; linkText.Position = Vector2.new(screenSize.X/2, screenSize.Y/2+50); linkText.Visible = true; table.insert(sponsorCloseBtn, linkText)
        local clickConnection
        clickConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                clearSponsorDrawings()
                clickConnection:Disconnect()
            end
        end)
        task.delay(5, function()
            if failBg and failBg.Visible then
                clearSponsorDrawings()
                if clickConnection then clickConnection:Disconnect() end
            end
        end)
        return
    end

    local screenSize = Camera.ViewportSize
    local imgW, imgH = 300, 300
    local posX = screenSize.X/2 - imgW/2
    local posY = screenSize.Y/2 - imgH/2 - 20
    sponsorBg = Drawing.new("Square"); sponsorBg.Size = Vector2.new(screenSize.X, screenSize.Y); sponsorBg.Position = Vector2.new(0,0); sponsorBg.Color = Color3.fromRGB(0,0,0); sponsorBg.Transparency = 0.5; sponsorBg.Visible = true
    sponsorImage = Drawing.new("Image"); sponsorImage.Data = imageData; sponsorImage.Size = Vector2.new(imgW, imgH); sponsorImage.Position = Vector2.new(posX, posY); sponsorImage.Visible = true
    local btnW, btnH = 80, 30; local closeX = posX + imgW/2 - btnW/2; local closeY = posY + imgH + 10
    local closeBg = Drawing.new("Square"); closeBg.Size = Vector2.new(btnW, btnH); closeBg.Position = Vector2.new(closeX, closeY); closeBg.Color = Color3.fromRGB(255,70,70); closeBg.Visible = true; table.insert(sponsorCloseBtn, closeBg)
    local closeText = Drawing.new("Text"); closeText.Text = "关闭"; closeText.Size = 20; closeText.Color = Color3.fromRGB(255,255,255); closeText.Font = Drawing.Fonts.System; closeText.Position = Vector2.new(closeX + btnW/2 - 16, closeY + 4); closeText.Visible = true; table.insert(sponsorCloseBtn, closeText)
    local clickConnection
    clickConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local mousePos = UserInputService:GetMouseLocation()
            if mousePos.X >= closeX and mousePos.X <= closeX + btnW and mousePos.Y >= closeY and mousePos.Y <= closeY + btnH then
                clearSponsorDrawings()
                clickConnection:Disconnect()
            end
        end
    end)
end

local sponsorBtn = ScrollFrame:FindFirstChild("sponsorBtn")
if sponsorBtn then
    sponsorBtn.MouseButton1Click:Connect(showSponsorImage)
end

-- ============================================
-- 飞行系统（浮动按钮 + 摇杆）
-- ============================================
local flyEnabled = false
local flySpeed = 50
local bodyVelocity, bodyGyro
local flyConnection
local flyButtonDown = false

local FlyButton = Instance.new("TextButton")
FlyButton.Parent = ScreenGui
FlyButton.Size = UDim2.new(0, 80, 0, 80)
FlyButton.Position = UDim2.new(1, -100, 1, -120)
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
FlyButton.Text = "✈️"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextSize = 36
FlyButton.Font = Enum.Font.GothamBlack
FlyButton.BorderSizePixel = 0
FlyButton.Visible = false
local FlyButtonCorner = Instance.new("UICorner"); FlyButtonCorner.CornerRadius = UDim.new(1,0); FlyButtonCorner.Parent = FlyButton
local FlyButtonStroke = Instance.new("UIStroke"); FlyButtonStroke.Color = Color3.fromRGB(255,255,255); FlyButtonStroke.Thickness = 3; FlyButtonStroke.Transparency = 0.5; FlyButtonStroke.Parent = FlyButton

local function enableFly()
    local char = LocalPlayer.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    flyEnabled = true
    bodyVelocity = Instance.new("BodyVelocity"); bodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9); bodyVelocity.Velocity = Vector3.new(0,0,0); bodyVelocity.Parent = hrp
    bodyGyro = Instance.new("BodyGyro"); bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9); bodyGyro.P = 9e4; bodyGyro.Parent = hrp
end

local function disableFly()
    flyEnabled = false; flyButtonDown = false
    if bodyVelocity then bodyVelocity:Destroy(); bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy(); bodyGyro = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
end

FlyButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        flyButtonDown = true; FlyButton.BackgroundColor3 = Color3.fromRGB(0,120,200); FlyButtonStroke.Transparency = 0
    end
end)
FlyButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        flyButtonDown = false; FlyButton.BackgroundColor3 = Color3.fromRGB(0,162,255); FlyButtonStroke.Transparency = 0.5
        if bodyVelocity then bodyVelocity.Velocity = Vector3.new(0,0,0) end
    end
end)

local function setupFlyMovement()
    local char = LocalPlayer.Character; if not char then return end
    local hum = char:FindFirstChild("Humanoid"); if not hum then return end
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled or not bodyVelocity then return end
        if not flyButtonDown then bodyVelocity.Velocity = Vector3.new(0,0,0); return end
        local moveDir = hum.MoveDirection
        local look = Camera.CFrame.LookVector
        local right = Camera.CFrame.RightVector
        local fwdDot = moveDir:Dot(look); local sideDot = moveDir:Dot(right)
        local vel = Vector3.new(0,0,0)
        if fwdDot > 0.1 then vel = look * flySpeed
        elseif fwdDot < -0.1 then vel = Vector3.new(0,0,0)
        elseif math.abs(sideDot) > 0.1 then vel = right * math.sign(sideDot) * flySpeed end
        bodyVelocity.Velocity = vel
        if bodyGyro and char:FindFirstChild("HumanoidRootPart") then
            bodyGyro.CFrame = CFrame.new(char.HumanoidRootPart.Position, char.HumanoidRootPart.Position + look)
        end
    end)
end

local flyBtn = ScrollFrame:FindFirstChild("flyBtn")
if flyBtn then
    flyBtn.MouseButton1Click:Connect(function()
        if flyEnabled then
            disableFly(); FlyButton.Visible = false
            flyBtn.Text = "✈️ 启用飞行"; flyBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
            WelcomeLabel.Text = "飞行已关闭"; InfoLabel.Text = "点击启用飞行\n按住飞行按钮 + 摇杆控制"
        else
            enableFly(); setupFlyMovement(); FlyButton.Visible = true
            flyBtn.Text = "✈️ 飞行中..."; flyBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
            WelcomeLabel.Text = "飞行已开启！"; InfoLabel.Text = "按住右下角飞行按钮\n同时用摇杆控制方向"
        end
    end)
end

-- ============================================
-- 旋转脚本
-- ============================================
local spinEnabled = false
local function toggleSpin()
    spinEnabled = not spinEnabled
    local char = LocalPlayer.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if spinEnabled then
        local bav = Instance.new("BodyAngularVelocity"); bav.Name = "SpinVelocity"; bav.AngularVelocity = Vector3.new(0,20,0); bav.MaxTorque = Vector3.new(0,9e9,0); bav.Parent = hrp
    else
        local bav = hrp:FindFirstChild("SpinVelocity"); if bav then bav:Destroy() end
    end
end
local spinBtn = ScrollFrame:FindFirstChild("spinBtn")
if spinBtn then
    spinBtn.MouseButton1Click:Connect(function()
        toggleSpin()
        spinBtn.Text = spinEnabled and "🔄 旋转中..." or "🔄 旋转脚本"
        spinBtn.BackgroundColor3 = spinEnabled and Color3.fromRGB(200,80,40) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = spinEnabled and "旋转已开启" or "旋转已关闭"
    end)
end

-- ============================================
-- 环绕旋转（选择玩家）
-- ============================================
local orbitEnabled = false
local orbitConnection
local orbitTargetPlayer = nil
local orbitAngle = 0

local function stopOrbit()
    orbitEnabled = false
    if orbitConnection then orbitConnection:Disconnect(); orbitConnection = nil end
    orbitTargetPlayer = nil
    local orbitBtn = ScrollFrame:FindFirstChild("orbitBtn")
    if orbitBtn then
        orbitBtn.Text = "🌀 环绕旋转"; orbitBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
    end
    WelcomeLabel.Text = "环绕旋转已关闭"
end

local function refreshPlayerList()
    for _, child in ipairs(PlayerScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -10, 0, 40); pBtn.BackgroundColor3 = Color3.fromRGB(55,55,65)
            pBtn.Text = player.Name; pBtn.TextColor3 = Color3.fromRGB(255,255,255); pBtn.TextSize = 14; pBtn.Font = Enum.Font.GothamBold; pBtn.BorderSizePixel = 0
            local pCorner = Instance.new("UICorner"); pCorner.CornerRadius = UDim.new(0,8); pCorner.Parent = pBtn
            pBtn.MouseButton1Click:Connect(function()
                PlayerSelectFrame.Visible = false
                orbitTargetPlayer = player; orbitEnabled = true; orbitAngle = 0
                if orbitConnection then orbitConnection:Disconnect() end
                orbitConnection = RunService.RenderStepped:Connect(function(dt)
                    if not orbitEnabled or not orbitTargetPlayer or not orbitTargetPlayer.Character or not orbitTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        stopOrbit(); return
                    end
                    local myChar = LocalPlayer.Character; if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
                    local myHRP = myChar.HumanoidRootPart
                    local targetHRP = orbitTargetPlayer.Character.HumanoidRootPart
                    orbitAngle = orbitAngle + dt * 3
                    local radius = 10
                    myHRP.CFrame = CFrame.new(targetHRP.Position + Vector3.new(math.cos(orbitAngle)*radius, 3, math.sin(orbitAngle)*radius))
                end)
                local orbitBtn = ScrollFrame:FindFirstChild("orbitBtn")
                if orbitBtn then
                    orbitBtn.Text = "🌀 环绕中..."; orbitBtn.BackgroundColor3 = Color3.fromRGB(120,40,200)
                end
                WelcomeLabel.Text = "环绕: " .. player.Name
            end)
            pBtn.Parent = PlayerScroll
        end
    end
end

local orbitBtn = ScrollFrame:FindFirstChild("orbitBtn")
if orbitBtn then
    orbitBtn.MouseButton1Click:Connect(function()
        if orbitEnabled then stopOrbit(); return end
        refreshPlayerList(); PlayerSelectFrame.Visible = true
    end)
end

-- ============================================
-- 无头效果
-- ============================================
local headlessEnabled = false
local function toggleHeadless()
    headlessEnabled = not headlessEnabled
    local char = LocalPlayer.Character; if not char then return end
    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = headlessEnabled and 1 or 0
        for _, v in ipairs(head:GetChildren()) do if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = headlessEnabled and 1 or 0 end end
    end
    local neck = char:FindFirstChild("Neck", true)
    if neck and neck:IsA("Motor6D") then neck.Transform = headlessEnabled and CFrame.new(0, -10, 0) or CFrame.new(0,0,0) end
end
local headlessBtn = ScrollFrame:FindFirstChild("headlessBtn")
if headlessBtn then
    headlessBtn.MouseButton1Click:Connect(function()
        toggleHeadless()
        headlessBtn.Text = headlessEnabled and "👻 无头中..." or "👻 无头效果"
        headlessBtn.BackgroundColor3 = headlessEnabled and Color3.fromRGB(80,80,80) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = headlessEnabled and "无头效果已开启" or "无头效果已关闭"
    end)
end

-- ============================================
-- 燃烧效果
-- ============================================
local fireEnabled = false
local fireObj
local function toggleFire()
    fireEnabled = not fireEnabled
    local char = LocalPlayer.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if fireEnabled then
        fireObj = Instance.new("Fire"); fireObj.Size = 8; fireObj.Heat = 10; fireObj.Color = Color3.fromRGB(255,100,0); fireObj.SecondaryColor = Color3.fromRGB(255,200,0); fireObj.Parent = hrp
        local leftFoot = char:FindFirstChild("Left Foot"); local rightFoot = char:FindFirstChild("Right Foot")
        if leftFoot then local f1 = Instance.new("Fire"); f1.Size = 4; f1.Heat = 5; f1.Color = Color3.fromRGB(255,50,0); f1.SecondaryColor = Color3.fromRGB(255,150,0); f1.Name = "ScriptFire"; f1.Parent = leftFoot end
        if rightFoot then local f2 = Instance.new("Fire"); f2.Size = 4; f2.Heat = 5; f2.Color = Color3.fromRGB(255,50,0); f2.SecondaryColor = Color3.fromRGB(255,150,0); f2.Name = "ScriptFire"; f2.Parent = rightFoot end
    else
        if fireObj then fireObj:Destroy(); fireObj = nil end
        for _, part in ipairs(char:GetDescendants()) do if part.Name == "ScriptFire" and part:IsA("Fire") then part:Destroy() end end
    end
end
local fireBtn = ScrollFrame:FindFirstChild("fireBtn")
if fireBtn then
    fireBtn.MouseButton1Click:Connect(function()
        toggleFire()
        fireBtn.Text = fireEnabled and "🔥 燃烧中..." or "🔥 燃烧效果"
        fireBtn.BackgroundColor3 = fireEnabled and Color3.fromRGB(200,40,0) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = fireEnabled and "燃烧效果已开启" or "燃烧效果已关闭"
    end)
end

-- ============================================
-- 烟雾效果
-- ============================================
local smokeEnabled = false
local function toggleSmoke()
    smokeEnabled = not smokeEnabled
    local char = LocalPlayer.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if smokeEnabled then
        local smoke = Instance.new("Smoke"); smoke.Name = "ScriptSmoke"; smoke.Size = 8; smoke.Opacity = 0.5; smoke.RiseVelocity = 3; smoke.Color = Color3.fromRGB(80,80,80); smoke.Parent = hrp
        local leftFoot = char:FindFirstChild("Left Foot"); local rightFoot = char:FindFirstChild("Right Foot")
        if leftFoot then local s1 = Instance.new("Smoke"); s1.Name = "ScriptSmoke"; s1.Size = 4; s1.Opacity = 0.4; s1.RiseVelocity = 2; s1.Color = Color3.fromRGB(60,60,60); s1.Parent = leftFoot end
        if rightFoot then local s2 = Instance.new("Smoke"); s2.Name = "ScriptSmoke"; s2.Size = 4; s2.Opacity = 0.4; s2.RiseVelocity = 2; s2.Color = Color3.fromRGB(60,60,60); s2.Parent = rightFoot end
    else
        for _, part in ipairs(char:GetDescendants()) do if part.Name == "ScriptSmoke" and part:IsA("Smoke") then part:Destroy() end end
    end
end
local smokeBtn = ScrollFrame:FindFirstChild("smokeBtn")
if smokeBtn then
    smokeBtn.MouseButton1Click:Connect(function()
        toggleSmoke()
        smokeBtn.Text = smokeEnabled and "💨 冒烟中..." or "💨 烟雾效果"
        smokeBtn.BackgroundColor3 = smokeEnabled and Color3.fromRGB(120,120,120) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = smokeEnabled and "烟雾效果已开启" or "烟雾效果已关闭"
    end)
end

-- ============================================
-- 加速脚本
-- ============================================
local speedEnabled = false
local originalWalkSpeed = 16
local function toggleSpeed()
    speedEnabled = not speedEnabled
    local char = LocalPlayer.Character; if not char then return end
    local hum = char:FindFirstChild("Humanoid"); if not hum then return end
    if speedEnabled then originalWalkSpeed = hum.WalkSpeed; hum.WalkSpeed = 50
    else hum.WalkSpeed = originalWalkSpeed end
end
local speedBtn = ScrollFrame:FindFirstChild("speedBtn")
if speedBtn then
    speedBtn.MouseButton1Click:Connect(function()
        toggleSpeed()
        speedBtn.Text = speedEnabled and "⚡ 加速中..." or "⚡ 加速脚本"
        speedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(200,170,0) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = speedEnabled and "加速已开启" or "加速已关闭"
    end)
end

-- ============================================
-- 跳跃增强
-- ============================================
local jumpEnabled = false
local originalJumpPower = 50
local function toggleJump()
    jumpEnabled = not jumpEnabled
    local char = LocalPlayer.Character; if not char then return end
    local hum = char:FindFirstChild("Humanoid"); if not hum then return end
    if jumpEnabled then originalJumpPower = hum.JumpPower; hum.JumpPower = 150; hum.UseJumpPower = true
    else hum.JumpPower = originalJumpPower end
end
local jumpBtn = ScrollFrame:FindFirstChild("jumpBtn")
if jumpBtn then
    jumpBtn.MouseButton1Click:Connect(function()
        toggleJump()
        jumpBtn.Text = jumpEnabled and "🦘 超级跳..." or "🦘 跳跃增强"
        jumpBtn.BackgroundColor3 = jumpEnabled and Color3.fromRGB(40,200,80) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = jumpEnabled and "跳跃增强已开启" or "跳跃增强已关闭"
    end)
end

-- ============================================
-- 穿墙脚本
-- ============================================
local noclipEnabled = false
local noclipConnection
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        local char = LocalPlayer.Character
        if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
    end
end
local noclipBtn = ScrollFrame:FindFirstChild("noclipBtn")
if noclipBtn then
    noclipBtn.MouseButton1Click:Connect(function()
        toggleNoclip()
        noclipBtn.Text = noclipEnabled and "🧱 穿墙中..." or "🧱 穿墙脚本"
        noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(140,80,40) or Color3.fromRGB(45,45,55)
        WelcomeLabel.Text = noclipEnabled and "穿墙已开启" or "穿墙已关闭"
    end)
end

-- ============================================
-- ESP 透视
-- ============================================
local espEnabled = false
local espObjects = {}
local function clearESP()
    for _, obj in ipairs(espObjects) do if obj and obj.Parent then obj:Destroy() end end
    espObjects = {}
end
local function createESP()
    clearESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if head and hrp and hum then
                local hl = Instance.new("Highlight"); hl.FillColor = Color3.fromRGB(255,0,0); hl.FillTransparency = 0.7; hl.OutlineColor = Color3.fromRGB(255,255,255); hl.OutlineTransparency = 0; hl.Parent = char
                table.insert(espObjects, hl)
                local bb = Instance.new("BillboardGui"); bb.Adornee = head; bb.Size = UDim2.new(0,100,0,40); bb.StudsOffset = Vector3.new(0,3,0); bb.AlwaysOnTop = true; bb.Parent = char
                local nameLabel = Instance.new("TextLabel"); nameLabel.Size = UDim2.new(1,0,0,20); nameLabel.BackgroundTransparency = 1; nameLabel.Text = player.Name; nameLabel.TextColor3 = Color3.fromRGB(255,255,255); nameLabel.TextSize = 14; nameLabel.Font = Enum.Font.GothamBold; nameLabel.TextStrokeTransparency = 0; nameLabel.Parent = bb
                local healthBg = Instance.new("Frame"); healthBg.Size = UDim2.new(1,0,0,6); healthBg.Position = UDim2.new(0,0,0,22); healthBg.BackgroundColor3 = Color3.fromRGB(50,50,50); healthBg.BorderSizePixel = 0; healthBg.Parent = bb
                local healthBar = Instance.new("Frame"); healthBar.Size = UDim2.new(1,0,1,0); healthBar.BackgroundColor3 = Color3.fromRGB(0,255,0); healthBar.BorderSizePixel = 0; healthBar.Parent = healthBg
                local healthCorner = Instance.new("UICorner"); healthCorner.CornerRadius = UDim.new(0,3); healthCorner.Parent = healthBg
                local distLabel = Instance.new("TextLabel"); distLabel.Size = UDim2.new(1,0,0,14); distLabel.Position = UDim2.new(0,0,0,30); distLabel.BackgroundTransparency = 1; distLabel.Text = ""; distLabel.TextColor3 = Color3.fromRGB(255,255,0); distLabel.TextSize = 11; distLabel.Font = Enum.Font.Gotham; distLabel.TextStrokeTransparency = 0; distLabel.Parent = bb
                table.insert(espObjects, bb)
            end
        end
    end
end
local espUpdateConnection
local function startESPUpdate()
    espUpdateConnection = RunService.RenderStepped:Connect(function()
        if not espEnabled then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local char = player.Character
                local bb = char:FindFirstChild("ESPBillboard")
                local hum = char:FindFirstChild("Humanoid")
                if bb and hum then
                    local distLabel = bb:FindFirstChild("ESPDist")
                    local healthBg = bb:FindFirstChild("HealthBg")
                    local healthBar = healthBg and healthBg:FindFirstChild("HealthBar")
                    if distLabel then
                        local myChar = LocalPlayer.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart") then
                            local dist = math.floor((myChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                            distLabel.Text = dist .. " studs"
                        end
                    end
                    if healthBar then
                        local percent = hum.Health / hum.MaxHealth
                        healthBar.Size = UDim2.new(percent,0,1,0)
                        if percent > 0.5 then healthBar.BackgroundColor3 = Color3.fromRGB(0,255,0)
                        elseif percent > 0.25 then healthBar.BackgroundColor3 = Color3.fromRGB(255,200,0)
                        else healthBar.BackgroundColor3 = Color3.fromRGB(255,0,0) end
                    end
                end
            end
        end
    end)
end
local function stopESPUpdate()
    if espUpdateConnection then espUpdateConnection:Disconnect(); espUpdateConnection = nil end
end
local playerAddedConnection
local function enableESP()
    espEnabled = true; createESP(); startESPUpdate()
    playerAddedConnection = Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function() task.wait(1); if espEnabled then createESP() end end)
    end)
end
local function disableESP()
    espEnabled = false; clearESP(); stopESPUpdate()
    if playerAddedConnection then playerAddedConnection:Disconnect(); playerAddedConnection = nil end
end
local espBtn = ScrollFrame:FindFirstChild("espBtn")
if espBtn then
    espBtn.MouseButton1Click:Connect(function()
        if espEnabled then disableESP()
            espBtn.Text = "👁️ ESP透视"; espBtn.BackgroundColor3 = Color3.fromRGB(45,45,55); WelcomeLabel.Text = "ESP已关闭"
        else enableESP()
            espBtn.Text = "👁️ ESP中..."; espBtn.BackgroundColor3 = Color3.fromRGB(200,40,80); WelcomeLabel.Text = "ESP已开启"
        end
    end)
end

-- ============================================
-- 打开按钮（屏幕边缘）+ 弹入动画
-- ============================================
local openBtn = Instance.new("TextButton")
openBtn.Parent = ScreenGui
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
openBtn.Text = "F"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 24
openBtn.Font = Enum.Font.GothamBlack
openBtn.BorderSizePixel = 0
local openBtnCorner = Instance.new("UICorner"); openBtnCorner.CornerRadius = UDim.new(0,12); openBtnCorner.Parent = openBtn
openBtn.MouseButton1Click:Connect(function()
    if not MainFrame.Visible then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 400)}):Play()
    else
        MainFrame.Visible = false
    end
end)

-- ============================================
-- 重生处理：恢复所有状态
-- ============================================
LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)
    if flyEnabled then
        disableFly(); FlyButton.Visible = false
        task.wait(0.5)
        enableFly(); setupFlyMovement(); FlyButton.Visible = true
    end
    if spinEnabled then
        task.wait(0.5)
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bav = Instance.new("BodyAngularVelocity"); bav.Name = "SpinVelocity"; bav.AngularVelocity = Vector3.new(0,20,0); bav.MaxTorque = Vector3.new(0,9e9,0); bav.Parent = hrp
        end
    end
    if orbitEnabled and orbitTargetPlayer then
        local targetChar = orbitTargetPlayer.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
            task.wait(0.5)
            orbitAngle = 0
            if orbitConnection then orbitConnection:Disconnect() end
            orbitConnection = RunService.RenderStepped:Connect(function(dt)
                if not orbitEnabled or not orbitTargetPlayer or not orbitTargetPlayer.Character or not orbitTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    stopOrbit(); return
                end
                local myChar = LocalPlayer.Character
                if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
                orbitAngle = orbitAngle + dt * 3
                local radius = 10
                myChar.HumanoidRootPart.CFrame = CFrame.new(orbitTargetPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.cos(orbitAngle)*radius, 3, math.sin(orbitAngle)*radius))
            end)
        else
            stopOrbit()
        end
    end
    if headlessEnabled then task.wait(0.5); toggleHeadless(); toggleHeadless() end
    if fireEnabled then task.wait(0.5); toggleFire(); toggleFire() end
    if smokeEnabled then task.wait(0.5); toggleSmoke(); toggleSmoke() end
    if speedEnabled then task.wait(0.5); toggleSpeed(); toggleSpeed() end
    if jumpEnabled then task.wait(0.5); toggleJump(); toggleJump() end
    if noclipEnabled then end
    if espEnabled then task.wait(1); createESP() end
end)
