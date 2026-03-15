local Collection = {}
Collection.Running = false

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

LocalPlayer.Idled:Connect(function()
    local VU = game:GetService("VirtualUser")
    VU:CaptureController()
    VU:ClickButton2(Vector2.new())
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    Collection.Running = false
end)

function Collection:SendWebhook(amount)
    if not _G.EnabledNotification then return end

    if not _G.WebhookLink or _G.WebhookLink == "" then return end

    local payload = {
        embeds = {{
            title = "Statistic",
            color = 0xFFD700,
            thumbnail = {
                url = "https://tr.rbxcdn.com/180DAY-a16e27d3d8380da38b43960549590ca2/256/256/Image/Webp/noFilter"
            },
            description = table.concat({
                "**Name**: ||" .. LocalPlayer.Name .. "||",
                "",
                "**Rewards × ของที่ครอป**",
                "```",
                "- " .. tostring(amount) .. " Gold",
                "```",
            }, "\n")
        }}
    }

    local ok, err = pcall(function()
        request({
            Url = _G.WebhookLink,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "GainedGoldGui" then
        task.wait(9)
        local goldLabel = child:FindFirstChild("Message", true)
        if goldLabel then
            local amount = tonumber(goldLabel.Text:match("%+(%d+)"))
            if amount and amount > 0 then
                Collection:SendWebhook(amount)
            end
        end
    end
end)

function Collection:BuyChest()
    workspace["ItemBoughtFromShop"]:InvokeServer(_G.SelectedChest, _G.AmountChest)
end

function Collection:Gold()
    if Collection.Running then return end Collection.Running = true

    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    local TeleportTarget = workspace.BoatStages.NormalStages.ForestStage
    local TweenTarget = workspace.BoatStages.NormalStages.TheEnd
    local TpTarget = workspace.BoatStages.NormalStages.TheEnd.GoldenChest

    HumanoidRootPart.CFrame = TeleportTarget:GetPivot() * CFrame.new(0, 150, 0)
    task.wait(0.1)

    local speed = 325
    local startCFrame = HumanoidRootPart.CFrame
    local targetCFrame = TweenTarget:GetPivot() * CFrame.new(0, 150, 0)
    local distance = (targetCFrame.Position - startCFrame.Position).Magnitude
    local duration = distance / speed
    local elapsed = 0
    local done = false

    local connection
    connection = RunService.Heartbeat:Connect(function(dt)
        elapsed = elapsed + dt
        local alpha = math.min(elapsed / duration, 1)

        HumanoidRootPart.CFrame = startCFrame:Lerp(targetCFrame, alpha)

        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end

        if alpha >= 1 and not done then
            done = true
            connection:Disconnect()

            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

            task.wait()

            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end

            HumanoidRootPart.CFrame = TpTarget:GetPivot() * CFrame.new(-7, 25, 0)
        end
    end)
end

task.spawn(function()
    while true do task.wait(1)
        if _G.AutoBuyChest then
            pcall(function()
                Collection:BuyChest()
            end)
        end
    end
end)

task.spawn(function()
    while true do task.wait(0.1)
        if _G.ENABLED then
            pcall(function()
                Collection:Gold()
            end)
        end
    end
end)

local Cascade = loadstring(game:HttpGet("https://raw.githubusercontent.com/zimao116/Cascade-UI-Library/refs/heads/main/UI%20Library"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/zimao116/Cascade-UI-Library/refs/heads/main/SaveManager.lua"))()

local App = Cascade.New({
    Theme = Cascade.Themes.Dark,
    Accent = Cascade.Accents.Mong,
})

SaveManager:SetFolder("Build A Boat For Treasure - Zimao")
SaveManager:SetApp(App)

do
    local Window = App:Window({
        Title = "Build A Boat For Treasure",
        Subtitle = "Made by Zimao",
    })

    do
        local Section = Window:Section({ Title = "Main" })

        do
            local Tab = Section:Tab({ Selected = true, Title = "Auto Farm", Icon = Cascade.Symbols.squareStack3dUp, })

            do
                local Form = Tab:PageSection({ Title = "Gold Farm", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Farm Gold",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Farm Gold",
                        Subtitle = "Automatically farm gold.",
                    })

                    local AutoFarmGold = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.ENABLED = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Farm Gold", AutoFarmGold)
                end
            end
        end
    end

    do
        local Section = Window:Section({ Title = "General" })

        do
            local Tab = Section:Tab({ Selected = false, Title = "Shop", Icon = Cascade.Symbols.storefront, })

            do
                local Form = Tab:PageSection({ Title = "Auto Chest", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Buy Chest",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Buy Chest",
                        Subtitle = "Automatically buy chest when you needed.",
                    })

                    local ChestOptions = { "Common Chest", "Uncommon Chest", "Rare Chest", "Epic Chest", "Legendary Chest" }

                    local SelectChest = Row:Right():PopUpButton({
                        Options = ChestOptions,
                        ValueChanged = function(self, value)
                            _G.SelectedChest = ChestOptions[value]
                        end,
                    })

                    SaveManager:RegisterOption("Select Chest", SelectChest)

                    local AmountChest = Row:Right():Stepper({
                        Minimum = 1,
                        Maximum = 100,
                        Step = 1,
                        Fielded = true,
                        Value = 1,
                        ValueChanged = function(self, value: number)
                            _G.AmountChest = value
                        end,
                    })

                    SaveManager:RegisterOption("Amount Chest", AmountChest)

                    local AutoBuyChest = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoBuyChest = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Buy Chest", AutoBuyChest)
                end
            end
        end
    end

    do
        local Section = Window:Section({ Title = "Settings", })

        do
            local Tab = Section:Tab({ Title = "Notification", Icon = Cascade.Symbols.bell, })

            do
                local Form = Tab:PageSection({ Title = "Notification", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Link URL",
                    })

                    Row:Left():TitleStack({
                        Title = "Link URL",
                        Subtitle = "Discord webhook url.",
                    })

                    local WebhookLink = Row:Right():TextField({
                        Value = "",
                        ValueChanged = function(self, value: string)
                            _G.WebhookLink = value
                        end,
                    })

                    SaveManager:RegisterOption("Link URL", WebhookLink)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Enabled Notification",
                    })

                    Row:Left():TitleStack({
                        Title = "Enabled Notification",
                        Subtitle = "Send a notification to your discord, displaying information about that farm and what rewards you've received.",
                    })

                    local EnabledNotification = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.EnabledNotification = value 
                        end,
                    })

                    SaveManager:RegisterOption("Enabled Notification", EnabledNotification)
                end
            end
        end

        do
            local Tab = Section:Tab({ Title = "Appearance", Icon = Cascade.Symbols.paintbrush, })

            do
                local Form = Tab:PageSection({ Title = "Theme", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Dark mode",
                    })

                    Row:Left():TitleStack({
                        Title = "Dark mode",
                        Subtitle = "Dark Mode is a application appearance setting that uses a dark color palette to provide a comfortable viewing experience tailored for low-light environments.",
                    })

                    Row:Right():Toggle({
                        Value = true,
                        ValueChanged = function(self, value: boolean)
                            App.Theme = value and Cascade.Themes.Dark or Cascade.Themes.Light
                        end,
                    })
                end
            end

            do
                local Form = Tab:PageSection({ Title = "Window", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Minimize Keybind",
                    })

                    Row:Left():TitleStack({
                        Title = "Minimize Keybind",
                        Subtitle = "Toggle window visibility.",
                    })

                    Row:Right():KeybindField({
                        Value = Enum.KeyCode.LeftControl,
                        ValueChanged = function(self, value: Enum.KeyCode)
                            Window.MinimizeKey = value
                        end,
                    })
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Searchable",
                    })

                    Row:Left():TitleStack({
                        Title = "Searchable",
                        Subtitle = "Enable search in titlebar.",
                    })

                    Row:Right():Toggle({
                        Value = Window.Searching,
                        ValueChanged = function(self, value: boolean)
                            Window.Searching = value
                        end,
                    })
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Draggable",
                    })

                    Row:Left():TitleStack({
                        Title = "Draggable",
                        Subtitle = "Allow window movement.",
                    })

                    Row:Right():Toggle({
                        Value = Window.Draggable,
                        ValueChanged = function(self, value: boolean)
                            Window.Draggable = value
                        end,
                    })
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Resizable",
                    })

                    Row:Left():TitleStack({
                        Title = "Resizable",
                        Subtitle = "Allow window resizing.",
                    })

                    Row:Right():Toggle({
                        Value = Window.Resizable,
                        ValueChanged = function(self, value: boolean)
                            Window.Resizable = value
                        end,
                    })
                end
            end

            do
                local Form = Tab:PageSection({ Title = "Effects", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Drop Shadow",
                    })

                    Row:Left():TitleStack({
                        Title = "Drop Shadow",
                        Subtitle = "Shadow behind window.",
                    })

                    Row:Right():Toggle({
                        Value = Window.Dropshadow,
                        ValueChanged = function(self, value: boolean)
                            Window.Dropshadow = value
                        end,
                    })
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Background Blur",
                    })

                    Row:Left():TitleStack({
                        Title = "Background Blur",
                        Subtitle = "Blur effects ( detectable ).",
                    })

                    Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            Window.UIBlur = value
                        end,
                    })
                end
            end
		    end
    end
end

SaveManager:AutoLoad()
