--// Made By YellowGreg \\--
local autoHealEnabled = true

local function autoHeal()
    spawn(function()
        while autoHealEnabled do
            wait()
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoidRootPart = character.HumanoidRootPart

                for i, v in pairs(game.Workspace.Debris:GetChildren()) do
                    if v.Name == "DeadHP" then
                        if autoHealEnabled then
                            v.CFrame = humanoidRootPart.CFrame
                        else
                            print("Auto healing is turned off. DeadHP will not teleport.")
                        end
                    end
                end
            end)
        end
    end)
end

-- Function to toggle auto heal on or off
local function toggleAutoHeal(enabled)
    autoHealEnabled = enabled
    if enabled then
        autoHeal()
    end
end
