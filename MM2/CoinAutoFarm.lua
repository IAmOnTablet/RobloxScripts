-- dont know if it will work

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart

local function collectCoins()
    local currentCFrame = HumanoidRootPart.CFrame
    local coinContainerName = "CoinContainer"
    local coinName = "Coin"

    for i, object in ipairs(Workspace:GetChildren()) do
        if object:IsA("Model") and object:FindFirstChild(coinContainerName) then
            local coin = object.CoinContainer:FindFirstChild("Coin_Server")
            if coin and coin:FindFirstChild(coinName) then
                HumanoidRootPart.CFrame = coin.Coin.CFrame
            end
        end
    end

    HumanoidRootPart.CFrame = currentCFrame
end

-- Continuously collect coins while the player is in the game
while wait(1) do
    collectCoins()
end
