local Roact = require(game:GetService("ReplicatedStorage").Roact)
local Settings = require(script.Parent.Parent.Parent.Parent:WaitForChild("Settings"))

local TextService = game:GetService("TextService")

local events = script.Parent.Parent.Parent.Events

local toolTip = Roact.Component:extend("ToolTip")

function toolTip:init()
	
end

function toolTip:render()
	local screensize = game.Workspace.CurrentCamera.ViewportSize
	
	local pos = self.props.Blip.AbsolutePosition + Vector2.new(self.props.Blip.AbsoluteSize.X/2, 0);
	
	local size = TextService:GetTextSize(self.props.Text, 14, Enum.Font.SourceSans, Vector2.new(500, Settings["Gui"]["toolTipHeight"]))
	local visible = Settings["Technical"]["Visible"]
	
	local p = UDim2.new(0, pos.X, 0, pos.Y) - UDim2.new(0, 0, 0, Settings["Gui"]["toolTipBorderSize"] + Settings["Gui"]["borderSize"] + 2)
	
	if pos.X + size.X/2 + 5 >= screensize.X then
		p = p - UDim2.new(0, (pos.X + size.X/2 + 5 - screensize.X), 0, 0)
	elseif pos.X - size.X/2 - 5 <= 0 then
		p = p + UDim2.new(0, math.abs(pos.X + size.X/2) + 5, 0, 0)
	end
	
	
	if self.props.Text == "" then
		visible = false
	end
	
	return Roact.createElement("ScreenGui", {
		ResetOnSpawn = false;
	}, {
		Roact.createElement("TextLabel", {
			Text = self.props.Text;
			Position = p;
			AnchorPoint = Vector2.new(.5,1);
			Visible = visible;
			Size = UDim2.new(0, size.X + 2, 0, size.Y);
			TextSize = 14;
			Font = Enum.Font.SourceSans;
			
			TextColor3 = Settings["Gui"]["toolTipTextColor"];
			BackgroundColor3 = Settings["Gui"]["toolTipColor"];
			BorderColor3 = Settings["Gui"]["toolTipBorderColor"];
			BackgroundTransparency = Settings["Gui"]["toolTipTransparency"];
			BorderSizePixel = Settings["Gui"]["toolTipBorderSize"];
		});
	})
end

function toolTip:didMount()	
	self.change = self.props.Blip:GetPropertyChangedSignal("Position"):connect(function()
		self:setState(function(state)
			return{
			}
		end)
	end)
	
	self.event = events.Update.event:connect(function()
		self:setState(function(state)
			return{
			}
		end)
	end)
end

function toolTip:willUnmount()
	self.change:Disconnect()
	self.event:Disconnect()
end

return toolTip
