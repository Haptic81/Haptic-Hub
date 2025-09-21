local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.Parent = guiParent

local notificationFolder = Instance.new("Folder")
notificationFolder.Name = "Notifications"
notificationFolder.Parent = screenGui

local notifications = {}

local spacing = 5
local width = 200
local height = 50
local margin = 10

local function text(message)
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, width, 0, height)
    notification.AnchorPoint = Vector2.new(1,1)
    notification.Position = UDim2.new(1, width + margin, 1, -margin)
    notification.BackgroundTransparency = 0.6
    notification.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    notification.BorderSizePixel = 0
    notification.Parent = notificationFolder

    local label = Instance.new("TextLabel")
    label.Text = message
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.new(0,5,0,5)
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = notification

    table.insert(notifications, 1, notification)

    for i, notif in ipairs(notifications) do
        local goalPosition = UDim2.new(1, -margin, 1, -margin - (height + spacing)*(i-1))
        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = goalPosition}):Play()
    end

    TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -margin, 1, -margin)}):Play()

    task.delay(5, function()
        TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, width + margin, 1, -margin)}):Play()
        task.wait(0.5)
        for i, notif in ipairs(notifications) do
            if notif == notification then
                table.remove(notifications, i)
                break
            end
        end
        notification:Destroy()

        for i, notif in ipairs(notifications) do
            local goalPosition = UDim2.new(1, -margin, 1, -margin - (height + spacing)*(i-1))
            TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = goalPosition}):Play()
        end
    end)
end

text("Click Insert Key         Toggle UI")
