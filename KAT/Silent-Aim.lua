-- Made by Wspboy12

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SilentAimRemote = ReplicatedStorage.Remotes.SilentAim

local function GetClosestPlayer()
    local ClosestPlayer = nil
    local FarthestDistance = math.huge

    for i, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local DistanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude

            if DistanceFromPlayer < FarthestDistance then
                FarthestDistance = DistanceFromPlayer
                ClosestPlayer = v
            end
        end
    end

    if ClosestPlayer then
        return ClosestPlayer
    end
end

local function SilentAim()
    local ClosestPlayer = GetClosestPlayer()

    if ClosestPlayer then
        SilentAimRemote:FireServer(ClosestPlayer.Character.HumanoidRootPart.Position)
    end
end

SilentAim()
