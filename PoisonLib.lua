local Library = {}
-- Random UI Name
local LibraryName = tostring(math.random(100000,200000))..tostring(math.random(100000,200000))..tostring(math.random(100000,200000))

function Library:Toggle()
    if game.CoreGui:FindFirstChild(LibraryName).Enabled then 
        game.CoreGui:FindFirstChild(LibraryName).Enabled = false
    else 
        game.CoreGui:FindFirstChild(LibraryName).Enabled = true
    end
end

function Library:Drag(obj)
    local UserInputService = game:GetService("UserInputService")
    
    local gui = obj
    
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
    
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Library:Create(xHubName,xGameName, theme, WindowConfig)
    local xHubName = xHubName or "UI Library"
    local xGameName = xGameName or "By Mapple#3045"
    local theme = theme or {
        BackgroundColor = Color3.fromRGB(35, 35, 35),
        SidebarColor = Color3.fromRGB(30, 30, 30),
        PrimaryTextColor = Color3.fromRGB(255, 255, 255),
        SecondaryTextColor = Color3.fromRGB(135, 135, 135),
        UIStrokeColor = Color3.fromRGB(255, 170, 60),
        PrimaryElementColor = Color3.fromRGB(30, 30, 30),
        SecondaryElementColor = Color3.fromRGB(50, 50, 50),
        OtherElementColor = Color3.fromRGB(25, 25, 25),
        ScrollBarColor = Color3.fromRGB(125, 125, 125),
        PromptColor = Color3.fromRGB(40, 40, 40),
        NotificationColor = Color3.fromRGB(25, 25, 25),
        NotificationUIStrokeColor = Color3.fromRGB(255, 170, 60)
    }
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local Sidebar = Instance.new("Frame")
    local SidebarCorner = Instance.new("UICorner")
    local Filler = Instance.new("Frame")
    local HubName = Instance.new("TextLabel")
    local Line = Instance.new("Frame")
    local ActualSide = Instance.new("ScrollingFrame")
    local ActualSideListLayout = Instance.new("UIListLayout")
    local SideLine = Instance.new("Frame")
    local GameName = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local Tabs = Instance.new("Folder")
	local WindowStuff = Instance.new("Folder")
	WindowStuff.Name = "WindowStuff"
	WindowStuff.Parent = Main
	
    function ScrollSize()
        ActualSide.CanvasSize = UDim2.new(0, 0, 0, ActualSideListLayout.AbsoluteContentSize.Y)
    end

	function SetProps(obj, props)
		for i, v in pairs(props) do
			obj[i] = v
		end
		return obj
	end
	
	function SetChildren(obj, children)
		for i, v in pairs(children) do
			v.Parent = obj
		end
		return obj
	end
	
	function MakeElement(elementType, backgroundColor, backgroundTransparency, cornerRadius)
		local obj = Instance.new("Frame")
		obj.BackgroundColor3 = backgroundColor
		obj.BackgroundTransparency = backgroundTransparency
		if cornerRadius then
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, cornerRadius)
			corner.Parent = obj
		end
		return obj
	end
	
	function Create(type, props)
		local obj = Instance.new(type)
		for i, v in pairs(props) do
			obj[i] = v
		end
		return obj
	end

	function AddThemeObject(object, themeType)
		local obj = object;
		if themeType == "Stroke" then
			obj = Instance.new("UIStroke")
			obj.Color = theme.UIStrokeColor;
			obj.Thickness = 1
			obj.Parent = object;
		end
		if themeType == "Main" then 
			obj.BackgroundColor3 = theme.BackgroundColor
			obj.BorderColor3 = theme.UIStrokeColor
		end
		if themeType == "Text" then
			obj.TextColor3 = theme.PrimaryTextColor
		end
		return obj;
	end
	
	function AddConnection(object, connection)
		object:Connect(connection);
	end
	
	ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false 
    ScreenGui.Name = LibraryName

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = theme.BackgroundColor
    Main.Position = UDim2.new(0.278277636, 0, 0.281287253, 0)
    Main.Size = UDim2.new(0, 580, 0, 370)

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = theme.SidebarColor
    Sidebar.Size = UDim2.new(0, 140, 0, 370)

    SidebarCorner.Name = "SidebarCorner"
    SidebarCorner.Parent = Sidebar

    Filler.Name = "Filler"
    Filler.Parent = Sidebar
    Filler.BackgroundColor3 = theme.SidebarColor
    Filler.BorderSizePixel = 0
    Filler.Position = UDim2.new(0.930769145, 0, 0, 0)
    Filler.Size = UDim2.new(0, 9, 0, 370)

    HubName.Name = "HubName"
    HubName.Parent = Sidebar
    HubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HubName.BackgroundTransparency = 1.000
    HubName.BorderSizePixel = 0
    HubName.Position = UDim2.new(0, 0, 0.024324324, 0)
    HubName.Size = UDim2.new(0, 140, 0, 21)
    HubName.Font = Enum.Font.Gotham
    HubName.Text = xHubName
    HubName.TextColor3 = theme.PrimaryTextColor
    HubName.TextSize = 16.000

    Line.Name = "Line"
    Line.Parent = Sidebar
    Line.BackgroundColor3 = theme.UIStrokeColor
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0.0642857179, 0, 0.148648649, 0)
    Line.Size = UDim2.new(0, 121, 0, 2)

    ActualSide.Name = "ActualSide"
    ActualSide.Parent = Sidebar
    ActualSide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ActualSide.BackgroundTransparency = 1.000
    ActualSide.BorderSizePixel = 0
    ActualSide.Position = UDim2.new(0, 0, 0.172972977, 0)
    ActualSide.Size = UDim2.new(0, 139, 0, 297)
    ActualSide.CanvasSize = UDim2.new(0,0,0,0)
    ActualSide.ScrollBarThickness = 0
    ActualSide.ScrollBarImageColor3 = theme.ScrollBarColor

    ActualSideListLayout.Name = "ActualSideListLayout"
    ActualSideListLayout.Parent = ActualSide
    ActualSideListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    SideLine.Name = "SideLine"
    SideLine.Parent = Sidebar
    SideLine.BackgroundColor3 = theme.UIStrokeColor
    SideLine.BorderSizePixel = 0
    SideLine.Position = UDim2.new(1, 0, 0, 0)
    SideLine.Size = UDim2.new(0, 2, 0, 370)

    GameName.Name = "GameName"
    GameName.Parent = Sidebar
    GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameName.BackgroundTransparency = 1.000
    GameName.BorderSizePixel = 0
    GameName.Position = UDim2.new(-0.00714285718, 0, 0.0810810775, 0)
    GameName.Size = UDim2.new(0, 141, 0, 25)
    GameName.Font = Enum.Font.Gotham
    GameName.Text = xGameName
    GameName.TextColor3 = theme.SecondaryTextColor
    GameName.TextSize = 14.000

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0.244827583, 0, 0.024324324, 0)
    TabHolder.Size = UDim2.new(0, 438, 0, 352)

    Tabs.Name = "Tabs"
    Tabs.Parent = TabHolder

    Library:Drag(Main)
	
    if WindowConfig and WindowConfig.SearchBar then
		local SearchBox = Create("TextBox", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			PlaceholderColor3 = Color3.fromRGB(210,210,210),
			PlaceholderText = WindowConfig.SearchBar.Default or "🔍 Search",
			Font = Enum.Font.GothamBold,
			TextWrapped = true,
			Text = '',
			TextXAlignment = Enum.TextXAlignment.Center,
			TextSize = 14,
			ClearTextOnFocus = WindowConfig.SearchBar.ClearTextOnFocus or true
		})

		local TextboxActual = AddThemeObject(SearchBox, "Text")

		local SearchBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 6), {
			Parent = WindowStuff,
			Size = UDim2.new(0, 130, 0, 24),
			Position = UDim2.new(1.013, -12, 0.075, 0),
			AnchorPoint = Vector2.new(1, 0.5)
		}), {
			AddThemeObject(MakeElement("Stroke"), "Stroke"),
			TextboxActual
		}), "Main")
		SearchBar.Position = UDim2.new(0.5,0,0.01,0)
		SearchBar.AnchorPoint = Vector2.new(0.5,0)

		local function SearchHandle()
			local Text = string.lower(SearchBox.Text);

			for i,v in pairs(ActualSide:GetChildren()) do
				if v:IsA('TextButton') then
					if string.find(string.lower(v.Text), Text) then
						v.Visible = true
					else
						v.Visible = false
					end
				end
			end
		end

		AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandle);
	end


    local xTabs = {}
    
    function xTabs:Tab(Name,xVisible)
        local Name = Name or "Tab"
        local Tab = Instance.new("ScrollingFrame")
        local TabListLayout = Instance.new("UIListLayout")
        local TabButton = Instance.new("TextButton")
        
        ScrollSize()

        function Size()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
        end

        Tab.Name = "Tab"
        Tab.Parent = Tabs
        Tab.Active = true
        Tab.Visible = xVisible
        Tab.BackgroundColor3 = theme.BackgroundColor
        Tab.BorderSizePixel = 0
        Tab.Size = UDim2.new(0, 438, 0, 352)
        Tab.ScrollBarThickness = 5
        Tab.ScrollBarImageColor3 = theme.ScrollBarColor
        
        TabListLayout.Name = "TabListLayout"
        TabListLayout.Parent = Tab
        TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabListLayout.Padding = UDim.new(0, 5)

        TabButton.Name = "TabButton"
        TabButton.Parent = ActualSide
        TabButton.BackgroundColor3 = theme.PrimaryElementColor
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 139, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = Name
        TabButton.TextColor3 = theme.PrimaryTextColor
        TabButton.TextSize = 14.000
        TabButton.ZIndex = 2

        Size()
        Tab.ChildAdded:Connect(Size)
        Tab.ChildRemoved:Connect(Size)

        if xVisible then 
            TabButton.BackgroundColor3 = theme.UIStrokeColor
            TabButton.TextColor3 = theme.PrimaryTextColor
        else 
            TabButton.BackgroundColor3 = theme.PrimaryElementColor
            TabButton.TextColor3 = theme.SecondaryTextColor
        end

        TabButton.MouseButton1Down:Connect(function()
            Size()
            for i,v in pairs(ActualSide:GetChildren()) do 
                if v:IsA("TextButton") then 
                    v.BackgroundColor3 = theme.PrimaryElementColor
                    v.TextColor3 = theme.SecondaryTextColor
                end
            end

            for i,v in pairs(Tabs:GetChildren()) do
                v.Visible = false
            end

            Tab.Visible = true
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                BackgroundColor3 = theme.UIStrokeColor
            }):Play()
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                TextColor3 = theme.PrimaryTextColor
            }):Play()
        end)

        local Elements = {}

        function Elements:Label(Name)
            local Name = Name or "Label"
            local LabelFunction = {}
            local LabelFrame = Instance.new("Frame")
            local LabelFrameCorner = Instance.new("UICorner")
            local Label = Instance.new("TextLabel")

            LabelFrame.Name = tostring(Name).."_Label"
            LabelFrame.Parent = Tab
            LabelFrame.BackgroundColor3 = theme.UIStrokeColor
            LabelFrame.Position = UDim2.new(0.0456621014, 0, 0, 0)
            LabelFrame.Size = UDim2.new(0, 408, 0, 35)

            LabelFrameCorner.Name = "LabelFrameCorner"
            LabelFrameCorner.Parent = LabelFrame

            Label.Name = "Label"
            Label.Parent = LabelFrame
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(0, 408, 0, 35)
            Label.Font = Enum.Font.Gotham
            Label.Text = Name
            Label.TextColor3 = theme.PrimaryTextColor
            Label.TextSize = 16.000

            Label.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(LabelFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.OtherElementColor
                }):Play()
            end)
            Label.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(LabelFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.UIStrokeColor
                }):Play()
            end)

            function LabelFunction:UpdateLabel(Name)
                Label.Text = Name
                LabelHolder.Name = tostring(Name).."_Label"
            end
            return LabelFunction
        end

        function Elements:Button(Name,Callback)
            local Name = Name or "Button"
            local ButtonFunction = {}
            local Callback = Callback or function () end
            local ButtonFrame = Instance.new("Frame")
            local ButtonFrameCorner = Instance.new("UICorner")
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonPadding = Instance.new("UIPadding")

            ButtonFrame.Name = tostring(Name).."_Button"
            ButtonFrame.Parent = Tab
            ButtonFrame.BackgroundColor3 = theme.PrimaryElementColor
            ButtonFrame.Size = UDim2.new(0, 408, 0, 35)
            
            ButtonFrameCorner.Name = "ButtonFrameCorner"
            ButtonFrameCorner.Parent = ButtonFrame
            
            Button.Name = "Button"
            Button.Parent = ButtonFrame
            Button.BackgroundColor3 = theme.PrimaryElementColor
            Button.Size = UDim2.new(0, 408, 0, 35)
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = theme.PrimaryTextColor
            Button.TextSize = 16.000
            Button.Text = Name
            Button.TextXAlignment = Enum.TextXAlignment.Left
            Button.ZIndex = 2
            
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button
            
            ButtonPadding.Name = "ButtonPadding"
            ButtonPadding.Parent = Button
            ButtonPadding.PaddingLeft = UDim.new(0, 10)

            Button.MouseButton1Down:Connect(function()
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.UIStrokeColor
                }):Play()
                wait(0.1)
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.PrimaryElementColor
                }):Play()
                pcall(Callback)
            end)

            Button.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.SecondaryElementColor
                }):Play()
            end)
            Button.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.PrimaryElementColor
                }):Play()
            end)

            function ButtonFunction:UpdateButton(Name)
                Button.Text = Name
                ButtonHolder.Name = tostring(Name).."_Button"
            end
            return ButtonFunction
        end

        function Elements:Dropdown(Name,Listx,Callback)
            local Name = Name or "Dropdown"
            local DropdownFunction = {}
            local Callback = Callback or function() end
            local DropSize = 35
            local opened = false 

            local DropdownFrame = Instance.new("Frame")
            local DropdownFrameCorner = Instance.new("UICorner")
            local DropdownName = Instance.new("TextLabel")
            local DropdownNamePadding = Instance.new("UIPadding")
            local DropdownIcon = Instance.new("ImageButton")
            local DropdownButton = Instance.new("TextButton")
            local DropList = Instance.new("Frame")
            local DropListLayout = Instance.new("UIListLayout")

            DropdownFrame.Name = tostring(Name).."_Dropdown"
            DropdownFrame.Parent = Tab
            DropdownFrame.BackgroundColor3 = theme.PrimaryElementColor
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Size = UDim2.new(0, 408, 0, 35)

            DropdownFrameCorner.Name = "DropdownFrameCorner"
            DropdownFrameCorner.Parent = DropdownFrame

            DropdownName.Name = "DropdownName"
            DropdownName.Parent = DropdownFrame
            DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownName.BackgroundTransparency = 1.000
            DropdownName.BorderSizePixel = 0
            DropdownName.Size = UDim2.new(0, 358, 0, 35)
            DropdownName.Font = Enum.Font.Gotham
            DropdownName.Text = Name
            DropdownName.TextColor3 = theme.PrimaryTextColor
            DropdownName.TextSize = 16.000
            DropdownName.TextXAlignment = Enum.TextXAlignment.Left

            DropdownNamePadding.Name = "DropdownNamePadding"
            DropdownNamePadding.Parent = DropdownName
            DropdownNamePadding.PaddingLeft = UDim.new(0, 10)

            DropdownIcon.Name = "DropdownIcon"
            DropdownIcon.Parent = DropdownFrame
            DropdownIcon.BackgroundTransparency = 1.000
            DropdownIcon.Position = UDim2.new(0.914644599, 0, 0.140659884, 0)
            DropdownIcon.Size = UDim2.new(0, 25, 0, 25)
            DropdownIcon.ZIndex = 2
            DropdownIcon.Image = "rbxassetid://3926305904"
            DropdownIcon.ImageRectOffset = Vector2.new(604, 684)
            DropdownIcon.ImageRectSize = Vector2.new(36, 36)

            DropdownButton.Name = "DropdownButton"
            DropdownButton.Parent = DropdownFrame
            DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownButton.BackgroundTransparency = 1.000
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Size = UDim2.new(0, 408, 0, 35)
            DropdownButton.Font = Enum.Font.SourceSans
            DropdownButton.Text = ""
            DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownButton.TextSize = 14.000

            DropList.Name = "DropList"
            DropList.Parent = DropdownFrame
            DropList.BackgroundColor3 = theme.PrimaryElementColor
            DropList.BackgroundTransparency = 1.000
            DropList.BorderSizePixel = 0
            DropList.ClipsDescendants = true
            DropList.Size = UDim2.new(0, 408, 0, 35)
            DropList.ZIndex = 100
            DropList.Position = UDim2.new(0, 0, 1.14285719, 0)
            DropList.Visible = false

            DropListLayout.Name = "DropListLayout"
            DropListLayout.Parent = DropList
            DropListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            DropListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropListLayout.Padding = UDim.new(0, 3)

            DropListLayout.Changed:Connect(function()
                Tab.CanvasSize = UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)
            end)  

            DropdownButton.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(DropdownFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.SecondaryElementColor
                }):Play()
            end)
            DropdownButton.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(DropdownFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    BackgroundColor3 = theme.PrimaryElementColor
                }):Play()
            end)

            local function DropElements(x)
                for i,v in pairs(Tab:GetChildren()) do 
                    if v:IsA("Frame") and v ~= DropdownFrame then 
                        v.Visible = x
                    end
                end
            end

            DropdownButton.MouseButton1Down:Connect(function()
                if opened then 
                    Size()
                    opened = false 
                    DropList:TweenSize(UDim2.new(0, 408, 0, 35), "InOut", "Linear", 0.1)
                    wait(0.1)
                    game:GetService("TweenService"):Create(DropdownIcon, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ImageColor3 = Color3.fromRGB(255,255,255)
                    }):Play()
                    DropList.Visible = false
                    Size()
                else 
                    opened = true 
                    DropList.Visible = true
                    DropList:TweenSize(UDim2.new(0, 408, 0, DropListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.1)
                    Tab.CanvasSize = UDim2.new(0,0,0,DropListLayout.AbsoluteContentSize.Y + 100)
                    wait(0.1)
                    game:GetService("TweenService"):Create(DropdownIcon, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ImageColor3 = theme.UIStrokeColor
                    }):Play()
                    Tab.CanvasSize = UDim2.new(0,0,0,DropListLayout.AbsoluteContentSize.Y + 100)
                end 
            end)  

            for i,v in pairs(Listx) do 
                local Option = Instance.new("TextButton")
                local OptionCorner = Instance.new("UICorner")
                
                Option.Name = tostring(v).."_Option"
                Option.Parent = DropList
                Option.BackgroundColor3 = theme.PrimaryElementColor
                Option.Size = UDim2.new(0, 408, 0, 35)
                Option.Font = Enum.Font.Gotham
                Option.Text = v
                Option.TextColor3 = theme.PrimaryTextColor
                Option.TextSize = 16.000

                OptionCorner.Name = "OptionCorner"
                OptionCorner.Parent = Option

                Option.MouseButton1Down:Connect(function()
                    Callback(v)
                    for a,b in pairs(DropList:GetChildren()) do 
                        if b:IsA("TextButton") then 
                            b.TextColor3 = theme.PrimaryTextColor
                        end 
                    end
                    game:GetService("TweenService"):Create(Option, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        TextColor3 = theme.UIStrokeColor
                    }):Play()
                    DropList:TweenSize(UDim2.new(0, 408, 0, 35), "InOut", "Linear", 0.1)
                    game:GetService("TweenService"):Create(DropdownIcon, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ImageColor3 = Color3.fromRGB(255,255,255)
                    }):Play()
                    wait(0.1)
                    DropList.Visible = false
                    opened = false
                    DropElements(true)
                    Size()
                end)

                Option.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(Option, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        BackgroundColor3 = theme.SecondaryElementColor
                    }):Play()
                end)
                Option.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(Option, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        BackgroundColor3 = theme.PrimaryElementColor
                    }):Play()
                end)
            end

            function DropdownFunction:UpdateDropdown(List)
                local List = List or {}
                for i,v in pairs(List) do 
                    local Option = Instance.new("TextButton")
                    local OptionCorner = Instance.new("UICorner")
    
                    DropSize = DropSize + 35
    
                    Option.Name = tostring(v).."_Option"
                    Option.Parent = DropList
                    Option.BackgroundColor3 = theme.PrimaryElementColor
                    Option.Size = UDim2.new(0, 408, 0, 35)
                    Option.Font = Enum.Font.Gotham
                    Option.Text = v
                    Option.TextColor3 = theme.PrimaryTextColor
                    Option.TextSize = 16.000
    
                    OptionCorner.Name = "OptionCorner"
                    OptionCorner.Parent = Option
    
                    Option.MouseButton1Down:Connect(function()
                        Callback(v)
                        for a,b in pairs(DropList:GetChildren()) do 
                            if b:IsA("TextButton") then 
                                b.TextColor3 = theme.PrimaryTextColor
                            end 
                        end
                        game:GetService("TweenService"):Create(Option, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            TextColor3 = theme.UIStrokeColor
                        }):Play()
                        DropList:TweenSize(UDim2.new(0, 408, 0, 35), "InOut", "Linear", 0.1)
                        game:GetService("TweenService"):Create(DropdownIcon, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            ImageColor3 = Color3.fromRGB(255,255,255)
                        }):Play()
                        wait(0.1)
                        DropList.Visible = false
                        opened = false
                        DropElements(true)
                        Size()
                    end)
    
                    Option.MouseEnter:Connect(function()
                        game:GetService("TweenService"):Create(Option, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = theme.SecondaryElementColor
                        }):Play()
                    end)
                    Option.MouseLeave:Connect(function()
                        game:GetService("TweenService"):Create(Option, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = theme.PrimaryElementColor
                        }):Play()
                    end)
                end
            end
            return DropdownFunction
        end
        return Elements
    end
    return xTabs
end
return Library
