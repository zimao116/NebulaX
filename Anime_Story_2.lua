_G.Enabled = not _G.Enabled print("Enabled:", _G.Enabled)

local Collecion = {} ; Collecion._index = Collecion

local Player = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Player.LocalPlayer

local API = ReplicatedStorage:WaitForChild("API")
local Utils = API:WaitForChild("Utils")
local network = Utils:WaitForChild("network")

function Collecion:CheckRewardsUI()
    local Result = LocalPlayer.PlayerGui.battle.Result

    return Result.Visible
end

function Collecion:RetryGame()
    network["RemoteEvent"]:FireServer("battle_replay")
end

print("Anti-AFK Started")

task.spawn(function()
    while true do task.wait(600)
        print("Anti-AFK Triggered")
        pcall(function()
            local CurrentCamera = game.Workspace.CurrentCamera

            VirtualUser:Button1Down(Vector2.zero, CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button1Up(Vector2.zero, CurrentCamera.CFrame)

            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

            if Humanoid then
                Humanoid.Jump = true
                task.wait(0.1)
                Humanoid.Jump = false
            end
        end)
    end
end)

while _G.Enabled do task.wait()
    local Success, Err = pcall(function()
        if _G.AutoReplay then
            if Collecion:CheckRewardsUI() then Collecion:RetryGame() end
        end
    end)
end
