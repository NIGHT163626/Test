local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- KeyGuardLibrary para validação de chaves
local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "7ebff39e27ec487e9b68441eed432b27" -- Resposta para chave válida
local falseData = "a4b04d06e9d94496bb08cb236e6b1acd" -- Resposta para chave inválida

-- Configuração da KeyGuardLibrary
KeyGuardLibrary.Set({
  publicToken = "2a8b38bec39e4f51b7e41a00c2d44138",
  privateToken = "e4631e4fd40d4b86a1eb67909a3d377d",
  trueData = trueData,
  falseData = falseData,
})

local key = ""

-- Tabela para funções do Prometheus (loader)
local Prometheus = {}

-- Função para criar um loader visual
function Prometheus.createLoader(title)
    local existingGui = CoreGui:FindFirstChild("PrometheusLoader")
    if existingGui then existingGui:Destroy() end

    -- ScreenGui (Loader)
    local loaderGui = Instance.new("ScreenGui")
    loaderGui.Name = "PrometheusLoader"
    loaderGui.Parent = CoreGui
    loaderGui.ResetOnSpawn = false
    loaderGui.DisplayOrder = 999

    -- LoaderFrame (Frame)
    local loaderFrame = Instance.new("Frame")
    loaderFrame.Name = "LoaderFrame"
    loaderFrame.Size = UDim2.new(0, 300, 0, 150)
    loaderFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    loaderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    loaderFrame.BorderSizePixel = 0
    loaderFrame.Parent = loaderGui

    -- UICorner (para LoaderFrame)
    local loaderFrameCorner = Instance.new("UICorner")
    loaderFrameCorner.CornerRadius = UDim.new(0, 10)
    loaderFrameCorner.Parent = loaderFrame

    -- Logo (ImageLabel)
    local logoImage = Instance.new("ImageLabel")
    logoImage.Name = "Logo"
    logoImage.Size = UDim2.new(0, 80, 0, 80)
    logoImage.Position = UDim2.new(0.5, -40, 0, 5)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = "rbxassetid://74557301998632" -- Substitua pelo ID da sua imagem
    logoImage.Parent = loaderFrame

    -- TitleLabel (TextLabel)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 10, 0, 85)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Loading..."
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = loaderFrame

    -- StatusLabel (TextLabel)
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0, 105)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Carregando Script..."
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.SourceSans
    statusLabel.Parent = loaderFrame

    -- LoadingBarBackground (Frame)
    local loadingBarBackground = Instance.new("Frame")
    loadingBarBackground.Name = "LoadingBarBackground"
    loadingBarBackground.Size = UDim2.new(1, -20, 0, 10)
    loadingBarBackground.Position = UDim2.new(0, 10, 1, -25)
    loadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    loadingBarBackground.BorderSizePixel = 0
    loadingBarBackground.Parent = loaderFrame

    -- UICorner (para LoadingBarBackground)
    local loadingBarBackgroundCorner = Instance.new("UICorner")
    loadingBarBackgroundCorner.CornerRadius = UDim.new(0, 5)
    loadingBarBackgroundCorner.Parent = loadingBarBackground

    -- LoadingBarFill (Frame)
    local loadingBarFill = Instance.new("Frame")
    loadingBarFill.Name = "LoadingBarFill"
    loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
    loadingBarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    loadingBarFill.BorderSizePixel = 0
    loadingBarFill.Parent = loadingBarBackground

    -- UICorner (para LoadingBarFill)
    local loadingBarFillCorner = Instance.new("UICorner")
    loadingBarFillCorner.CornerRadius = UDim.new(0, 5)
    loadingBarFillCorner.Parent = loadingBarFill

    -- Função para atualizar o status e o progresso do loader
    local function updateLoader(status, progress)
        if statusLabel then
            statusLabel.Text = status or "Carregando Script..."
        end
        if loadingBarFill then
            TweenService:Create(loadingBarFill, TweenInfo.new(0.2), {Size = UDim2.new(progress, 0, 1, 0)}):Play()
        end
    end

    -- Função para fechar o loader
    local function closeLoader()
        if loaderGui then
            loaderGui:Destroy()
        end
    end

    return updateLoader, closeLoader
end

-- Função para salvar a chave na Workspace em um arquivo JSON
local function salvarChaveNaWorkspace(key)
    local caminho = "PoisonKeySystem.json"
    local data = { savedKey = key }
    writefile(caminho, HttpService:JSONEncode(data))
    print("Chave salva com sucesso na Workspace!")

    -- Notificação de chave correta
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key Correta!",
        Text = "",
        Icon = "http://www.roblox.com/asset/?id=15000526827",
        Duration = 1,
    })
end

-- Função para verificar se já existe uma chave salva e válida
local function chaveJaSalva()
    local caminho = "PoisonKeySystem.json"
    if isfile(caminho) then
        local savedData = HttpService:JSONDecode(readfile(caminho))
        -- Valida a chave salva usando as funções da KeyGuardLibrary
        local responseDefault = KeyGuardLibrary.validateDefaultKey(savedData.savedKey)
        local responsePremium = KeyGuardLibrary.validatePremiumKey(savedData.savedKey)

        if responseDefault == trueData or responsePremium == trueData then
            -- Notificação de chave salva correta
            game.StarterGui:SetCore("SendNotification", {
                Title = "Key Salva Correta!",
                Text = "",
                Icon = "http://www.roblox.com/asset/?id=15000526827",
                Duration = 1,
            })
            return true
        else
            print("Chave inválida salva! Apagando arquivo...")
            delfile(caminho)
            -- Notificação de chave salva incorreta
            game.StarterGui:SetCore("SendNotification", {
                Title = "Key Salva Incorreta!",
                Text = "",
                Icon = "http://www.roblox.com/asset/?id=15000532008",
                Duration = 1,
            })
            return false
        end
    end
    return false
end

-- Função que executa o código definido em getgenv().code
local function code()
    print("Chave válida. Executando o código...")

    -- Obtém o código do ambiente global
    local envCode = getgenv().code
    if envCode then
        -- Carrega e executa o código
        local envFunc, err = loadstring(envCode)
        if envFunc then
            print("Executando código de getgenv()...")
            local success, result = pcall(envFunc)
            if success then
                print("Código de getgenv() executado com sucesso!")
            else
                warn("Erro ao executar código de getgenv():", result)
            end
        else
            warn("Erro ao carregar código de getgenv():", err)
        end
    else
        warn("Nenhum código encontrado em getgenv().code.")
    end
end

-- Função principal que executa o sistema de chaves
local function runKeySystem()
    -- Cria o loader
    local updateLoader, closeLoader = Prometheus.createLoader("Poison Script Hub")

    updateLoader("Verificando Key...", 0.2)
    wait(1)

    -- Verifica se há uma chave válida salva
    if chaveJaSalva() then
        updateLoader("Key válida encontrada!", 0.8)
        wait(1)
        closeLoader()
        code() -- Executa o código se a chave for válida
    else
        updateLoader("Key não encontrada. Abrindo sistema de Key...", 0.5)
        wait(1)
        closeLoader()

        -- Cria a GUI do sistema de chaves
        local KeySystemGui = Instance.new("ScreenGui")
        KeySystemGui.Name = "KeySystemGui"
        KeySystemGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        KeySystemGui.ResetOnSpawn = false

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

        -- Bordas amarelas para o frame principal
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

        -- TextBox para inserir a chave
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

        -- Função auxiliar para criar botões
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

            -- Adiciona a borda amarela ao botão
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

        -- Botão Get Key
        local GetKeyButton = createButton("Get Key", UDim2.new(0.35, 0, 0.15, 0), UDim2.new(0.1, 0, 0.55, 0), MainFrame, function()
            setclipboard(KeyGuardLibrary.getLink())
            print("Link de Get Key copiado!")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Key Copiada com Sucesso",
                Text = "",
                Icon = "http://www.roblox.com/asset/?id=131590406352039",
                Duration = 1,
            })
        end)

        -- Botão Check Key
        local CheckKeyButton = createButton("Check Key", UDim2.new(0.35, 0, 0.15, 0), UDim2.new(0.55, 0, 0.55, 0), MainFrame, function()
            -- Valida a chave inserida usando as funções da KeyGuardLibrary
            local responseDefault = KeyGuardLibrary.validateDefaultKey(TextBox.Text)
            local responsePremium = KeyGuardLibrary.validatePremiumKey(TextBox.Text)

            if responsePremium == trueData or responseDefault == trueData then
                print("Chave válida!")
                salvarChaveNaWorkspace(TextBox.Text)
                KeySystemGui:Destroy()
                -- Recria o loader para a execução do script
                local updateLoader, closeLoader = Prometheus.createLoader("Poison Script Hub")
                updateLoader("Carregando Script...", 0.3)
                wait(0.5)
                updateLoader("Executando Script...", 0.7)
                wait(1)
                updateLoader("Script Carregado com Sucesso!", 1)
                wait(0.5)
                closeLoader()
                code() -- Executa o código
            else
                print("Chave inválida!")
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Key Incorreta!",
                    Text = "",
                    Icon = "http://www.roblox.com/asset/?id=15000532008",
                    Duration = 1,
                })
            end
        end)

        -- Botão Discord
        local DiscordButton = Instance.new("TextButton")
        DiscordButton.Size = UDim2.new(0.35, 0, 0.15, 0)
        DiscordButton.Position = UDim2.new(0.325, 0, 0.75, 0)
        DiscordButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        DiscordButton.Text = ""
        DiscordButton.TextSize = 24
        DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        DiscordButton.Font = Enum.Font.SourceSansBold
        DiscordButton.Parent = MainFrame

        -- Adiciona a borda amarela (UIStroke) no botão Discord
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = Color3.fromHex("#EFEA26")
        buttonStroke.Thickness = 2
        buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        buttonStroke.Parent = DiscordButton

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 5)
        buttonCorner.Parent = DiscordButton

        DiscordButton.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/dqXk74tZcx")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Link do Discord Copiado com Sucesso",
                Text = "",
                Icon = "http://www.roblox.com/asset/?id=5013032505",
                Duration = 1,
            })
        end)

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
    end
end

-- Inicia o sistema de chaves e o loader
runKeySystem()
