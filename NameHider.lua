local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Настройки GUI
ScreenGui.Name = "NameHiderGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainButton.Name = "MainButton"
MainButton.Parent = ScreenGui
MainButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MainButton.Size = UDim2.new(0, 150, 0, 50)
MainButton.Font = Enum.Font.GothamBold
MainButton.Text = "Скрыть имена"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.TextSize = 14.0
MainButton.Draggable = true -- Включаем стандартное перетаскивание

UICorner.Parent = MainButton

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainButton
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(0.85, 0, -0.2, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 50)
CloseCorner.Parent = CloseButton

-- Переменные состояния
local namesHidden = false

-- Функция переключения видимости имен
local function toggleNames()
    namesHidden = not namesHidden
    
    if namesHidden then
        MainButton.Text = "Показать имена"
        MainButton.BackgroundColor3 = Color3.fromRGB(70, 150, 70)
    else
        MainButton.Text = "Скрыть имена"
        MainButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end

    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.DisplayDistanceType = namesHidden and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
            end
        end
    end
end

-- Обработка новых игроков
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if namesHidden then
            local hum = char:WaitForChild("Humanoid")
            hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end
    end)
end)

-- События кнопок
MainButton.MouseButton1Click:Connect(toggleNames)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
