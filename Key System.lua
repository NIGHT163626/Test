-- PoisonKeyLib

local PoisonKeyLib = {}
PoisonKeyLib.__index = PoisonKeyLib

function PoisonKeyLib:new()
    local self = setmetatable({}, PoisonKeyLib)
    self.windows = {}
    return self
end

function PoisonKeyLib:CreateWindow(config)
    local window = Instance.new("Frame")
    window.Name = config.Name or "Window"
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.new(1, 1, 1)
    window.Parent = game.Players.LocalPlayer.PlayerGui

    local titleLabel = Instance.new("TextLabel", window)
    titleLabel.Text = config.Name or "Janela"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)

    table.insert(self.windows, window)
    
    return window
end

function PoisonKeyLib:AddTextBox(config)
    local textBox = Instance.new("TextBox")
    textBox.Name = config.Name or "TextBox"
    textBox.Size = UDim2.new(0, 200, 0, 50)
    textBox.Position = UDim2.new(0.5, -100, 0, 50)
    textBox.PlaceholderText = config.PlaceholderText or "Digite aqui..."
    textBox.TextScaled = true
    textBox.Parent = config.Parent
    
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and config.Callback then
            config.Callback(textBox.Text)
        end
    end)

    return textBox
end

function PoisonKeyLib:AddButton(window, buttonConfig)
    local button = Instance.new("TextButton")
    button.Name = buttonConfig.Name or "Button"
    button.Size = UDim2.new(0, 100, 0, 50)
    button.Position = UDim2.new(0.5, -50, #window:GetChildren() * 55 + 60, 0)
    button.Text = buttonConfig.Name
    button.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    button.Parent = window
    
    button.MouseButton1Click:Connect(function()
        if buttonConfig.Callback then
            buttonConfig.Callback()  -- Chama a função específica para cada botão
        end
    end)
end

return PoisonKeyLib
