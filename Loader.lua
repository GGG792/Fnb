-- ============================================
-- F脚本中心 启动器 (修复版)
-- 点击按钮自动下载并执行 Main.lua
-- ============================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MAIN_URL = "https://raw.githubusercontent.com/GGG792/Fnb/main/Main.lua"

-- 创建一个简单的启动窗口
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoaderGui"
ScreenGui.Parent = LocalPlayer.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "🚀 F脚本中心 启动器"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

local StartBtn = Instance.new("TextButton")
StartBtn.Parent = Frame
StartBtn.Size = UDim2.new(0, 200, 0, 50)
StartBtn.Position = UDim2.new(0.5, -100, 0, 60)
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
StartBtn.Text = "启动脚本"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextSize = 20
StartBtn.Font = Enum.Font.GothamBold
StartBtn.BorderSizePixel = 0

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = StartBtn

StartBtn.MouseButton1Click:Connect(function()
    -- 点击后启动主脚本
    local success, err = pcall(function()
        loadstring(game:HttpGet(MAIN_URL))()
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "启动失败",
            Text = "错误: " .. tostring(err),
            Duration = 5
        })
    else
        ScreenGui:Destroy()  -- 启动成功后关闭启动器
    end
end)
