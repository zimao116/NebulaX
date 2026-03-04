getgenv().Toggles = {}
getgenv().Options = {}

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/zimao116/Cascade/refs/heads/main/src/modules/SaveManager.lua"))()
local Cascade = loadstring(game:HttpGet("https://raw.githubusercontent.com/zimao116/UI-Library/refs/heads/main/Cascade.luau"))()

local Player = game:GetService("Players").LocalPlayer
local Config = Player.Name
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local knit = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit")
local RunTrainEvent = knit:WaitForChild("Services"):WaitForChild("TrainService"):WaitForChild("RE"):WaitForChild("RunTrain")

shared.Loaded = false

local function AutoSave()
    if not shared.Loaded then return end 
    SaveManager:Save(Config)
end

local NebulaX = Cascade.New({
    WindowPill = true,
    Theme = Cascade.Themes.Dark,
    Accent = Cascade.Accents.Blue,
})

SaveManager:SetLibrary(NebulaX)

local window

do
    window = NebulaX:Window({
        Title = "Dig Training",
        Subtitle = "Made by NebulaX",
        Dropshadow = false,
        UIBlur = false,
    }) 

    do
        local main = window:Section({ Title = "Main" })

        do
            local tab = main:Tab({ Selected = true, Title = "Main", Icon = Cascade.Symbols.squareStack3dUp,})

            do
                local form = tab:PageSection({ Title = "Training Farm" }):Form()

                do
                    local row = form:Row({ SearchIndex = "Auto Training" })

                    row:Left():TitleStack({
                        Title = "Auto Training",
                        Subtitle = "Automatically training.",
                    })

                    local AutoTrain = row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, v)
                            getgenv().AutoTrainLoop = v
                            if v then
                                task.spawn(function()
                                    while getgenv().AutoTrainLoop do
                                        if RunTrainEvent then
                                            RunTrainEvent:FireServer("Anvil_3_VIP")
                                        end
                                        task.wait(0.1)
                                    end
                                end)
                            end
                            AutoSave()
                        end
                    })

                    AutoTrain.Type = "Toggle"
                    Toggles["Auto Training"] = AutoTrain
                end
            end
        end
    end

    do
        local Configuration = window:Section({ Title = "Configuration" })

        do
            local tab = Configuration:Tab({ Selected = false, Title = "Settings", Icon = Cascade.Symbols.gear,})

            do
                local form = tab:PageSection({ Title = "Theme Sections" }):Form()

                do
                    local row = form:Row({ SearchIndex = "Dark mode" })

                    row:Left():TitleStack({
                        Title = "Dark mode",
                        Subtitle = "Dark Mode is a application appearance setting that uses a dark color palette to provide a comfortable viewing experience tailored for low-light environments.",
                    })

                    local DarkMode = row:Right():Toggle({
                        Value = true,
                        ValueChanged = function(self, value: boolean)
                            NebulaX.Theme = value and Cascade.Themes.Dark or Cascade.Themes.Light
                            AutoSave()
                        end,
                    })

                    DarkMode.Type = "Toggle"
                    Toggles["Dark Mode"] = DarkMode
                end
            end

            do
                local form = tab:PageSection({ Title = "UI Settings" }):Form()

                do
                    local keyrow = form:Row({ SearchIndex = "UI Toggle Key" })

                    keyrow:Left():TitleStack({
                        Title = "UI Toggle Key",
                        Subtitle = "Settings ui toggle key.",
                    })

                    local UIToggleKey = keyrow:Right():KeybindField({
                        Value = Enum.KeyCode.LeftAlt,
                        ValueChanged = function(self, value)
                            
                        end,
                        BindPressed = function(self, value, inputComplete, gameProcessedEvent)
                            if not inputComplete or gameProcessedEvent then return end
                            window.Minimized = not window.Minimized
                        end,
                    })
                end
            end
        end
    end
end

SaveManager:Load(Config)
local configPath = 'Dig Training - NebulaX/User/' .. Config .. '.json'
if not isfile(configPath) then
    SaveManager:Save(Config) 
end
task.wait(0.5)
shared.Loaded = true

task.spawn(function()
    while task.wait(420) do 
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.Jump = true
        end
    end
end)
