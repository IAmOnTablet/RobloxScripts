--// Modify by YellowGreg

-- Services
local Plrs = game:GetService("Players")
local RnSr = game:GetService("RunService")

-- Player
local P = Plrs.LocalPlayer
local M = P:GetMouse()
local Cam = workspace.CurrentCamera

-- Settings
local S = {
    fov = 150,      -- Field of view angle for target selection
    hitbox = "Head",-- Hitbox to aim at (e.g., "Head", "Torso")
    fovcircle = true,-- Show FOV circle
}

-- UI Elements
local CircleInline = Drawing.new("Circle")
local CircleOutline = Drawing.new("Circle")
CircleInline.Visible = S.fovcircle
CircleOutline.Visible = S.fovcircle
CircleOutline.Thickness = 4
CircleInline.Thickness = 2
CircleOutline.Color = Color3.new()
CircleInline.Color = Color3.fromRGB(255, 255, 255)
CircleOutline.ZIndex = 1
CircleInline.ZIndex = 2

-- Find closest target within FOV
local function GetClosest(Fov)
    local T, C = nil, Fov or math.huge

    for _, v in pairs(Plrs:GetPlayers()) do
        if v ~= P and v.Character and v.Character:FindFirstChild(S.hitbox) then
            local Pos, OnScr = Cam:WorldToScreenPoint(v.Character[S.hitbox].Position)
            local Dist = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(M.X, M.Y)).Magnitude

            if Dist < C and OnScr then
                C = Dist
                T = v
            end
        end
    end

    return T
end

-- Current target
local Tgt

-- Update UI and target
RnSr.Stepped:Connect(function()
    CircleInline.Radius = S.fov
    CircleInline.Position = Vector2.new(M.X, M.Y + 36)
    
    CircleOutline.Radius = S.fov
    CircleOutline.Position = Vector2.new(M.X, M.Y + 36)
    
    Tgt = GetClosest(S.fov)
end)

-- Modify FindPartOnRayWithIgnoreList function
local Old
Old = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}

    if not checkcaller() and getnamecallmethod() == "FindPartOnRayWithIgnoreList" then
        if table.find(Args[2], workspace.WorldIgnore.Ignore) and Tgt and Tgt.Character then
            local Origin = Args[1].Origin
            Args[1] = Ray.new(Origin, Tgt.Character[S.hitbox].Position - Origin)
        end
    end

    return Old(Self, unpack(Args))
end)
