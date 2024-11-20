-- Criando a GUI
local KeySystemGui = Instance.new("ScreenGui")
KeySystemGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = KeySystemGui

-- Bordas amarelas
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromHex("#EFEA26")
FrameStroke.Thickness = 3
FrameStroke.Parent = MainFrame

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -40, 0, 0)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextScaled = true
Close.TextColor3 = Color3.fromRGB(150, 150, 150)
Close.Parent = MainFrame
Close.MouseButton1Click:Connect(function()
    KeySystemGui:Destroy()
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 100)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Poison Key System"
Title.TextSize = 48
Title.TextColor3 = Color3.fromHex("#EFEA26")
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- TextBox para chave
local TextBoxHolder = Instance.new("Frame")
TextBoxHolder.Size = UDim2.new(0.8, 0, 0.2, 0)
TextBoxHolder.Position = UDim2.new(0.1, 0, 0.3, 0)
TextBoxHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextBoxHolder.ClipsDescendants = true
TextBoxHolder.Parent = MainFrame

local TextBoxHolderCorner = Instance.new("UICorner")
TextBoxHolderCorner.CornerRadius = UDim.new(0, 5)
TextBoxHolderCorner.Parent = TextBoxHolder

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -10, 1, -10)
TextBox.Position = UDim2.new(0, 5, 0, 5)
TextBox.BackgroundTransparency = 1
TextBox.PlaceholderText = "Enter Key"
TextBox.Text = ""
TextBox.TextSize = 18
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextXAlignment = Enum.TextXAlignment.Center
TextBox.TextYAlignment = Enum.TextYAlignment.Center
TextBox.ClearTextOnFocus = false
TextBox.Parent = TextBoxHolder

-- Variáveis getgenv para o valor da chave
getgenv().Key = ""

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    getgenv().Key = TextBox.Text
end)

-- Função para criar botões
local function createButton(text, size, position, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.Text = text
    button.TextSize = 24
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.Parent = parent

    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromHex("#EFEA26")
    buttonStroke.Thickness = 2
    buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    buttonStroke.Parent = button

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = button

    button.MouseButton1Click:Connect(callback)
    return button
end

-- Variáveis getgenv para os botões
getgenv().GetKeyAction = function()
    local getKeyLink = "https://www.exemplo.com/pegar-key"  -- Coloque o link correto aqui
    setclipboard(getKeyLink)  -- Copia o link para a área de transferência
    print("Link de Get Key copiado!")
end

getgenv().CheckKeyAction = function()
    local key = getgenv().Key
    if key == "" then
        print("Por favor, insira uma chave.")
    else
        print("Verificando chave: " .. key)
    end
end

getgenv().DiscordAction = function()
    print("Discord button clicked")
end

-- Botões com getgenv
local GetKeyButton = createButton("Get Key", UDim2.new(0.35, 0, 0.15, 0), UDim2.new(0.1, 0, 0.55, 0), MainFrame, getgenv().GetKeyAction)

local CheckKeyButton = createButton("Check Key", UDim2.new(0.35, 0, 0.15, 0), UDim2.new(0.55, 0, 0.55, 0), MainFrame, getgenv().CheckKeyAction)

local DiscordButton = createButton("", UDim2.new(0.35, 0, 0.15, 0), UDim2.new(0.325, 0, 0.75, 0), MainFrame, getgenv().DiscordAction)

-- Ícone do Discord
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(0, 35, 0, 35)
Icon.Position = UDim2.new(0, 20, 0.5, -17)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://84828491431270"
Icon.Parent = DiscordButton

local DiscordText = Instance.new("TextLabel")
DiscordText.Size = UDim2.new(1, -60, 1, 0)
DiscordText.Position = UDim2.new(0, 40, 0, 0)
DiscordText.BackgroundTransparency = 1
DiscordText.Text = "Discord"
DiscordText.TextSize = 24
DiscordText.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordText.Font = Enum.Font.SourceSansBold
DiscordText.TextXAlignment = Enum.TextXAlignment.Center
DiscordText.Parent = DiscordButton
