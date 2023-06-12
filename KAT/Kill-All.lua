-- Modify by YellowGreg#7993
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        for i, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local localPlayerCharacter = Players.LocalPlayer.Character
                local targetCharacter = player.Character

                if localPlayerCharacter and targetCharacter and targetCharacter:FindFirstChild("Head") then
                    local humanoidRootPart = localPlayerCharacter:WaitForChild("HumanoidRootPart")
                    local targetHead = targetCharacter.Head

                    humanoidRootPart.CFrame = targetHead.CFrame * CFrame.new(0, 0, 0.4)
                    wait(1)
                end
            end
        end
    end
end)
