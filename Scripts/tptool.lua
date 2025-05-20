-- Teleport Tool Script

local tool = Instance.new("Tool")
tool.Name = "TPTool"
tool.RequiresHandle = false -- No physical handle needed
tool.Parent = game.Players.LocalPlayer.Backpack

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

tool.Activated:Connect(function()
    if mouse.Target then
        local targetPos = mouse.Hit.p
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
        end
    end
end)
