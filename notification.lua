local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local Notification = Instance.new("ScreenGui", CoreGui)
Notification["Name"] = "Notification"
Notification["ResetOnSpawn"] = false

local stack = {}

local function text(msg: string, duration: number)
	duration = duration or 4

	local frame = Instance.new("Frame")
	frame["BackgroundColor3"] = Color3.new(0, 0, 0)
	frame["BorderSizePixel"] = 0
	frame["Size"] = UDim2.new(0, 260, 0, 0)
	frame["AnchorPoint"] = Vector2.new(1, 1)
	frame["ClipsDescendants"] = true
	frame.Parent = Notification

	local title = Instance.new("TextLabel")
	title["BackgroundTransparency"] = 1
	title["Text"] = "Haptichub"
	title["TextColor3"] = Color3.new(1, 1, 1)
	title["Font"] = Enum.Font.GothamBold
	title["TextSize"] = 13
	title["TextXAlignment"] = Enum.TextXAlignment.Left
	title["Position"] = UDim2.new(0, 10, 0, 8)
	title["Size"] = UDim2.new(1, -20, 0, 20)
	title.Parent = frame

	local message = Instance.new("TextLabel")
	message["BackgroundTransparency"] = 1
	message["Text"] = msg
	message["TextColor3"] = Color3.new(1, 1, 1)
	message["Font"] = Enum.Font.Gotham
	message["TextSize"] = 11
	message["TextXAlignment"] = Enum.TextXAlignment.Left
	message["TextYAlignment"] = Enum.TextYAlignment.Top
	message["Position"] = UDim2.new(0, 16, 0, 32)
	message["AutomaticSize"] = Enum.AutomaticSize.Y
	message["Size"] = UDim2.new(1, -32, 0, 0)
	message.Parent = frame

	task.wait()
	local textHeight = message.AbsoluteSize.Y
	local totalHeight = 32 + textHeight + 12
	frame["Size"] = UDim2.new(0, 260, 0, totalHeight)

	local timebar = Instance.new("Frame")
	timebar["BackgroundColor3"] = Color3.new(1, 1, 1)
	timebar["BorderSizePixel"] = 0
	timebar["Position"] = UDim2.new(0, 0, 1, -3)
	timebar["Size"] = UDim2.new(1, 0, 0, 3)
	timebar.Parent = frame

	local countdown = Instance.new("TextLabel")
	countdown["BackgroundTransparency"] = 1
	countdown["TextColor3"] = Color3.new(1, 1, 1)
	countdown["Font"] = Enum.Font.GothamBold
	countdown["TextSize"] = 13
	countdown["Position"] = UDim2.new(1, -40, 1, -24)
	countdown["Size"] = UDim2.new(0, 35, 0, 20)
	countdown["TextXAlignment"] = Enum.TextXAlignment.Right
	countdown["Text"] = string.format("%.1f", duration)
	countdown.Parent = frame

	local index = #stack + 1
	table.insert(stack, frame)
	local offset = 20 + (totalHeight + 10) * (index - 1)
	frame.Position = UDim2.new(1, 300, 1, -offset)
	frame.Size = UDim2.new(0, 0, 0, totalHeight)

	TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -20, 1, -offset),
		Size = UDim2.new(0, 260, 0, totalHeight)
	}):Play()
	TweenService:Create(timebar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Size = UDim2.new(0, 0, 0, 3)
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
		TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 300, 1, -offset),
			Size = UDim2.new(0, 0, 0, totalHeight)
		}):Play()
		task.wait(0.3)
		for i, f in ipairs(stack) do
			if f == frame then
				table.remove(stack, i)
				break
			end
		end
		for i, f in ipairs(stack) do
			local h = f.AbsoluteSize.Y
			local y = 20 + (h + 10) * (i - 1)
			TweenService:Create(f, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
				Position = UDim2.new(1, -20, 1, -y)
			}):Play()
		end
		frame:Destroy()
	end)
end

text("cool")
