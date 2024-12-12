local MyLib = {
	ThemeObjects = {},
	Connections = {},
    Themes = {
		Default = { -- Tema da OrionLib
			Main = Color3.fromRGB(25, 25, 25),
			Second = Color3.fromRGB(32, 32, 32),
			Stroke = Color3.fromRGB(60, 60, 60),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(240, 240, 240),
			TextDark = Color3.fromRGB(150, 150, 150)
		},
		Gold = { -- Seu tema dourado
            Main = Color3.fromRGB(40, 35, 20),
            Second = Color3.fromRGB(50, 45, 30),
            Stroke = Color3.fromRGB(80, 70, 50),
            Divider = Color3.fromRGB(80, 70, 50),
            Text = Color3.fromRGB(255, 240, 200),
            TextDark = Color3.fromRGB(200, 180, 140)
        }
	},
	SelectedTheme = "Gold", -- Tema padrão
}
local function ReturnProperty(Object)
    if Object:IsA("Frame") or Object:IsA("TextButton") then
		return "BackgroundColor3"
	end 
	if Object:IsA("ScrollingFrame") then
		return "ScrollBarImageColor3"
	end 
	if Object:IsA("UIStroke") then
		return "Color"
	end 
	if Object:IsA("TextLabel") or Object:IsA("TextBox") then
		return "TextColor3"
	end   
	if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		return "ImageColor3"
	end 
end
local function AddThemeObject(Object, Type)
    if not MyLib.ThemeObjects[Type] then
		MyLib.ThemeObjects[Type] = {}
	end   
    table.insert(MyLib.ThemeObjects[Type], Object)
    Object[ReturnProperty(Object)] = MyLib.Themes[MyLib.SelectedTheme][Type]
    return Object
end
local function SetChildren(Element, Children)
    table.foreach(Children, function(_, Child)
        Child.Parent = Element
    end)
    return Element
end
local function Create(Name, Properties, Children)
    local Object = Instance.new(Name)
    for i, v in next, Properties or {} do
        Object[i] = v
    end
    for i, v in next, Children or {} do
        v.Parent = Object
    end
    return Object
end
local function SetProps(Element, Props)
    table.foreach(Props, function(Property, Value)
        Element[Property] = Value
    end)
    return Element
end
local function MakeElement(ElementName, ...)
    if MyLib.Elements[ElementName] then
        return MyLib.Elements[ElementName](...)
    end    
end

local function SetTheme()
	for Name, Type in pairs(MyLib.ThemeObjects) do
		for _, Object in pairs(Type) do
			Object[ReturnProperty(Object)] = MyLib.Themes[MyLib.SelectedTheme][Name]
		end    
	end    
end

local function CreateElement(ElementName, ElementFunction)
    MyLib.Elements[ElementName] = function(...)
        return ElementFunction(...)
    end
end

CreateElement("Frame", function(Color)
    local Frame = Create("Frame", {
        BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    return Frame
end)
CreateElement("Label", function(Text, TextSize, Transparency)
    local Label = Create("TextLabel", {
        Text = Text or "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextTransparency = Transparency or 0,
        TextSize = TextSize or 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return Label
end)
CreateElement("RoundFrame", function(Color, Scale, Offset)
    local Frame = Create("Frame", {
        BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    }, {
        Create("UICorner", {
            CornerRadius = UDim.new(Scale, Offset)
        })
    })
    return Frame
end)
CreateElement("Button", function()
    local Button = Create("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    return Button
end)
CreateElement("Stroke", function(Color, Thickness)
    local Stroke = Create("UIStroke", {
        Color = Color or Color3.fromRGB(255, 255, 255),
        Thickness = Thickness or 1
    })
    return Stroke
end)
CreateElement("ScrollFrame", function(Color, Width)
    local ScrollFrame = Create("ScrollingFrame", {
        BackgroundTransparency = 1,
        MidImage = "rbxassetid://7445543667",
        BottomImage = "rbxassetid://7445543667",
        TopImage = "rbxassetid://7445543667",
        ScrollBarImageColor3 = Color,
        BorderSizePixel = 0,
        ScrollBarThickness = Width,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    return ScrollFrame
end)
CreateElement("List", function(Scale, Offset)
    local List = Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(Scale or 0, Offset or 0)
    })
    return List
end)
-- Função para criar a janela principal
function MyLib:MakeWindow(WindowConfig)
	WindowConfig = WindowConfig or {}
	WindowConfig.Name = WindowConfig.Name or "My GUI"
	local FirstTab = true
	local Orion = Instance.new("ScreenGui")
    Orion.Name = "MyGUI"
    Orion.Parent = game:GetService("CoreGui") -- Mude para "CoreGui" ou onde quiser

	local TabHolder = AddThemeObject(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4),
		WindowConfig.SearchBar and {
			Size = UDim2.new(1, 0, 1, -90),
			Position = UDim2.new(0, 0, 0, 40)
		} or {
			Size = UDim2.new(1, 0, 1, -50)
		}),
		{
			MakeElement("List"),
			--MakeElement("Padding", 8, 0, 0, 8)
		}), "Divider")

    local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1
    }), {
        AddThemeObject(SetProps(MakeElement("Label", "X", 20), {
            Position = UDim2.new(0, 0, 0, 4),
            Size = UDim2.new(0, 30, 0, 30)
        }), "Text")
    })
	local DragPoint = SetProps(MakeElement("Frame"), {
		Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
	})
    local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1
    }), {
        AddThemeObject(SetProps(MakeElement("Label", "_", 20), {
            Position = UDim2.new(0, 0, 0, 4),
            Size = UDim2.new(0, 30, 0, 30)
        }), "Text")
    })
    
    local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
		Size = UDim2.new(0, 150, 1, -50),
		Position = UDim2.new(0, 0, 0, 50)
	}), {
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 10),
			Position = UDim2.new(0, 0, 0, 0)
		}), "Second"), 
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 10, 1, 0),
			Position = UDim2.new(1, -10, 0, 0)
		}), "Second"), 
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(1, -1, 0, 0)
		}), "Stroke"), 
		TabHolder,
        -- Seu código aqui para barra de pesquisa, tabs, etc.
	}), "Second")

    -- @ SearchBar (Zv-yz/github);
    local Tabs = {};

	if WindowConfig.SearchBar then
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

        local function SearchHandle()
			local Text = string.lower(SearchBox.Text);

			for i,v in pairs(Tabs) do
				if v:IsA('TextButton') then
					if string.find(string.lower(i), Text) then
						v.Visible = true
					else
						v.Visible = false
					end
				end
			end
		end

		--[[AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandle);]]
    end
    
	local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
		Size = UDim2.new(1, -30, 2, 0),
		Position = UDim2.new(0, 25, 0, -24),
		Font = Enum.Font.GothamBlack,
		TextSize = 20
	}), "Text")

    local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1)
    }), "Stroke")
    
    local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
		Parent = Orion,
		Position = UDim2.new(0.5, -307, 0.5, -172),
		Size = UDim2.new(0, 615, 0, 344),
		ClipsDescendants = true
	}), {
        SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Name = "TopBar"
		}), {
			WindowName,
			WindowTopBarLine,
            AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
                Size = UDim2.new(0, 70, 0, 30),
                Position = UDim2.new(1, -90, 0, 10)
            }), {
                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                AddThemeObject(SetProps(MakeElement("Frame"), {
                    Size = UDim2.new(0, 1, 1, 0),
                    Position = UDim2.new(0.5, 0, 0, 0)
                }), "Stroke"), 
                CloseBtn,
                MinimizeBtn
            }), "Second"), 
        }),
        DragPoint,
        WindowStuff
	}), "Main")

	local function MakeDraggable(DragPoint, Main)
        local Dragging, DragInput, MousePos, FramePos = false
        local connection1 = DragPoint.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                MousePos = Input.Position
                FramePos = Main.Position
    
                local connection2 = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                        connection2:Disconnect()
                    end
                end)
            end
        end)
        local connection3 = DragPoint.InputChanged:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                DragInput = Input
            end
        end)
        local connection4 = game:GetService("UserInputService").InputChanged:Connect(function(Input)
            if Input == DragInput and Dragging then
                local Delta = Input.Position - MousePos
                --TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
                Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
            end
        end)
    end
    MakeDraggable(DragPoint, MainWindow)
	
    AddThemeObject(SetProps(MakeElement("Frame"), {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1)
    }), "Stroke")
    
	-- [[AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
	-- 	TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
	-- end)]]
    local Functions = {}
    function Functions:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Icon = TabConfig.Icon or ""

		local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(1, 0, 0, 30),
			Parent = TabHolder
		}), {
            -- Aqui vai o ícone (se houver)
			AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
				Size = UDim2.new(1, -35, 1, 0),
				Position = UDim2.new(0, 35, 0, 0),
				Font = Enum.Font.GothamSemibold,
				TextTransparency = 0.4,
				Name = "Title"
			}), "Text")
		})
        AddItemTable(Tabs, TabConfig.Name, TabFrame)
        
		local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
			Size = UDim2.new(1, -150, 1, -50),
			Position = UDim2.new(0, 150, 0, 50),
			Parent = MainWindow,
			Visible = false,
			Name = "ItemContainer"
		}), {
			MakeElement("List", 0, 6),
			--MakeElement("Padding", 15, 10, 10, 15)
		}), "Divider")

        if FirstTab then
			FirstTab = false
			--TabFrame.Ico.ImageTransparency = 0
			TabFrame.Title.TextTransparency = 0
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
		end    

        TabFrame.MouseButton1Click:Connect(function()
            for _, Tab in next, TabHolder:GetChildren() do
                if Tab:IsA("TextButton") then
                    Tab.Title.Font = Enum.Font.GothamSemibold
                    --TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4}):Play()
                    --TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
                end    
            end
            for _, ItemContainer in next, MainWindow:GetChildren() do
                if ItemContainer.Name == "ItemContainer" then
                    ItemContainer.Visible = false
                end    
            end  
            --TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			--TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
        end)

        local function GetElements(ItemParent)
			local ElementFunction = {}
			function ElementFunction:AddLabel(Text)
				local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 0.7,
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")

				local LabelFunction = {}
				function LabelFunction:Set(ToChange)
					LabelFrame.Content.Text = ToChange
				end
				return LabelFunction
			end
			return ElementFunction   
		end
        local ElementFunction = {}

		function ElementFunction:AddSection(SectionConfig)
			SectionConfig.Name = SectionConfig.Name or "Section"

			local SectionFrame = SetChildren(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(1, 0, 0, 26),
				Parent = Container
			}), {
				AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
					Size = UDim2.new(1, -12, 0, 16),
					Position = UDim2.new(0, 0, 0, 3),
					Font = Enum.Font.GothamSemibold
				}), "TextDark"),
				SetChildren(SetProps(MakeElement("Frame"), {
					AnchorPoint = Vector2.new(0, 0),
					Size = UDim2.new(1, 0, 1, -24),
					Position = UDim2.new(0, 0, 0, 23),
					Name = "Holder",
                    BackgroundTransparency = 1
				}), {
					MakeElement("List", 0, 6)
				}),
			})

            --[[AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
				SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
			end)]]
			local SectionFunction = {}
			for i, v in next, GetElements(SectionFrame.Holder) do
				SectionFunction[i] = v 
			end
			return SectionFunction
		end	
        for i, v in next, GetElements(Container) do
			ElementFunction[i] = v 
		end
        return ElementFunction
    end
    SetTheme()
    return Functions
end
return MyLib
