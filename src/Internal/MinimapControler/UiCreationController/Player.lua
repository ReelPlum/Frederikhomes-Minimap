local Roact = require(game:GetService("ReplicatedStorage").Roact)
local Settings = require(script.Parent.Parent.Parent.Parent:WaitForChild("Settings"))

local ToolTip = require(script.Parent.ToolTip)

local plr = game:GetService("Players").LocalPlayer
local cam = game.Workspace.CurrentCamera

local player = Roact.Component:extend("Player")

function player:init()
	self:setState({
		Rotation = 0;
	})
end

function player:render()
	local Rot = self.state.Rotation
	
	return Roact.createElement("ImageLabel", {
		Image = "rbxassetid://"..Settings["Gui"]["playerIcon"];
		Size = Settings["Gui"]["playerSize"];
		
		BackgroundTransparency = 1;
		Position = UDim2.new(.5,0,.5,0);
		AnchorPoint = Vector2.new(.5,.5);
		ZIndex = 10;
		
		Rotation = Rot;
		
		[Roact.Event.MouseEnter] = function(rbx)
			--Show tooltip
			self.toolTip = Roact.mount(Roact.createElement(ToolTip, {Text = "Frederikhome's minimap made by frederikhome (@rbxfrederikhome)"; Blip = rbx;}), plr:WaitForChild("PlayerGui"))

		end;
		[Roact.Event.MouseLeave] = function(rbx)
			--Hide tooltip
			Roact.unmount(self.toolTip)
		end;
	})
end

function player:didMount()
	self.renderLoop = game:GetService("RunService").RenderStepped:connect(function()
		local char = plr.Character or plr.CharacterAdded:wait()

		local rootpart = char:FindFirstChild("HumanoidRootPart")
		if rootpart then
			local direction = cam.CFrame.lookVector
			local heading = math.atan2(direction.x,direction.z)
			heading = math.deg(heading)
			if Settings["Technical"]["rotation"] == true then
				self:setState(function(state)
					return{
						Rotation = (heading - rootpart.Orientation.Y) + 180;
					}
				end)
			else
				self:setState(function(state)
					return{
						Rotation = heading + 180;
					}
				end)
			end
		end
	end)
end

function player:willUnmount()
	self.renderLoop:Disconnect()
	
	if self.toolTip then
		Roact.unmount(self.toolTip)
	end
end

return player
