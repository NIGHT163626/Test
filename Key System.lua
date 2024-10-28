-- UI Library para criação de interfaces no Roblox
local PoisonKeyLib = {}
PoisonKeyLib.__index = PoisonKeyLib

-- Função para criar uma nova instância da biblioteca
function PoisonKeyLib:new()
    local self = setmetatable({}, PoisonKeyLib)
    self.gui = Instance.new('ScreenGui')
    self.gui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')
    return self
end

-- Módulo para inicialização de janela
function PoisonKeyLib:CreateWindow(config)
    local window = Instance.new('Frame')
    window.Size = config.Size or UDim2.new(0, 400, 0, 300)
    window.Position = config.Position or UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = config.BackgroundColor or Color3.new(1, 1, 1)
    window.Parent = self.gui
    return window
end

-- Módulo para criação de botões
function PoisonKeyLib:CreateButton(parent, buttonText, callbacks, options)
    local button = Instance.new('TextButton')
    button.Text = buttonText
    button.Size = options.Size or UDim2.new(0, 100, 0, 50)
    button.BackgroundColor3 = options.BackgroundColor or Color3.new(1, 0, 0)
    button.TextColor3 = options.TextColor or Color3.new(1, 1, 1)

    -- Gerenciamento de eventos
    if callbacks.MouseButton1Click then
        button.MouseButton1Click:Connect(function()
            if callbacks.MouseButton1Click then
                button.BackgroundColor3 = Color3.new(1, 0.5, 0.5)
                callbacks.MouseButton1Click()
                wait(0.1)
                button.BackgroundColor3 = options.BackgroundColor or Color3.new(1, 0, 0)
            end
        end)
    end
    
    if callbacks.MouseEnter then
        button.MouseEnter:Connect(callbacks.MouseEnter)
    end

    if callbacks.MouseLeave then
        button.MouseLeave:Connect(callbacks.MouseLeave)
    end
    
    button.Parent = parent
    return button
end

-- Módulo para criação de TextBox
function PoisonKeyLib:CreateTextBox(parent, placeholderText, options)
    local textBox = Instance.new('TextBox')
    textBox.PlaceholderText = placeholderText
    textBox.Size = options.Size or UDim2.new(0, 200, 0, 50)
    textBox.BackgroundColor3 = options.BackgroundColor or Color3.new(1, 1, 1)
    textBox.TextColor3 = options.TextColor or Color3.new(0, 0, 0)
    
    textBox.Parent = parent
    return textBox
end

return PoisonKeyLib
