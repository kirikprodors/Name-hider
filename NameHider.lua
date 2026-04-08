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
MainButton.Draggable = true 

UICorner.Parent = MainButton

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainButton
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(0.9, 0, -0.2, 0)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12.0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Состояние
local namesHidden = false

-- Функция для применения настроек ко всем
local function updateNames()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    if namesHidden then
                        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                    else
                        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                        hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
                    end
                end
            end
        end
    end
end

-- Основной цикл (каждую секунду)
task.spawn(function()
    while true do
        if namesHidden then
            updateNames()
        end
        task.wait(1)
    end
end)

-- Переключение кнопки
MainButton.MouseButton1Click:Connect(function()
    namesHidden = not namesHidden
    if namesHidden then
        MainButton.Text = "Имена: СКРЫТЫ"
        MainButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        updateNames()
    else
        MainButton.Text = "Имена: ВИДНЫ"
        MainButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        updateNames()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    namesHidden = false
    updateNames()
    ScreenGui:Destroy()
end)
