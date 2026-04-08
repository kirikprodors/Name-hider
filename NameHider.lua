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
CloseButton.Position = UDim2.new(0.85, 0, -0.2, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 50)
CloseCorner.Parent = CloseButton

-- Состояние
local namesHidden = false

-- Функция для скрытия ника у конкретного игрока
local function setCharacterNameVisible(character, visible)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- HealthDisplayType тоже убираем, чтобы полоска хп не палила игрока
        humanoid.DisplayDistanceType = visible and Enum.HumanoidDisplayDistanceType.Viewer or Enum.HumanoidDisplayDistanceType.None
        humanoid.HealthDisplayType = visible and Enum.HumanoidHealthDisplayType.DisplayWhenDamaged or Enum.HumanoidHealthDisplayType.AlwaysOff
    end
end

-- Основная функция переключения
local function toggleNames()
    namesHidden = not namesHidden
    MainButton.Text = namesHidden and "Показать имена" or "Скрыть имена"
    MainButton.BackgroundColor3 = namesHidden and Color3.fromRGB(70, 150, 70) or Color3.fromRGB(45, 45, 45)
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player.Character then
            setCharacterNameVisible(player.Character, not namesHidden)
        end
    end
end

-- Цикл авто-обновления (работает каждые 2 секунды)
task.spawn(function()
    while task.wait(2) do
        if namesHidden then
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player.Character then
                    setCharacterNameVisible(player.Character, false)
                end
            end
        end
    end
end)

MainButton.MouseButton1Click:Connect(toggleNames)

CloseButton.MouseButton1Click:Connect(function()
    namesHidden = false
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player.Character then setCharacterNameVisible(player.Character, true) end
    end
    ScreenGui:Destroy()
end)
