--This handles the displaying of players on the map.
local Settings = require(script.Parent.Parent.Parent:WaitForChild("Settings"))

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local CollectionService = game:GetService("CollectionService")

local function WatchPlayer(Player)
  if Player.Character then
    if not plr.Team or plr.Team == Player.Team then
      CollectionService:AddTag(Player.Character.PrimaryPart, "Player")
    end
  end

  local event2 = Player.CharacterAdded:connect(function(Character)
    --Add the tag to the player IF the player is on the same team :)
      if not plr.Team or plr.Team == Player.Team then
        CollectionService:AddTag(Character.PrimaryPart, "Player")
      end
  end)

  return {event2}
end

local events = {}

plr:GetPropertyChangedSignal("Team") do
  for _,b in pairs(Players:GetChildren()) do
    if b == plr then continue end
    if not b.Character then continue end

    if plr.Team ~= b.Team then
      CollectionService:RemoveTag(b.Character.PrimaryPart, "Player")
      continue
    end

    CollectionService:AddTag(b.Character.PrimaryPart, "Player")
  end
end

Players.PlayerAdded:connect(function(Player)
  --This handles the player added functionality.
  events[Player] = WatchPlayer(Player)
end)

Players.PlayerRemoving:connect(function(Player)
  for _,b in pairs(events[Player]) do
    b:Disconnect()
  end
  events[Player] = nil
end)

if Settings["Technical"]["showTeamMembers"] == true or not Settings["Technical"]["showTeamMembers"] then
  table.insert(Settings["Tags"], {
    tagName = "Player";
    iconID = 5483943698;
    color = Color3.fromRGB(12, 15, 189);
    size = UDim2.new(0, 15, 0, 15);
    snapToBorder = false;
    rotate = true;
    transparency = 1;
  })
end