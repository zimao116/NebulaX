local Cascade = loadstring(game:HttpGet("https://raw.githubusercontent.com/zimao116/Cascade-UI-Library/refs/heads/main/UI%20Library"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/zimao116/Cascade-UI-Library/refs/heads/main/SaveManager.lua"))()

local App = Cascade.New({
    Theme = Cascade.Themes.Dark,
    Accent = Cascade.Accents.Mong,
})

SaveManager:SetFolder("Anime Rangers X - Zimao")
SaveManager:SetApp(App)

do
    local Window = App:Window({
        Title = "Re:Rangers X [Private]",
        Subtitle = "Made by Zimao",
    })

    do
        local Section = Window:Section({ Title = "Auto Join" })

        do
            local Tab = Section:Tab({ Selected = true, Title = "Auto Join", Icon = Cascade.Symbols.squareStack3dUp, })

            do
                local Form = Tab:PageSection({ Title = "Room Settings", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Start",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Start",
                        Subtitle = "Start the game after creating the room.",
                    })

                    local AutoStart = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoStart = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Start", AutoStart)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Friend Only",
                    })

                    Row:Left():TitleStack({
                        Title = "Friend Only",
                        Subtitle = "Use friends only when create room.",
                    })

                    local FriendOnly = Row:Right():Toggle({
                        Value = true,
                        ValueChanged = function(self, value: boolean)
                            _G.FriendOnly = value
                        end,
                    })

                    SaveManager:RegisterOption("Friend Only", FriendOnly)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Join Delay",
                    })

                    local JoinDelayTitle = Row:Left():TitleStack({
                        Title = "Join Delay ( 0 )",
                        Subtitle = "Set join start time to run after the script runs in a few seconds.",
                    })

                    local JoinDelay = Row:Right():Slider({
                        Minimum = 0,
                        Maximum = 60,
                        Step = 1,
                        Value = 10,
                        ValueChanged = function(self, value: number)
                            _G.JoinDelay = value
                            JoinDelayTitle.Title = "Join Delay ( " .. value .. " )"
                        end,
                    })

                    SaveManager:RegisterOption("Join Delay", JoinDelay)
                end
            end
        end

        do
            local Tab = Section:Tab({ Selected = false, Title = "Story", Icon = Cascade.Symbols.bookClosed, })

            do
                local Form = Tab:PageSection({ Title = "Story Mode", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Select Map",
                    })

                    Row:Left():TitleStack({
                        Title = "Select Map",
                        Subtitle = "Select story map.",
                    })

                    local Map = { "OnePiece", "Namek", "Naruto", "TokyoGhoul", "SAO", "JJK" }

                    local SelectMap = Row:Right():PopUpButton({
                        Options = Map,
                        ValueChanged = function(self, value: number)
                            _G.World = Map[value]
                        end,
                    })

                    SaveManager:RegisterOption("Select Map", SelectMap)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Select Act",
                    })

                    Row:Left():TitleStack({
                        Title = "Select Act",
                        Subtitle = "Select story act.",
                    })

                    local Act = { "1", "2", "3", "4", "5", }

                    local SelectAct = Row:Right():PopUpButton({
                        Options = Act,
                        ValueChanged = function(self, value)
                            _G.Chapter = Act[value]
                        end,
                    })

                    SaveManager:RegisterOption("Select Act", SelectAct)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Select Difficulty",
                    })

                    Row:Left():TitleStack({
                        Title = "Select Difficulty",
                        Subtitle = "Select story difficulty.",
                    })

                    local Difficulty = { "Normal", "Hard", "Nightmare", }

                    local SelectDifficuly = Row:Right():PopUpButton({
                        Options = Difficulty,
                        ValueChanged = function(self, value)
                            _G.Difficuly = Difficulty[value]
                        end,
                    })

                    SaveManager:RegisterOption("Select Difficulty", SelectDifficuly)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Join Story",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Join Story",
                        Subtitle = "Join story automatically.",
                    })

                    local AutoJoinStory = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoJoinStory = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Join Story", AutoJoinStory)
                end
            end
        end

        do
            local Tab = Section:Tab({ Selected = false, Title = "Ranger Stages", Icon = Cascade.Symbols.gaugeOpenWithLinesNeedle33percent, })

            do
                local Form = Tab:PageSection({ Title = "Ranger Mode", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Select Map",
                    })

                    Row:Left():TitleStack({
                        Title = "Select Map",
                        Subtitle = "Select ranger map.",
                    })

                    local ChallengeMap = { "OnePiece", "Namek", "Naruto", "TokyoGhoul", "SAO", "JJK" }

                    local SelectChallengeMap = Row:Right():PopUpButton({
                        Options = ChallengeMap,
                        ValueChanged = function(self, value)
                            _G.ChallengeMap = ChallengeMap[value]
                        end,
                    })

                    SaveManager:RegisterOption("Select Challenge Map", SelectChallengeMap)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Select Act",
                    })

                    Row:Left():TitleStack({
                        Title = "Select Act",
                        Subtitle = "Select ranger act.",
                    })

                    local ChallengeAct = { "1", "2", "3", }

                    local SelectChallengeAct = Row:Right():PopUpButton({
                        Options = ChallengeAct,
                        ValueChanged = function(self, value)
                            _G.ChallengeAct = ChallengeAct[value]
                        end,
                    })

                    SaveManager:RegisterOption("Select Challenge Act", SelectChallengeAct)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Join Ranger",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Join Ranger",
                        Subtitle = "Join ranger automatically.",
                    })

                    local AutoJoinRanger = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoJoinRanger = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Join Ranger", AutoJoinRanger)
                end
            end
        end

        do
            local Tab = Section:Tab({ Selected = false, Title = "Challenge", Icon = Cascade.Symbols.flagCheckered, })

            do
                local Form = Tab:PageSection({ Title = "Challenge Mode", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Join Challenge",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Join Challenge",
                        Subtitle = "Join challenge automatically.",
                    })

                    local AutoJoinChallenge = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoJoinChallenge = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Join Challenge", AutoJoinChallenge)
                end
            end
        end
    end

    do
        local Section = Window:Section({ Title = "Games" })

        do
            local Tab = Section:Tab({ Selected = false, Title = "Game Settings", Icon = Cascade.Symbols.scope, })

            do
                local Form = Tab:PageSection({ Title = "Main Options", }):Form()

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Vote Start",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Vote Start",
                        Subtitle = "Automatically vote start.",
                    })

                    local AutoVote = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoVote = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Vote Start", AutoVote)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Play",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Play",
                        Subtitle = "Automatically spawn unit.",
                    })

                    local AutoPlay = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoPlay = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Play", AutoPlay)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Upgrade",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Upgrade",
                        Subtitle = "Automatically upgrade unit.",
                    })

                    local AutoUpgrade = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.Auto_Upgrade_Teams = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Upgrade", AutoUpgrade)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Set Game Speed",
                    })

                    local Speed = Row:Left():TitleStack({
                        Title = "Auto Set Game Speed ( 0 )",
                        Subtitle = "Automatically set game speed to 1-3x",
                    })

                    local AutoSetSpeed = Row:Right():Slider({
                        Minimum = 1,
                        Maximum = 3,
                        Step = 1,
                        Value = 2,
                        ValueChanged = function(self, value: boolean)
                            _G.SetSpeedGame = value
                            Speed.Title = "Auto Set Game Speed ( " .. value .. " )"
                        end,
                    })

                    SaveManager:RegisterOption("Auto Set Game Speed", AutoSetSpeed)
                end
            end

            do
                local Form = Tab:PageSection({ Title = "After Match Options", }):Form()
                
                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Replay",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Replay",
                        Subtitle = "Automatically replay if game end.",
                    })

                    local AutoReplay = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoReplay = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Replay", AutoReplay)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Next",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Next",
                        Subtitle = "Automatically next if game end.",
                    })

                    local AutoNext = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoNext = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Next", AutoNext)
                end

                do
                    local Row = Form:Row({
                        SearchIndex = "Auto Back To Lobby",
                    })

                    Row:Left():TitleStack({
                        Title = "Auto Back To Lobby",
                        Subtitle = "Automatically back to lobby if game end.",
                    })

                    local AutoBackToLobby = Row:Right():Toggle({
                        Value = false,
                        ValueChanged = function(self, value: boolean)
                            _G.AutoBackToLobby = value
                        end,
                    })

                    SaveManager:RegisterOption("Auto Back To Lobby", AutoBackToLobby)
                end
            end
        end

        do
            local Tab = Section:Tab({ Selected = false, Title = "Notification", Icon = Cascade.Symbols.bell, })

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
                            _G.WebhookUrl = value
                        end,
                    })

                    SaveManager:RegisterOption("Webhook URL", WebhookLink)
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
    end

    do
        local Section = Window:Section({ Title = "Settings", })

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

_G.Enabled = not _G.Enabled

local Collection = {} ; Collection.__index = Collection

local PlaceID = game.PlaceId
local Player = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Player.LocalPlayer
local PlayerData = ReplicatedStorage.Player_Data[LocalPlayer.Name]
local RewardsUI = LocalPlayer.PlayerGui.RewardsUI
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Values = ReplicatedStorage:WaitForChild("Values")
local Replicated_PlayRoom = ReplicatedStorage:WaitForChild("PlayRoom")
local Remote = ReplicatedStorage:WaitForChild("Remote")
local Game_Data = Values:WaitForChild("Game")
local Server = Remote:WaitForChild("Server")
local PlayRoom = Server:WaitForChild("PlayRoom")
local Units = Server:WaitForChild("Units")
local OnGame = Server:WaitForChild("OnGame")
local Voting = OnGame:WaitForChild("Voting")
local Humanoid = Character:WaitForChild("Humanoid")

function Collection:IsLobby()
    return Game_Data.World.Value == ""
end
function Collection:IsRoomExists()
    return Replicated_PlayRoom:FindFirstChild(LocalPlayer.Name)
end
function Collection:HideRewardsUI()
    if RewardsUI.Enabled then
        RewardsUI.Enabled = false
    end
end

function Collection:TeamUpgrade()
    for _,v in pairs(LocalPlayer["UnitsFolder"]:GetChildren()) do
        if v:IsA("Folder") then
            local MaxLevel = v.Level.Value - 1
            local IsMaxLevel = v.Upgrade_Folder["Level"].Value >= MaxLevel
            if not IsMaxLevel and (LocalPlayer.Yen.Value >= v.Upgrade_Folder.Upgrade_Cost.Value) then
                Units["Upgrade"]:FireServer(v)
            end
        end
    end
end

function Collection:RetryGame()
    Voting["VoteRetry"]:FireServer()
end

function Collection:NextGame()
    Voting["VoteNext"]:FireServer()
end

function Collection:BackToLobby()
    TeleportService:Teleport(PlaceID)
end

function Collection:SetGameSpeed()
    local GameSpeed = Game_Data.GameSpeed
    if GameSpeed.Value ~= _G.SetSpeedGame then
        Remote["SpeedGamepass"]:FireServer(_G.SetSpeedGame)
    end
end

function Collection:SendWebhook(rewards)
    local LeftSide = RewardsUI.Main.LeftSide
    local TotalTime = LeftSide.TotalTime.Text:gsub("Total Time: ", "")

    local Embed = {
        title = "Re:Rangers X",
        description = "`⭐` **ชื่อในเกม:** ||" .. LocalPlayer.Name .. "||\n`🏆` **ชนะด่าน:** **" .. LeftSide.World.Text .. " " .. LeftSide.Chapter.Text .. "**\n`🕛` **ใช้เวลาเพียง:** **" .. TotalTime .. "**",
        color = 16718362,
        fields = rewards,
        thumbnail = { url = "https://tr.rbxcdn.com/180DAY-8219cce5877bdb20d8a1b7635c4e6c7b/256/256/Image/Webp/noFilter" },
        image = { url = "https://tr.rbxcdn.com/180DAY-6c48665cef23febc3f3fa046f82128d9/768/432/Image/Webp/noFilter" },
    }

    ;(syn and syn.request or http_request) {
        Url = _G.WebhookUrl,
        Method = 'POST',
        Headers = { ['Content-Type'] = 'application/json' },
        Body = HttpService:JSONEncode({ embeds = { Embed } }),
    }
end

task.spawn(function()
    task.wait(_G.JoinDelay)
    while true do task.wait(0.5)
        if _G.Enabled then
            local Success, Err = pcall(function()
                if Collection:IsLobby() then
                    local RoomExists = Collection:IsRoomExists()
                    if _G.AutoJoinStory then
                        if RoomExists then
                            PlayRoom["Event"]:FireServer("Change-World", { ["World"] = _G.World })
                            PlayRoom["Event"]:FireServer("Change-Chapter", { ["Chapter"] = `{_G.World}_Chapter{_G.Chapter}` })
                            PlayRoom["Event"]:FireServer("Change-Difficulty", { ["Difficulty"] = _G.Difficuly })
                            if _G.FriendOnly then PlayRoom["Event"]:FireServer("Change-FriendOnly") end
                            task.wait(0.5)
                            PlayRoom["Event"]:FireServer("Submit")
                            if RoomExists.Chapter.Value == `{_G.World}_Chapter{_G.Chapter}` and RoomExists.Difficulty.Value == _G.Difficuly then
                                if _G.AutoStart then PlayRoom["Event"]:FireServer("Start") end
                            end
                        else
                            PlayRoom["Event"]:FireServer("Create")
                        end
                    end
                    if _G.AutoJoinRanger then
                        if RoomExists then
                            PlayRoom["Event"]:FireServer("Change-Mode", { ["KeepWorld"] = "OnePiece", ["Mode"] = "Ranger Stage" })
                            PlayRoom["Event"]:FireServer("Change-World", { ["World"] = _G.ChallengeMap })
                            PlayRoom["Event"]:FireServer("Change-Chapter", { ["Chapter"] = `{_G.ChallengeMap}_RangerStage{_G.ChallengeAct}` })
                            if _G.FriendOnly then PlayRoom["Event"]:FireServer("Change-FriendOnly") end
                            task.wait(0.5)
                            PlayRoom["Event"]:FireServer("Submit")
                            if RoomExists.Chapter.Value == `{_G.ChallengeMap}_RangerStage{_G.ChallengeAct}` and RoomExists.Mode.Value == "Ranger Stage" then
                                if _G.AutoStart then PlayRoom["Event"]:FireServer("Start") end
                            end
                        else
                            PlayRoom["Event"]:FireServer("Create")
                        end
                    end
                    if _G.AutoJoinChallenge then
                        if RoomExists then
                            task.wait(0.5)
                            PlayRoom["Event"]:FireServer("Submit")
                            if RoomExists.Mode.Value == "Challenge" then
                                if _G.AutoStart then PlayRoom["Event"]:FireServer("Start") end 
                            end
                        else
                            PlayRoom["Event"]:FireServer("Create", { CreateChallengeRoom = true })
                        end
                    end
                else
                    if  Game_Data.GameRunning.Value then
                        if not PlayerData.Data.AutoPlay.Value then
                            if _G.AutoPlay then Units["AutoPlay"]:FireServer() end
                        end

                        Collection:HideRewardsUI()
                        if _G.Auto_Upgrade_Teams then Collection:TeamUpgrade() end

                        if _G.SetSpeedGame then Collection:SetGameSpeed() end
                    else
                        if Game_Data.VotePlaying.VoteEnabled.Value then
                            if _G.AutoVote then Voting["VotePlaying"]:FireServer() end
                        end
                        
                        if _G.AutoReplay then Collection:RetryGame() end

                        if _G.AutoNext then Collection:NextGame() end

                        if _G.AutoBackToLobby then
                            if RewardsUI.Enabled then
                                task.wait(0.5)
                                Collection:BackToLobby()
                            end
                        end
                    end
                end
            end)
            if Err then
                warn("[Caught Error]: " .. Err)
            end
        end
    end
end)

RewardsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
    if not RewardsUI.Enabled then return end
    task.wait(0.1)
    local ItemsList = RewardsUI.Main.LeftSide.Rewards.ItemsList
    local rewards = {}
    for _, v in pairs(ItemsList:GetChildren()) do
        if not v:IsA("TextButton") then continue end
        local Success, Err = pcall(function()
            local Info = v.Frame.ItemFrame.Info
            local texts = {}
            for _, child in pairs(Info:GetDescendants()) do
                if child:IsA("TextLabel") and child.Text ~= "" and child.Name == "DropAmonut" then
                    table.insert(texts, child.Text)
                end
            end
            if #texts > 0 then
                table.insert(rewards, {
                    name = "`" .. v.Name .. "`",
                    value = table.concat(texts, ", "),
                    inline = true,
                })
            end
        end)
        if not Success then
            warn("[" .. v.Name .. "]: " .. tostring(Err))
        end
    end
    if #rewards > 0 and _G.EnabledNotification then
        pcall(function() Collection:SendWebhook(rewards) end)
    end
end)

task.spawn(function()
    while true do
        task.wait(60 * 10)
        local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Hum = Char:WaitForChild("Humanoid")
        Hum:Move(Vector3.new(1, 0, 0), false)
        task.wait(0.1)
        Hum:Move(Vector3.new(0, 0, 0), false)
    end
end)
