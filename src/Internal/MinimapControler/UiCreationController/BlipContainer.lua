local Roact = require(game:GetService("ReplicatedStorage").Roact)
local Settings = require(script.Parent.Parent.Parent.Parent:WaitForChild("Settings"))
local Blip = require(script.Parent.Blip)

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local plr = Players.LocalPlayer

local blipContainer = Roact.Component:extend("BlipContainer")

local function createBlip(Tag, Obj)
	return Roact.createElement(Blip, {
		TagName = Tag;
		Object = Obj;
	})
end

local function createBlips()
	local blips = {}
	for _, tag in pairs(Settings["Tags"]) do
		for _, obj in pairs(CollectionService:GetTagged(tag.tagName)) do
			local blip = createBlip(tag.tagName, obj)
			table.insert(blips, blip)
		end
	end
	return Roact.createFragment(blips)
end

function blipContainer:init()
end

function blipContainer:render()
	return Roact.createElement("Frame", { --This is the blip container.
		Name = "Blip Container";
		
		Size = UDim2.new(1,0,1,0);
		Position = UDim2.new(.5,0,.5,0);
		AnchorPoint = Vector2.new(.5,.5);
		BackgroundTransparency = 1;
		BorderSizePixel = 0;
	}, {
		Roact.createElement(createBlips)
	})
end

function blipContainer:didMount()
	for _,tag in pairs(Settings["Tags"]) do
		CollectionService:GetInstanceAddedSignal(tag.tagName):connect(function(obj)
			if plr.Character ~= obj.Parent then
				self:setState(function(state)
					return{
					}
				end)
			end
		end)

		CollectionService:GetInstanceRemovedSignal(tag.tagName):connect(function(obj)
			self:setState(function(state)
				return{
				}
			end)
		end)
	end
end

return blipContainer
