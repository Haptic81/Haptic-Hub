-- Made By Haptic

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.Parent = guiParent

local txt = Instance.new("TextLabel")
txt.AnchorPoint = Vector2.new(0.5, 0.5)
txt.Position = UDim2.new(0.5, 0, 0.5, 0)
txt.Size = UDim2.new(0, 300, 0, 40)
txt.BackgroundTransparency = 1
txt.Text = "HAPTIC-HUB"
txt.TextColor3 = Color3.new(0, 0, 0)
txt.Font = Enum.Font.GothamBold
txt.TextScaled = true
txt.RichText = true
txt.TextTransparency = 1
txt.Parent = gui

TweenService:Create(blur, TweenInfo.new(1), {Size = 20}):Play()
TweenService:Create(txt, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
task.wait(1.5)

local str = txt.Text
for i = 1, #str do
    local t = ""
    for j = 1, #str do
        local c = str:sub(j, j)
        if j <= i then
            t = t .. "<font color=\"rgb(60,60,60)\">" .. c .. "</font>"
        else
            t = t .. "<font color=\"rgb(0,0,0)\">" .. c .. "</font>"
        end
    end
    txt.Text = t
    task.wait(0.1)
end

task.wait(1)
TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()
TweenService:Create(txt, TweenInfo.new(1), {TextTransparency = 1}):Play()
task.wait(1)
gui:Destroy()
blur:Destroy()
