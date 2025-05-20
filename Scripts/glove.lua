--Setup Instructions:.
--Create a Part in ReplicatedStorage named Glove (this is your glove model).

--Put this script inside a Tool named Glove (or create the tool and parent the glove part inside it).

--Put the Tool in StarterPack so players get it when they join.

local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local slapRange = 10 -- How far the slap can reach
local slapCooldown = 1 -- seconds between slaps
local lastSlap = 0

tool.Activated:Connect(function()
    if tick() - lastSlap < slapCooldown then return end
    lastSlap = tick()

    local character = player.Character
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    -- Raycast from player's head/hand forward to detect hit
    local direction = mouse.Hit.p - humanoidRootPart.Position
    if direction.Magnitude > slapRange then
        direction = direction.Unit * slapRange
    end

    local rayOrigin = humanoidRootPart.Position
    local rayDirection = direction

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

    if rayResult and rayResult.Instance then
        local hitPart = rayResult.Instance
        local hitCharacter = hitPart:FindFirstAncestorOfClass("Model")
        if hitCharacter and hitCharacter ~= character then
            local hitHumanoid = hitCharacter:FindFirstChildOfClass("Humanoid")
            if hitHumanoid and hitHumanoid.Health > 0 then
                hitHumanoid:TakeDamage(10) -- Damage amount

                -- Optional: Add slap effect here (sound, animation, particles)
                print("Slapped " .. hitCharacter.Name)
            end
        end
    end
end)
