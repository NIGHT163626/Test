-- UI Library for Poison Key System

local PoisonKeyLib = {}
PoisonKeyLib.__index = PoisonKeyLib

function PoisonKeyLib:new()
    local self = setmetatable({}, PoisonKeyLib)

    -- Cria a janela principal
    self:CreateWindow()
    
    -- Adiciona os botões
    self:DiscordButton()
    self:PegarKeyButton()
    self:ChecarKeyButton()
    
    -- Adiciona a TextBox
    self:CreateTextBox()

    return self
end

function PoisonKeyLib:CreateWindow()
    local window = Instance.new('ScreenGui')
    local frame = Instance.new('Frame')
    
    -- Configurações de janela
    window.Parent = game.Players.LocalPlayer.PlayerGui
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = window
    self.Window = window
    self.Frame = frame
end

function PoisonKeyLib:DiscordButton()
    local button = Instance.new('ImageButton')
    button.Image = "rbxassetid://11529076255" -- Ícone do Discord
    button.Size = UDim2.new(0, 100, 0, 50)
    button.Position = UDim2.new(0.1, 0, 0.1, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    
    -- Adicionando um texto para melhor usabilidade
    local buttonText = Instance.new('TextLabel')
    buttonText.Text = "Discord"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.Parent = button

    button.MouseButton1Click:Connect(function()
        print("Discord button pressed")
        -- Aqui você pode adicionar a lógica do botão Discord
    end)

    button.Parent = self.Frame
end

function PoisonKeyLib:PegarKeyButton()
    local button = Instance.new('TextButton')
    button.Text = "Pegar Key"
    button.Size = UDim2.new(0, 100, 0, 50)
    button.Position = UDim2.new(0.1, 0, 0.2, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    button.MouseButton1Click:Connect(function()
        print("Pegar Key button pressed")
        -- Aqui você pode adicionar a lógica do botão Pegar Key
    end)

    button.Parent = self.Frame
end

function PoisonKeyLib:ChecarKeyButton()
    local button = Instance.new('TextButton')
    button.Text = "Checar Key"
    button.Size = UDim2.new(0, 100, 0, 50)
    button.Position = UDim2.new(0.1, 0, 0.3, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    button.MouseButton1Click:Connect(function()
        print("Checar Key button pressed")
        -- Aqui você pode adicionar a lógica do botão Checar Key
    end)

    button.Parent = self.Frame
end

function PoisonKeyLib:CreateTextBox()
    local textBox = Instance.new('TextBox')
    textBox.PlaceholderText = "Enter Key"
    textBox.Size = UDim2.new(0, 200, 0, 50)
    textBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)

    textBox.Parent = self.Frame
end

return PoisonKeyLib
