local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local Notification = Instance.new("ScreenGui", CoreGui)
Notification["Name"] = "Notification"
Notification["ResetOnSpawn"] = false

local notification = nil

local function text(msg: string, duration: number)
    duration = duration or 4
    if notification then
        notification:Destroy()
        notification = nil
    end

    local frame = Instance.new("Frame")
    frame["BackgroundColor3"] = Color3.new(0, 0, 0)
    frame["BorderSizePixel"] = 0
    frame["Size"] = UDim2.new(0, 300, 0, 0) -- start small for animation
    frame["Position"] = UDim2.new(1, 320, 1, -20)
    frame["AnchorPoint"] = Vector2.new(1, 1)
    frame["ClipsDescendants"] = true
    frame.Parent = Notification

    local title = Instance.new("TextLabel")
    title["BackgroundTransparency"] = 1
    title["Text"] = "Haptichub"
    title["TextColor3"] = Color3.new(1, 1, 1)
    title["Font"] = Enum.Font.GothamBold
    title["TextSize"] = 13.5 -- 25% smaller than 18
    title["TextXAlignment"] = Enum.TextXAlignment.Left
    title["Position"] = UDim2.new(0, 10, 0, 8)
    title["Size"] = UDim2.new(1, -20, 0, 24)
    title.Parent = frame

    local message = Instance.new("TextLabel")
    message["BackgroundTransparency"] = 1
    message["Text"] = msg
    message["TextColor3"] = Color3.new(1, 1, 1)
    message["Font"] = Enum.Font.Gotham
    message["TextSize"] = 12 -- 25% smaller than 16
    message["TextXAlignment"] = Enum.TextXAlignment.Left
    message["TextYAlignment"] = Enum.TextYAlignment.Top
    message["Position"] = UDim2.new(0, 14, 0, 36) -- moved 4 pixels right
    message["AutomaticSize"] = Enum.AutomaticSize.Y
    message["Size"] = UDim2.new(1, -24, 0, 0) -- reduced width by 4 pixels (10 + 14 margin)
    message.Parent = frame

    task.wait()
    local textHeight = message.AbsoluteSize.Y
    local totalHeight = 36 + textHeight + 14
    frame["Size"] = UDim2.new(0, 300, 0, totalHeight)

    local timebar = Instance.new("Frame")
    timebar["BackgroundColor3"] = Color3.new(1, 1, 1)
    timebar["BorderSizePixel"] = 0
    timebar["Position"] = UDim2.new(0, 0, 1, -6)
    timebar["Size"] = UDim2.new(1, 0, 0, 6)
    timebar.Parent = frame

    local countdown = Instance.new("TextLabel")
    countdown["BackgroundTransparency"] = 1
    countdown["TextColor3"] = Color3.new(1, 1, 1)
    countdown["Font"] = Enum.Font.GothamBold
    countdown["TextSize"] = 13.5 -- 25% smaller than 18
    countdown["Position"] = UDim2.new(1, -40, 1, -28)
    countdown["Size"] = UDim2.new(0, 35, 0, 22)
    countdown["TextXAlignment"] = Enum.TextXAlignment.Right
    countdown["Text"] = string.format("%.1f", duration)
    countdown.Parent = frame

    notification = frame

    frame.Position = UDim2.new(1, 320, 1, -20)
    frame.Size = UDim2.new(0, 0, 0, totalHeight)
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.new(0, 300, 0, totalHeight)
    }):Play()
    TweenService:Create(timebar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 6)
    }):Play()

    task.spawn(function()
        local timeLeft = duration
        while timeLeft > 0 do
            countdown["Text"] = string.format("%.1f", timeLeft)
            timeLeft -= 0.1
            task.wait(0.1)
        end
        countdown["Text"] = "0.0"
    end)

    task.delay(duration, function()
        TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 320, 1, -20),
            Size = UDim2.new(0, 0, 0, totalHeight)
        }):Play()
        task.wait(0.4)
        if notification == frame then
            notification = nil
        end
        frame:Destroy()
    end)
end

text("HapticHub On Top!")
