-- ============================================
-- F脚本中心 - 启动选择器
-- 作者：你的名字
-- 上传到 GitHub 仓库后分享此脚本给用户
-- ============================================

-- ★★★ 替换为你仓库里 Main.lua 的 raw 链接 ★★★
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/你的用户名/你的仓库/main/Main.lua"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- ============================================
-- 选择窗口
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FLoader"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- 标题
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "选择脚本版本"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

-- 旧脚本按钮
local OldBtn = Instance.new("TextButton")
OldBtn.Parent = MainFrame
OldBtn.Size = UDim2.new(0, 200, 0, 40)
OldBtn.Position = UDim2.new(0.5, -100, 0, 50)
OldBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
OldBtn.Text = "🔧 旧脚本 (v4.0)"
OldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OldBtn.TextSize = 16
OldBtn.Font = Enum.Font.GothamBold
OldBtn.BorderSizePixel = 0
local OldCorner = Instance.new("UICorner"); OldCorner.CornerRadius = UDim.new(0,6); OldCorner.Parent = OldBtn

-- 新脚本按钮
local NewBtn = Instance.new("TextButton")
NewBtn.Parent = MainFrame
NewBtn.Size = UDim2.new(0, 200, 0, 40)
NewBtn.Position = UDim2.new(0.5, -100, 0, 100)
NewBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NewBtn.Text = "✨ 新脚本 (即将推出)"
NewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NewBtn.TextSize = 16
NewBtn.Font = Enum.Font.GothamBold
NewBtn.BorderSizePixel = 0
local NewCorner = Instance.new("UICorner"); NewCorner.CornerRadius = UDim.new(0,6); NewCorner.Parent = NewBtn

-- ============================================
-- 按钮功能
-- ============================================

-- 加载旧脚本
local function loadOldScript()
    ScreenGui:Destroy()  -- 关闭选择窗口
    local success, scriptContent = pcall(function()
        return game:HttpGet(MAIN_SCRIPT_URL)
    end)
    if success and scriptContent then
        local loadSuccess, err = pcall(function()
            loadstring(scriptContent)()
        end)
        if not loadSuccess then
            warn("旧脚本执行失败:", err)
        end
    else
        warn("无法加载旧脚本，请检查网络或 URL 是否正确")
    end
end

-- 新脚本提示
local function showNewNotice()
    NewBtn.Text = "⏳ 周六开放"
    NewBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    task.delay(2, function()
        NewBtn.Text = "✨ 新脚本 (即将推出)"
        NewBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "新脚本",
        Text = "新脚本将在周六正式开启，敬请期待！",
        Duration = 4
    })
end

OldBtn.MouseButton1Click:Connect(loadOldScript)
NewBtn.MouseButton1Click:Connect(showNewNotice)

-- 关闭按钮
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner"); CloseCorner.CornerRadius = UDim.new(0,6); CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
