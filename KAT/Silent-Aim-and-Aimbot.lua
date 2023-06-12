-- Modify by YellowGreg#7993

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function GetClosestPlayer()
    local ClosestPlayer = nil
    local FarthestDistance = math.huge

    for i, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local DistanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude

            if DistanceFromPlayer < FarthestDistance then
                FarthestDistance = DistanceFromPlayer
                ClosestPlayer = player
            end
        end
    end

    return ClosestPlayer
end

local GameMetaTable = getrawmetatable(game)
local OldGameMetaTableNamecall = GameMetaTable.__namecall
setreadonly(GameMetaTable, false)

GameMetaTable.__namecall = newcclosure(function(...)
    local NamecallMethod = getnamecallmethod()
    local Arguments = {...}

    if tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" then
        local ClosestPlayer = GetClosestPlayer()

        if ClosestPlayer and ClosestPlayer.Character then
            Arguments[1] = Ray.new(Camera.CFrame.Position, (ClosestPlayer.Character.Head.Position - Camera.CFrame.Position).Unit * (Camera.CFrame.Position - ClosestPlayer.Character.Head.Position).Magnitude)
        end
    end

    return OldGameMetaTableNamecall(...)
end)
