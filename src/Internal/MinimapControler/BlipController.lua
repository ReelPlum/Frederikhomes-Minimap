local Settings = require(script.Parent.Parent.Parent:WaitForChild("Settings"))

local plr = game:GetService("Players").LocalPlayer

local blipController = {}

local function pointToViewport(camera, p, vps) --This is written EgoMoose :D
	local lp = camera.CFrame:pointToObjectSpace(p); -- make point relative to camera so easier to work with

	local r = vps.x/vps.y; -- aspect ratio
	local h = -lp.z*math.tan(math.rad(camera.FieldOfView/2)); -- calc height/2
	local w = r*h; -- calc width/2

	local corner = Vector3.new(-w, h, lp.z); -- find the top left corner of the far plane
	local relative = lp - corner; -- get the 3d point relative to the corner

	local sx = relative.x / (w*2); -- find the x percentage 
	local sy = -relative.y / (h*2); -- find the y percentage 

	local onscreen = -lp.z > 0 and sx >=0 and sx <= 1 and sy >=0 and sy <= 1;

	-- returns in pixels as opposed to scale
	return Vector2.new(sx*vps.x, sy*vps.y);
end;

function blipController:getUIPosition(objPosition)
	local vps = Vector2.new(Settings["Gui"]["mapSize"].X.Offset, Settings["Gui"]["mapSize"].Y.Offset)
	
	return pointToViewport(game.Workspace.MinimapCamera, objPosition, vps)
end

function blipController:getDistanceFromPlayer(pos)
	if plr.Character then
		if plr.Character:FindFirstChild("HumanoidRootPart") then
			return (pos - plr.Character.HumanoidRootPart.CFrame.p).Magnitude
		end
	end
	
	return math.huge
end

return blipController
