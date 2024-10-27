-- Key System UI Library

local PoisonKeyLib = {}
PoisonKeyLib.__index = PoisonKeyLib

-- Função para criar uma nova janela
function PoisonKeyLib:MakeWindow(options)
    local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    screenGui.Name = options.Name .. "Gui"

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
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Parent = borderFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = options.Title or "Poison Key System"
    titleLabel.TextColor3 = Color3.new(1, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextSize = 36
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame

    -- Botão Discord
    local discordButton = Instance.new("TextButton")
    discordButton.Size = UDim2.new(0.3, 0, 0.12, 0)
    discordButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    discordButton.BackgroundColor3 = Color3.new(0.5, 0.5, 1)
    discordButton.BorderSizePixel = 0
    discordButton.Text = "Discord"
    discordButton.Name = "DiscordButton" -- Nome do botão
    discordButton.Parent = frame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 10)
    discordCorner.Parent = discordButton

    -- TextBox para entrada da chave
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0.15, 0)
    textBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.PlaceholderText = "Digite sua chave..."
    textBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
    textBox.TextScaled = true
    textBox.Name = "KeyInput" -- Nome da TextBox
    textBox.Parent = frame

    -- Frame para os botões "Pegar Key" e "Checar Key"
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0.2, 0)
    buttonFrame.Position = UDim2.new(0, 0, 0.65, 0)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = frame

    -- Função para criar botões
    local function createButton(text, position, buttonName)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.4, 0, 0.7, 0)
        button.Position = position
        button.Text = text
        button.BackgroundColor3 = Color3.new(0, 0, 0)
        button.TextColor3 = Color3.new(1, 1, 0)
        button.BorderSizePixel = 0
        button.TextScaled = true
        button.Font = Enum.Font.SourceSansBold
        button.Name = buttonName -- Nome do botão
        button.Parent = buttonFrame

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = button

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.new(0, 0, 0)
        end)

        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = Color3.new(1, 1, 0)
        buttonStroke.Thickness = 2
        buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        buttonStroke.Parent = button

        return button
    end

    -- Botões "Pegar Key" e "Checar Key" com nomes
    local getKeyButton = createButton("Pegar Key", UDim2.new(0.1, 0, 0, 0), "GetKeyButton")
    local checkKeyButton = createButton("Checar Key", UDim2.new(0.55, 0, 0, 0), "CheckKeyButton")

    -- Função para o botão Discord
    discordButton.MouseButton1Click:Connect(function()
        print("Botão Discord clicado!")
    end)

    -- Conecta os eventos dos botões
    getKeyButton.MouseButton1Click:Connect(function()
        print("Botão Pegar Key clicado!") -- Ação para pegar a key
    end)

    checkKeyButton.MouseButton1Click:Connect(function()
        print("Botão Checar Key clicado!") -- Ação para checar a key
    end)

    return self
end

return PoisonKeyLib
