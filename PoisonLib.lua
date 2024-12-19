local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")

local UILibrary = {
	["Options"] = {
		["Size"] = 0.8
	}
}

for i, v in next, game.CoreGui:GetChildren() do
	if v.Name == "Library" then
		v:Destroy()
	end
end

function UILibrary.Main(PrjName, HideKey)
	local Library = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local HideMain = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local LeftPart = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local ProjectName = Instance.new("TextLabel")
	local Line = Instance.new("Frame")
	local Line_2 = Instance.new("Frame")
	local Line_3 = Instance.new("Frame")
	local ButtonsTab = Instance.new("Frame")
	local List = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Ignore = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local Pages = Instance.new("Frame")
	local UIPageLayout = Instance.new("UIPageLayout")

	-- Properties:
	Library.Name = "Library"
	Library.Parent = game.CoreGui
	Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = Library
	Main.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.25, 0, 0.25, 0)
	Main.Size = UDim2.new(0, 725, 0, 450)
	Main.Visible = false

	HideMain.Name = "Main"
	HideMain.Parent = Main
	HideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Substituído por amarelo
	HideMain.BorderSizePixel = 0
	HideMain.ClipsDescendants = true
	HideMain.Position = UDim2.new(0, 0, 0, 0)
	HideMain.Size = UDim2.new(1, 0, 1, 0)
	HideMain.ZIndex = 100
	TweenService:Create(HideMain, TweenInfo.new(0.5), { BackgroundTransparency = 0 }):Play()
	wait(0.5)
	TweenService:Create(HideMain, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
	Main.Visible = true
	UICorner.Parent = Main
	UICorner.CornerRadius = UDim.new(0, 8)

	local FadeBackgroundFrame = Instance.new("Frame")
	FadeBackgroundFrame.Name = "FadeBackgroundFrame"
	FadeBackgroundFrame.Parent = Main
	FadeBackgroundFrame.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	FadeBackgroundFrame.BackgroundTransparency = 1.000
	FadeBackgroundFrame.BorderSizePixel = 0
	FadeBackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
	FadeBackgroundFrame.ZIndex = 3

	LeftPart.Name = "LeftPart"
	LeftPart.Parent = Main
	LeftPart.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	LeftPart.BorderSizePixel = 0
	LeftPart.Size = UDim2.new(0, 218, 0, 451)

	UICorner_2.Parent = LeftPart
	UICorner_2.CornerRadius = UDim.new(0, 8)

	ProjectName.Name = "ProjectName"
	ProjectName.Parent = LeftPart
	ProjectName.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	ProjectName.BackgroundTransparency = 1
	ProjectName.BorderSizePixel = 0
	ProjectName.Size = UDim2.new(0, 218, 0, 40)
	ProjectName.Font = Enum.Font.GothamBold
	ProjectName.Text = PrjName
	ProjectName.TextColor3 = Color3.fromRGB(255, 255, 255)
	ProjectName.TextSize = 20.000

	Line.Name = "Line"
	Line.Parent = ProjectName
	Line.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 1, 0)
	Line.Size = UDim2.new(1, 0, 0, 1)

	-- Linha 2 e Linha 3
	Line_2.Name = "Line"
	Line_2.Parent = LeftPart
	Line_2.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Line_2.BorderSizePixel = 0
	Line_2.Position = UDim2.new(0, 0, 0.182, 0)
	Line_2.Size = UDim2.new(1, 0, 0, 1)

	Line_3.Name = "Line"
	Line_3.Parent = LeftPart
	Line_3.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Line_3.BorderSizePixel = 0
	Line_3.Position = UDim2.new(1, 0, 0, 0)
	Line_3.Size = UDim2.new(0, 1, 1, 0)

	-- Abas e Botões
	ButtonsTab.Name = "ButtonsTab"
	ButtonsTab.Parent = LeftPart
	ButtonsTab.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	ButtonsTab.BorderSizePixel = 0
	ButtonsTab.Position = UDim2.new(0, 0, 0.184829056, 0)
	ButtonsTab.Size = UDim2.new(0, 218, 0, 362)

	-- Barra de Pesquisa
	local SearchBox = Instance.new("TextBox")
	SearchBox.Name = "SearchBox"
	SearchBox.Parent = ButtonsTab
	SearchBox.Size = UDim2.new(0.9, 0, 0, 30)
	SearchBox.Position = UDim2.new(0.05, 0, 0, 0)
	SearchBox.BackgroundTransparency = 0
	SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	SearchBox.PlaceholderText = "🔍 Search"
	SearchBox.PlaceholderColor3 = Color3.fromRGB(210, 210, 210)
	SearchBox.Font = Enum.Font.GothamBold
	SearchBox.TextWrapped = true
	SearchBox.Text = ''
	SearchBox.TextXAlignment = Enum.TextXAlignment.Center
	SearchBox.TextSize = 14
	SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.ClearTextOnFocus = true

	local SearchBoxCorner = Instance.new("UICorner")
	SearchBoxCorner.Parent = SearchBox
	SearchBoxCorner.CornerRadius = UDim.new(0, 6)

	-- Lista de Elementos
	local List = Instance.new("ScrollingFrame")
	List.Name = "List"
	List.Parent = ButtonsTab
	List.Active = true
	List.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	List.BackgroundTransparency = 1.000
	List.BorderSizePixel = 0
	List.Size = UDim2.new(0.998, 0, 1, -35)
	List.Position = UDim2.new(0, 0, 0, 35) -- Ajustado para baixo da barra de pesquisa
	List.AutomaticCanvasSize = Enum.AutomaticSize.Y
	List.ScrollBarThickness = 2
	List.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo translúcido
	List.ScrollBarImageTransparency = 0.5
	List.CanvasSize = UDim2.new(0, 0, 0, 0)

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = List
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	local Ignore = Instance.new("Frame")
	Ignore.Name = "Ignore"
	Ignore.Parent = List
	Ignore.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Ignore.BackgroundTransparency = 1.000
	Ignore.BorderSizePixel = 0
	Ignore.LayoutOrder = -999

	local TabsList = {} -- Estrutura para armazenar abas e seus botões

-- Função de busca (modificada para a estrutura da UILibrary)
local function SearchHandle()
    local Text = string.lower(SearchBox.Text)
    for tabName, tabData in pairs(TabsList) do
        local tabButton = tabData.Button  -- Agora acessamos o botão através da tabela tabData
        if tabButton and tabButton:IsA('TextButton') then
            if string.find(string.lower(tabName), Text) then
                tabButton.Visible = true
            else
                tabButton.Visible = false
            end
        end
    end
end

-- Conectando a barra de pesquisa ao evento de texto alterado
SearchBox:GetPropertyChangedSignal("Text"):Connect(SearchHandle)

	-- Sistema para abrir e fechar o menu
	local IsMenuOpened = true
	local LastPos = Main.Position
	local InputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")

	InputService.InputBegan:Connect(function(Input, IsTyping)
		if Input.KeyCode == Enum.KeyCode[HideKey] and not IsTyping then
			IsMenuOpened = not IsMenuOpened
			if IsMenuOpened then
				LastPos = Main.Position
				wait()
				Main:TweenPosition(UDim2.new(0.25, 0, -1.5, 0), "In", "Quint", 0.5, true)
				TweenService:Create(HideMain, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
			else
				Main:TweenPosition(LastPos, "Out", "Quint", 0.5, true)
				wait(0.25)
				TweenService:Create(HideMain, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
			end
		end
	end)

	local dragging
	local dragInput
	local dragStart
	local startPos
	local off = Vector3.new(0, 0, 0)

	local function update(input)
		local delta = input.Position - dragStart
		pcall(function()
			Main:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), "Out", "Quad", 0.1, true, nil)
		end)
	end

	Main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	Main.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	InputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	Pages.Name = "Pages"
	Pages.Parent = Main
	Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pages.BackgroundTransparency = 1.000
	Pages.BorderSizePixel = 0
	Pages.Position = UDim2.new(0.307838351, -4, 0, 10)
	Pages.Size = UDim2.new(0, 506, 1, -10)
	Pages.ClipsDescendants = true

	UIPageLayout.Parent = Pages
	UIPageLayout.FillDirection = Enum.FillDirection.Vertical
	UIPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingDirection = Enum.EasingDirection.Out
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quint
	UIPageLayout.Padding = UDim.new(0, 25)
	UIPageLayout.TweenTime = 0
	UIPageLayout.ScrollWheelInputEnabled = false
	UIPageLayout.Animated = false

	local UISizer = Instance.new("UIScale")
	UISizer.Parent = Library
	UISizer.Scale = UILibrary["Options"]["Size"]

	local Tabs = {}
	function Tabs.Loader()
		local Circles = Instance.new("Frame")
		local obj = {}

		Circles.Name = "Circles"
		Circles.Parent = Main
		Circles.AnchorPoint = Vector2.new(0.5, 0.5)
		Circles.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
		Circles.BackgroundTransparency = 1
		Circles.BorderSizePixel = 0
		Circles.ClipsDescendants = false
		Circles.Position = UDim2.new(0.5, 0, 0.5, 0)
		Circles.Size = UDim2.new(0, 50, 0, 50)
		Circles.ZIndex = 4
		TweenService:Create(FadeBackgroundFrame, TweenInfo.new(0.1), { BackgroundTransparency = 0 }):Play()

		for i = 1, 4 do
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")

			Circle.Name = "Circle"
			Circle.Parent = Circles
			Circle.AnchorPoint = Vector2.new(0, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Substituído por amarelo
			Circle.BorderSizePixel = 0
			Circle.Position = UDim2.new(0, (i - 1) * 13, 0.5, 0)
			Circle.Size = UDim2.new(0, 12, 0, 12)

			CircleCorner.CornerRadius = UDim.new(0, 100)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			table.insert(obj, Circle)
		end

		spawn(function()
			for _ = 1, 5 do
				wait(0.7)
				local el = table.remove(obj)
				table.insert(obj, 1, el)
				for i, v in pairs(obj) do
					if i == 1 then
						v:TweenSize(UDim2.new(0, 12, 0, 12), "Out", "Linear", 0.15, true)
					elseif i == 4 then
						v:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.15, true)
						wait(0.15)
						v:TweenPosition(UDim2.new(0, 0, 0.5, 0), "Out", "Quad", 0)
					end
					v:TweenPosition(UDim2.new(0, i * 13, 0.5, 0), "Out", "Quad", 0.35)
					if _ == 5 then
						TweenService:Create(FadeBackgroundFrame, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
						TweenService:Create(v, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
					end
				end
			end
		end)
	end

	function Tabs.Nofitication(Text)
		--Removendo a tela de notificacao
		return
	end

	function Tabs.NewTab(TabName)

    local Frame = Instance.new("Frame")
    local TabLabel = Instance.new("TextLabel")
    local Elements = Instance.new("ScrollingFrame")
    local FadeFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.Name = "ff"
    UIListLayout.Parent = Elements
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    Frame.Parent = Pages
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.Name = TabName

    TabLabel.Name = "SectionLabel"
    TabLabel.Parent = Frame
    TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabLabel.BackgroundTransparency = 1.000
    TabLabel.BorderSizePixel = 0
    TabLabel.Position = UDim2.new(0, 7, 0, 7)
    TabLabel.Size = UDim2.new(0, 127, 0, 18)
    TabLabel.Font = Enum.Font.GothamBold
    TabLabel.Text = TabName
    TabLabel.TextColor3 = Color3.fromRGB(255, 255, 0)  -- Cor alterada para amarelo
    TabLabel.TextSize = 21
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left

        Elements.Name = "Elements"
    Elements.Parent = Frame
    Elements.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Elements.BackgroundTransparency = 1
    Elements.BorderSizePixel = 0
    Elements.Position = UDim2.new(0.0178926438, 0, 0, 37)
    Elements.Size = UDim2.new(1, -20, 0, 385)
    Elements.CanvasSize = UDim2.new(0,0,0,0)
    Elements.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Elements.ScrollBarThickness = 2
    Elements.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 0)  -- Cor alterada para amarelo
    Elements.ScrollBarImageTransparency = 0.5

    FadeFrame.Name = "FadeFrame"
    FadeFrame.Parent = Frame
    FadeFrame.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    FadeFrame.BackgroundTransparency = 0
    FadeFrame.BorderSizePixel = 0
    FadeFrame.Position = UDim2.new(0, 0, 0, 0)
    FadeFrame.Size = UDim2.new(1, 0, 1, 0)
    FadeFrame.ZIndex = 19

    local TabButton = Instance.new("TextButton")
    local TabButtonText = Instance.new("TextLabel")
    local TabCorner = Instance.new("UICorner")
    local IsTabOpened = Instance.new("BoolValue")

    IsTabOpened.Parent = TabButton
    for index,page in next, Pages:GetChildren() do
        if page.Name ~= "UIPageLayout" and (page.Name == Frame.Name and index == 2) then
            IsTabOpened.Value = true
            TweenService:Create(FadeFrame, TweenInfo.new(1.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(TabButton, TweenInfo.new(0.25), {BackgroundTransparency = 0.3, BackgroundColor3 = Color3.fromRGB(255, 255, 0)}):Play()  -- Cor alterada para amarelo
elseif page.Name ~= "UIPageLayout" and (page.Name == Frame.Name and index ~= 2) then
    IsTabOpened.Value = false
end
end
IsTabOpened.Name = "bd"
    --Properties:

    TabButton.Name = TabName
TabButton.Parent = List
TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Cor de fundo do botão
TabButton.BackgroundTransparency = 1.000
TabButton.BorderSizePixel = 0
TabButton.Position = UDim2.new(0.0412844047, 0, 0, 0)
TabButton.Size = UDim2.new(0, 200, 0, 38)
TabButton.AutoButtonColor = false
TabButton.Font = Enum.Font.SourceSansSemibold
TabButton.Text = ""
TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TabButton.TextSize = 19.000

TabButtonText.Name = "TabButtonText"
TabButtonText.Parent = TabButton
TabButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TabButtonText.BackgroundTransparency = 1.000
TabButtonText.BorderSizePixel = 0
TabButtonText.Position = UDim2.new(0.0799999982, 0, 0, 0)
TabButtonText.Size = UDim2.new(0.920000017, 0, 1, 0)
TabButtonText.Font = Enum.Font.SourceSansSemibold
TabButtonText.Text = TabName
TabButtonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Cor do texto
TabButtonText.TextSize = 23.000
TabButtonText.TextWrapped = true
TabButtonText.TextXAlignment = Enum.TextXAlignment.Left

TabCorner.Parent = TabButton
TabCorner.CornerRadius = UDim.new(0,8)

-- Adicionando o botão à estrutura TabsList
TabsList[TabName] = {
    Button = TabButton,
    Page = Frame
}

local function ReColorOtherBtns()
for _, Button in next, List:GetDescendants() do
    if Button.Name == "bd" and Button.Parent.Name ~= TabButton.Name then
        -- Alterando a cor de fundo para amarelo e a transparência
        TweenService:Create(Button.Parent, TweenInfo.new(0.1), {BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 0)}):Play() 
        Button.Value = false    
    end
end
for _, Page in next, Pages:GetChildren() do
    if Page.Name ~= "UIPageLayout" and Page.Name ~= TabName then
        -- Alterando a transparência de fundo da página para visível
        TweenService:Create(Page.FadeFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end
end
end

    TabButton.MouseButton1Click:Connect(function()
        IsTabOpened.Value = true
        UIPageLayout:JumpTo(Frame)
        TweenService:Create(TabButton,TweenInfo.new(0.25),{BackgroundTransparency = 0.3,BackgroundColor3 = Color3.fromRGB(255, 255, 0)}):Play()
        TweenService:Create(FadeFrame,TweenInfo.new(0.5),{BackgroundTransparency = 1}):Play()
        ReColorOtherBtns()
    end)

    TabButton.MouseEnter:Connect(function()
        if not IsTabOpened.Value then
            TweenService:Create(TabButton,TweenInfo.new(0.25),{BackgroundTransparency = 0.96}):Play()
        else
            TweenService:Create(TabButton,TweenInfo.new(0.25),{BackgroundTransparency = 0.25}):Play()
        end
    end)

    TabButton.MouseLeave:Connect(function()
        if not IsTabOpened.Value then
            TweenService:Create(TabButton,TweenInfo.new(0.25),{BackgroundTransparency = 1}):Play()
        else
            TweenService:Create(TabButton,TweenInfo.new(0.25),{BackgroundTransparency = 0.3}):Play()
        end
    end)

    local ElementsLib = {}

    function ElementsLib.NewSection(SectionName)
        local Section = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local SectionLabel = Instance.new("TextLabel")
        local SectionElements = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")

        --Properties:

        Section.Name = SectionName
        Section.Parent = Elements
        Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Section.BackgroundTransparency = 1
        Section.BorderSizePixel = 0
        Section.Size = UDim2.new(0, 482, 0, 18)
        Section.AutomaticSize = Enum.AutomaticSize.Y

        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = SectionElements

        SectionLabel.Name = "SectionLabel"
        SectionLabel.Parent = Section
        SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionLabel.BackgroundTransparency = 1.000
        SectionLabel.BorderSizePixel = 0
        SectionLabel.Position = UDim2.new(0, 7, 0, 7)
        SectionLabel.Size = UDim2.new(0, 127, 0, 18)
        SectionLabel.Font = Enum.Font.GothamBold
        SectionLabel.Text = SectionName
        SectionLabel.TextColor3 = Color3.fromRGB(209, 209, 209)
        SectionLabel.TextSize = 16.000
        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

        SectionElements.Name = "SectionElements"
        SectionElements.Parent = Section
        SectionElements.BackgroundColor3 = Color3.fromRGB(30,30,30)
        SectionElements.BackgroundTransparency = 0
        SectionElements.BorderSizePixel = 0
        SectionElements.ClipsDescendants = true
        SectionElements.Position = UDim2.new(0, 7, 0, 33)
        SectionElements.Size = UDim2.new(0, 469, 0, 0)
        SectionElements.AutomaticSize = Enum.AutomaticSize.Y

        UIListLayout.Parent = SectionElements
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        local InSection = {}
        function InSection.NewToggle(ToggleText,UserFunc,defbool)
        --removendo toggles
            return
        end

        function InSection.NewLabel(LabelText,IsScaled,LabelTextSize,LabelTextColor)
            local Label = Instance.new("TextLabel")

            Label.Name = LabelText
            Label.Parent = SectionElements
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderColor3 = Color3.fromRGB(255, 255, 0)
            Label.BorderSizePixel = 0
            Label.Position = UDim2.new(0.0500000007, 0, 0, 0)
            Label.Size = UDim2.new(0.949999988, 0, 0, 40)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = LabelText
            Label.TextSize = LabelTextSize or 14
            Label.TextColor3 = LabelTextColor or Color3.fromRGB(255, 255, 255)
            Label.TextScaled = IsScaled or false
            Label.TextXAlignment = Enum.TextXAlignment.Left
            return Label;
        end

        function InSection.NewLabelWithComment(LabelText,CommentText,IsScaled,LabelTextSize,LabelTextColor)
            local Label = Instance.new("TextLabel")
            local DateMes = Instance.new("TextLabel")

            Label.Name = LabelText
            Label.Parent = SectionElements
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderColor3 = Color3.fromRGB(255, 255, 0)
            Label.BorderSizePixel = 0
            Label.Position = UDim2.new(0.0500000007, 0, 0, 0)
            Label.Size = UDim2.new(0.949999988, 0, 0, 40)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = LabelText
            Label.TextSize = LabelTextSize or 14
            Label.TextColor3 = LabelTextColor or Color3.fromRGB(255, 255, 255)
            Label.TextScaled = IsScaled or false
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextYAlignment = Enum.TextYAlignment.Top

            DateMes.Name = "DateMes"
            DateMes.Parent = Label
            DateMes.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DateMes.BackgroundTransparency = 1.000
            DateMes.BorderSizePixel = 0
            DateMes.Position = UDim2.new(0, 0, 0.76, 0)
            DateMes.Size = UDim2.new(0.970777929, 0, -0.0263157897, 17)
            DateMes.Font = Enum.Font.GothamSemibold
            DateMes.Text = CommentText
            DateMes.TextColor3 = Color3.fromRGB(197, 197, 197)
            DateMes.TextSize = 12.000
            DateMes.TextXAlignment = Enum.TextXAlignment.Left
            return Label;
        end

        function InSection.NewSlider(SliderText,min,max,precise,UserFunc,defvalue)
            --Removendo Sliders
            return
        end
        function InSection.NewDropdown(placeholder,Selectables,func,IsMulti)
            -- Removendo Dropdowns
            return
        end
        function InSection.NewButton(btnText,func)

            local Button = Instance.new("TextButton")
            local SecFrame = Instance.new("Frame")
            local ButtonText = Instance.new("TextLabel")
            local ButtonCorner = Instance.new("UICorner")

            Button.Name = btnText
            Button.Parent = SectionElements
            Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button.BackgroundTransparency = 1
            Button.BorderSizePixel = 0
            Button.Position = UDim2.new(0.0412844047, 0, 0, 0)
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSansSemibold
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 19.000

            ButtonText.Name = "ButtonText"
            ButtonText.Parent = Button
            ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonText.BackgroundTransparency = 1.000
            ButtonText.BorderSizePixel = 0
            ButtonText.Position = UDim2.new(0.05,0, 0, 0)
            ButtonText.Size = UDim2.new(1, 0, 1, 0)
            ButtonText.Font = Enum.Font.SourceSansSemibold
            ButtonText.Text = btnText
            ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.TextSize = 18
				ButtonText.TextWrapped = true
				ButtonText.TextXAlignment = Enum.TextXAlignment.Left

				ButtonCorner.Parent = Button
				ButtonCorner.CornerRadius = UDim.new(0,3)

				SecFrame.Parent = Button
				SecFrame.AnchorPoint = Vector2.new(0.5, 0)
				SecFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
				SecFrame.BorderSizePixel = 0
				SecFrame.Position = UDim2.new(0.53, 0, 1, 0)
				SecFrame.Size = UDim2.new(1, 0, 0, 1)

				local IsMouseOn = false

				Button.MouseButton1Click:Connect(function()
					spawn(function() func() end)
					if not IsMouseOn then
						TweenService:Create(Button,TweenInfo.new(0.25),{BackgroundTransparency = 1,BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
					else
						TweenService:Create(Button,TweenInfo.new(0.25),{BackgroundTransparency = 0.98,BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
					end
				end)

				Button.MouseButton1Down:Connect(function()
					TweenService:Create(Button,TweenInfo.new(0.25),{BackgroundTransparency = 0.3,BackgroundColor3 = Color3.fromRGB(255, 255, 0)}):Play()
				end)

				Button.MouseEnter:Connect(function()
					IsMouseOn = true
					TweenService:Create(Button,TweenInfo.new(0.25),{BackgroundTransparency = 0.98}):Play()
				end)

				Button.MouseLeave:Connect(function()
					IsMouseOn = false
					TweenService:Create(Button,TweenInfo.new(0.25),{BackgroundTransparency = 1}):Play()
				end)
			end

			local Ignore_2 = Instance.new("Frame")

			Ignore_2.Name = "ign"
			Ignore_2.Parent = SectionElements
			Ignore_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Ignore_2.Size = UDim2.new(0, 0, 0, 3)
			Ignore_2.BackgroundTransparency = 1
			Ignore_2.BorderSizePixel = 0
			Ignore_2.LayoutOrder = 9999

			local Ignore_3 = Instance.new("Frame")

			Ignore_3.Name = "ign"
			Ignore_3.Parent = SectionElements
			Ignore_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Ignore_3.Size = UDim2.new(0, 0, 0, 0)
			Ignore_3.BackgroundTransparency = 1
			Ignore_3.BorderSizePixel = 0
			Ignore_3.LayoutOrder = -9999
			return InSection;
		end
		return ElementsLib;
	end
	return Tabs;
end
return UILibrary
