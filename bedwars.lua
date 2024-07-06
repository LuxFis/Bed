-- Скрипт для Bed Wars в Роблоксе на платформе Delta с функцией "под собой ставилась шерсть"

-- Импорт библиотеки Delta для работы с UI и игровыми объектами
local Delta = require(game:GetService("ReplicatedStorage").Delta)

-- Переменная для хранения текущего состояния функции
local woolUnderPlayerEnabled = false

-- Функция для создания меню
function createMenu()
    -- Создание фрейма для меню
    local menuFrame = Delta.UI.CreateFrame({
        Size = UDim2.new(0.1, 0, 0.06, 0),  -- Размеры меню (10x6 см)
        Position = UDim2.new(0.45, 0, 0.45, 0),  -- Положение меню (центрировано)
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),  -- Цвет фона (темный)
        BorderSizePixel = 2,  -- Толщина рамки
        BorderColor3 = Color3.fromRGB(50, 50, 50),  -- Цвет рамки
        CornerRadius = UDim.new(0.1, 0)  -- Сглаживание углов
    })

    -- Добавление кнопки для килл аура
    local killAuraButton = Delta.UI.CreateButton({
        Parent = menuFrame,
        Size = UDim2.new(0.8, 0, 0.1, 0),
        Position = UDim2.new(0.1, 0, 0.1, 0),
        Text = "Kill Aura",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        CornerRadius = UDim.new(0.05, 0)
    })
    
    -- Добавление кнопки для анти войда
    local antiVoidButton = Delta.UI.CreateButton({
        Parent = menuFrame,
        Size = UDim2.new(0.8, 0, 0.1, 0),
        Position = UDim2.new(0.1, 0, 0.25, 0),
        Text = "Anti Void",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        CornerRadius = UDim.new(0.05, 0)
    })
    
    -- Добавление кнопки для ускорения в 2 раза
    local speedBoostButton = Delta.UI.CreateButton({
        Parent = menuFrame,
        Size = UDim2.new(0.8, 0, 0.1, 0),
        Position = UDim2.new(0.1, 0, 0.4, 0),
        Text = "Speed x2",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        CornerRadius = UDim.new(0.05, 0)
    })

    -- Функция для под собой ставилась шерсть
    local function enableWoolUnderPlayer()
        woolUnderPlayerEnabled = true
        
        -- Функция для размещения шерсти под персонажем
        local function placeWool()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            
            -- Создание шерсти под персонажем
            local woolBlock = Delta.World.CreateBlock({
                Size = Vector3.new(4, 1, 4),  -- Размер блока шерсти
                Position = humanoidRootPart.Position - Vector3.new(0, 2, 0),  -- Позиция под персонажем
                Material = Enum.Material.Neon,  -- Материал шерсти
                Color = Color3.fromRGB(255, 255, 255)  -- Цвет шерсти
            })
        end
        
        -- Вызов функции размещения шерсти каждые 0.1 секунды
        spawn(function()
            while woolUnderPlayerEnabled do
                wait(0.1)
                placeWool()
            end
        end)
    end

    -- Функция для отключения под собой ставилась шерсть
    local function disableWoolUnderPlayer()
        woolUnderPlayerEnabled = false
    end

    -- Добавление функций к кнопкам
    killAuraButton.MouseButton1Click:Connect(function()
        -- Добавьте здесь функционал для килл аура
    end)
    
    antiVoidButton.MouseButton1Click:Connect(function()
        -- Добавьте здесь функционал для анти войда
    end)
    
    speedBoostButton.MouseButton1Click:Connect(function()
        -- Добавьте здесь функционал для ускорения в 2 раза
    end)

    -- Добавление кнопки для включения/выключения функции шерсти под персонажем
    local toggleWoolButton = Delta.UI.CreateButton({
        Parent = menuFrame,
        Size = UDim2.new(0.8, 0, 0.1, 0),
        Position = UDim2.new(0.1, 0, 0.55, 0),
        Text = "Toggle Wool Under Player",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        CornerRadius = UDim.new(0.05, 0)
    })
    toggleWoolButton.MouseButton1Click:Connect(function()
        if woolUnderPlayerEnabled then
            disableWoolUnderPlayer()
        else
            enableWoolUnderPlayer()
        end
    end)

    -- Функция для открытия/закрытия меню при нажатии на кнопку
    local isOpen = false
    local openButton = Delta.UI.CreateButton({
        Size = UDim2.new(0.05, 0, 0.05, 0),  -- Размер кнопки
        Position = UDim2.new(0.95, 0, 0.45, 0),  -- Позиция кнопки (вверху справа)
        Text = "Menu",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        CornerRadius = UDim.new(1, 0)  -- Круглый угол
    })
    openButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        menuFrame.Visible = isOpen
    end)
end

-- Вызов функции для создания меню при запуске скрипта
createMenu()