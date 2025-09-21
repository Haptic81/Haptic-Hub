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

local textLabel = Instance.new("TextLabel")
textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
textLabel.Size = UDim2.new(0, 300, 0, 40)
textLabel.BackgroundTransparency = 1
textLabel.Text = "HAPTIC-HUB"
textLabel.TextColor3 = Color3.new(0, 0, 0)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextScaled = true
textLabel.RichText = true
textLabel.TextTransparency = 1
textLabel.Parent = gui

TweenService:Create(blur, TweenInfo.new(1), {Size = 20}):Play()
TweenService:Create(textLabel, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
task.wait(1.5)

local text = textLabel.Text
for i = 1, #text do
    local formattedText = ""
    for j = 1, #text do
        local c = text:sub(j, j)
        if j <= i then
            formattedText = formattedText .. "<font color=\"rgb(60,60,60)\">" .. c .. "</font>"
        else
            formattedText = formattedText .. "<font color=\"rgb(0,0,0)\">" .. c .. "</font>"
        end
    end
    textLabel.Text = formattedText
    task.wait(0.1)
end

task.wait(1)
TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()
TweenService:Create(textLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
task.wait(1)
gui:Destroy()
blur:Destroy()
