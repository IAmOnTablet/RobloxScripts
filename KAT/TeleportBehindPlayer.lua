-- Made by YellowGreg#7993

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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

local function TeleportBehindPlayer()
    local ClosestPlayer = GetClosestPlayer()

    if ClosestPlayer then
        local PlayerCharacter = ClosestPlayer.Character

        if PlayerCharacter then
            local PlayerHumanoidRootPart = PlayerCharacter:FindFirstChild("HumanoidRootPart")

            if PlayerHumanoidRootPart then
                local TeleportPosition = PlayerHumanoidRootPart.Position - (PlayerCharacter.HumanoidRootPart.CFrame.LookVector * 10)
                LocalPlayer.Character:MoveTo(TeleportPosition)
            end
        end
    end
end

TeleportBehindPlayer()
