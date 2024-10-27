local PoisonKeyLibrary = {}

-- Inicializa a janela principal
function PoisonKeyLibrary:MakeWindow()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystemGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local borderFrame = Instance.new("Frame")
    borderFrame.Size = UDim2.new(0.45, 0, 0.45, 0)
    borderFrame.Position = UDim2.new(0.275, 0, 0.275, 0)
    borderFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    borderFrame.BorderSizePixel = 0
    borderFrame.Parent = screenGui

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.new(1, 1, 0)
    uiStroke.Thickness = 4
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = borderFrame

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Parent = borderFrame

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 15)
    frameCorner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.Text = "Poison Key System"
    titleLabel.TextColor3 = Color3.new(1, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextSize = 36
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame

    return frame
end

-- Cria um botão
function PoisonKeyLibrary:CreateButton(text, position, parent)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.4, 0, 0.7, 0)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.TextColor3 = Color3.new(1, 1, 0)
    button.BorderSizePixel = 0
    button.TextScaled = true
    button.Parent = parent

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button

    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.new(1, 1, 0)
    buttonStroke.Thickness = 2
    buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    buttonStroke.Parent = button

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.new(0, 0, 0)
    end)

    return button
end

-- Adiciona um callback para o evento de clique do botão
function PoisonKeyLibrary:AddButtonCallback(button, callback)
    button.MouseButton1Click:Connect(callback)
end

-- Cria a interface principal
function PoisonKeyLibrary:CreateUI()
    local mainWindow = self:MakeWindow()

    -- Botão do Discord
    local discordButton = self:CreateButton("Discord", UDim2.new(0.1, 0, 0.2, 0), mainWindow)
    self:AddButtonCallback(discordButton, function()
        print("Botão Discord clicado!")
    end)

    -- TextBox para entrada da chave
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0.15, 0)
    textBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.PlaceholderText = "Digite sua chave..."
    textBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
    textBox.TextScaled = true
    textBox.Parent = mainWindow

    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, 10)
    textBoxCorner.Parent = textBox

    -- Frame para os botões "Pegar Key" e "Checar Key"
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0.2, 0)
    buttonFrame.Position = UDim2.new(0, 0, 0.65, 0)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = mainWindow

    -- Botão "Pegar Key"
    local getKeyButton = self:CreateButton("Pegar Key", UDim2.new(0.1, 0, 0, 0), buttonFrame)
    self:AddButtonCallback(getKeyButton, function()
        print("Botão 'Pegar Key' clicado!")
    end)

    -- Botão "Checar Key"
    local checkKeyButton = self:CreateButton("Checar Key", UDim2.new(0.55, 0, 0, 0), buttonFrame)
    self:AddButtonCallback(checkKeyButton, function()
        print("Botão 'Checar Key' clicado!")
    end)
end

-- Inicializa a biblioteca
PoisonKeyLibrary:CreateUI()

return PoisonKeyLibrary
