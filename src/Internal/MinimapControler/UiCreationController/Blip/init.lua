local Roact = require(game:GetService("ReplicatedStorage").Roact)
local Settings = require(script.Parent.Parent.Parent.Parent:WaitForChild("Settings"))
local BlipController = require(script.Parent.Parent.BlipController)
local ToolTip = require(script.Parent.ToolTip)
local TagController = require(script.Parent.Parent.Parent.TagController)
local BorderSnap = require(script:WaitForChild("BorderSnap"))

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local cam = game.Workspace.CurrentCamera

local blip = Roact.Component:extend("Blip")

function blip:init()
	self:setState({
		Position = UDim2.new(0, 0, 0, 0);
		Rotation = 0;
		Visible = true;
	})
end

function blip:render()
	local Object = self.props.Object
	local Pos = self.state.Position
	local Rot = self.state.Rotation
	local Vis = self.state.Visible
	
	local TagInfo = TagController:findTag(self.props.TagName)
	
	return Roact.createElement("ImageButton", {
		BackgroundTransparency = TagInfo.transparency or Settings["Gui"]["blipTransparency"];
		BorderSizePixel = Settings["Gui"]["blipBorderSizePixel"];
		BackgroundColor3 = Settings["Gui"]["blipColor"];
		BorderColor3 = Settings["Gui"]["blipBorderColor"];
		
		AnchorPoint = Vector2.new(.5,.5);
		AutoButtonColor = false;
		
		
		Size = TagInfo.size;
		ImageColor3 = TagInfo.color;
		Image = "rbxassetid://"..TagInfo.iconID;
		Position = Pos;
		Rotation = Rot;
		Visible = Vis;
		
		[Roact.Event.MouseEnter] = function(rbx)
			--Show tooltip
			if not TagInfo.toolTip or TagInfo.toolTip == "" then return end

			self.toolTip = Roact.mount(Roact.createElement(ToolTip, {Text = TagInfo.toolTip; Blip = rbx;}), plr:WaitForChild("PlayerGui"))
			
		end;
		[Roact.Event.MouseLeave] = function(rbx)
			--Hide tooltip
			if not self.toolTip then return end

			Roact.unmount(self.toolTip)
		end;
	})
end

function blip:didMount()
	self.renderLoop = game:GetService("RunService").RenderStepped:connect(function()
		if BlipController:getDistanceFromPlayer(self.props.Object.Position) <= Settings["Technical"]["maxBlipDistance"] then
			local Pos = BlipController:getUIPosition(Vector3.new(self.props.Object.Position.X, 0, self.props.Object.Position.Z) / Settings["Divide"])
			local Rotation = 0
			
			local TagInfo = TagController:findTag(self.props.TagName)
			--Getting the position of the blip.

			if TagInfo.snapToBorder == true then
				self.state.Visible = true
				--Pos = Vector2.new(math.clamp(Pos.X, 0, Settings["Gui"]["mapSize"].X.Offset), math.clamp(Pos.Y, 0, Settings["Gui"]["mapSize"].Y.Offset))
				Pos = BorderSnap:ClampToBorder(Pos, Vector2.new(Settings["Gui"]["mapSize"].X.Offset, Settings["Gui"]["mapSize"].Y.Offset), Settings["Gui"]["mapCornerRoundness"])
			else
				local n = BorderSnap:ClampToBorder(Pos, Vector2.new(Settings["Gui"]["mapSize"].X.Offset, Settings["Gui"]["mapSize"].Y.Offset), Settings["Gui"]["mapCornerRoundness"])
				if n.X ~= Pos.X or n.Y ~= Pos.Y then
					self.state.Visible = false
				elseif self.state.Visible == false then
					self.state.Visible = true
				end
			end

			if TagInfo.rotate == true then
				--Get the rotation of the object
				local direction = cam.CFrame.lookVector
				local heading = math.atan2(direction.x,direction.z)
				heading = math.deg(heading)
				
				Rotation = heading - self.props.Object.Orientation.Y + 180
			end
			
			self:setState(function(state)
				return{
					Position = UDim2.new(0, Pos.X, 0, Pos.Y);
					Rotation = Rotation;
				}
			end)
		elseif self.state.Visible == true then
			self:setState(function(state)
				return{
					Visible = false
				}
			end)
		end
	end)
end

function blip:willUnmount()
	self.renderLoop:Disconnect()
	
	if self.toolTip then
		Roact.unmount(self.toolTip)
	end
end

return blip
