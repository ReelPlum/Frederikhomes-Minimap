local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local Settings = require(script.Parent.Parent.Parent:WaitForChild("Settings"))

local mainMinimapComponent = require(script:WaitForChild("MainMinimap"))

local plr = Players.LocalPlayer

local uiCreationController = {}

function uiCreationController:Init()
	--Create the minimap ui.
	
	return Roact.createElement(mainMinimapComponent)
end

return uiCreationController
