local PoisonKeyLib = {}
PoisonKeyLib.__index = PoisonKeyLib

-- Inicialização da biblioteca
function PoisonKeyLib:Initialize()
    -- Cria a ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystemGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Cria um Frame para a borda
    local borderFrame = Instance.new("Frame")
    borderFrame.Size = UDim2.new(0.45, 0, 0.45, 0)
    borderFrame.Position = UDim2.new(0.275, 0, 0.275, 0)
    borderFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    borderFrame.BorderSizePixel = 0
    borderFrame.Parent = screenGui

    -- Adiciona um UIStroke para criar uma borda
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.new(1, 1, 0)
    uiStroke.Thickness = 4
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = borderFrame

    -- Cria um Frame para a GUI
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Parent = borderFrame

    -- Adiciona bordas arredondadas ao frame
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 15)
    frameCorner.Parent = frame

    -- Cria um Label para o título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "Poison Key System"
    titleLabel.TextColor3 = Color3.new(1, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextSize = 36
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame

    -- Cria o botão para o Discord
    local discordButton = Instance.new("TextButton")
    discordButton.Size = UDim2.new(0.3, 0, 0.12, 0)
    discordButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    discordButton.BackgroundColor3 = Color3.new(0.5, 0.5, 1)
    discordButton.BorderSizePixel = 0
    discordButton.Text = ""
    discordButton.Parent = frame

    -- Adiciona bordas arredondadas ao botão Discord
    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 10)
    discordCorner.Parent = discordButton

    -- Adiciona o ícone do Discord ao botão
    local discordIcon = Instance.new("ImageLabel")
    discordIcon.Size = UDim2.new(0.3, 0, 1, 0)
    discordIcon.Position = UDim2.new(0.05, 0, 0, 0)
    discordIcon.Image = "rbxassetid://11529076255"
    discordIcon.BackgroundTransparency = 1
    discordIcon.Parent = discordButton

    -- Ajusta a Label com o nome "Discord" ao lado do ícone
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Size = UDim2.new(0.5, 0, 1, 0)
    discordLabel.Position = UDim2.new(0.35, 0, 0, 0)
    discordLabel.Text = "Discord"
    discordLabel.TextColor3 = Color3.new(1, 1, 1)
    discordLabel.BackgroundTransparency = 1
    discordLabel.TextSize = 20
    discordLabel.Font = Enum.Font.SourceSansBold
    discordLabel.TextScaled = true
    discordLabel.Parent = discordButton

    -- Cria a TextBox para entrada da chave
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0.15, 0)
    textBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.PlaceholderText = "Enter Key"
    textBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
    textBox.Text = ""
    textBox.TextScaled = true
    textBox.Parent = frame

    -- Adiciona bordas arredondadas ao TextBox
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, 10)
    textBoxCorner.Parent = textBox

    -- Cria um Frame para os botões "Pegar Key" e "Checar Key"
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0.2, 0)
    buttonFrame.Position = UDim2.new(0, 0, 0.65, 0)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = frame

    -- Função para criar botões com estilo e callback
    function PoisonKeyLib:AddButton(name, callback, position)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.4, 0, 0.7, 0)
        button.Position = position
        button.Text = name
        button.BackgroundColor3 = Color3.new(0, 0, 0)
        button.TextColor3 = Color3.new(1, 1, 0)
        button.BorderSizePixel = 0
        button.TextScaled = true
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 30
        button.Parent = buttonFrame

        -- Adiciona bordas arredondadas ao botão
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = button

        -- Efeito de hover
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.new(0, 0, 0)
        end)

        -- Adiciona uma borda amarela
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = Color3.new(1, 1, 0)
        buttonStroke.Thickness = 2
        buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        buttonStroke.Parent = button

        -- Conecta o callback ao evento de clique
        button.MouseButton1Click:Connect(callback)

        return button
    end

    -- Cria os botões "Pegar Key" e "Checar Key" com callbacks
    self:AddButton("Pegar Key", function()
        print("Pegar Key clicado!")
        -- Lógica para pegar a key
    end, UDim2.new(0.1, 0, 0, 0))

    self:AddButton("Checar Key", function()
        print("Checar Key clicado!")
        -- Lógica para checar a key
    end, UDim2.new(0.55, 0, 0, 0))

    return self
end

-- Função para criar uma nova instância da biblioteca
function PoisonKeyLib:new()
    local self = setmetatable({}, PoisonKeyLib)
    return self:Initialize()
end

return PoisonKeyLib
