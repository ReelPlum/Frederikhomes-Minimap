local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local plr = Players.LocalPlayer

--if script.Parent.Parent.Parent == plr:WaitForChild("PlayerScripts") then
	local Settings = require(script.Parent.Parent:WaitForChild("Settings"))
	Settings["Divide"] = 1
	if Settings["Map"]["size"].Y > 1024 or Settings["Map"]["size"].X > 1024 then
		Settings["Divide"] = Settings["Map"]["size"].Y > 1024 and (Settings["Map"]["size"].Y/1024) or Settings["Map"]["size"].X > 1024 and (Settings["Map"]["size"].X/1024)
	end
	
	local Roact = require(script.Parent:WaitForChild("Roact"))

	script.Parent:WaitForChild("Roact").Parent = game:GetService("ReplicatedStorage")

	local MinimapCamera = Instance.new("Camera")
	MinimapCamera.Name = "MinimapCamera"
	MinimapCamera.FieldOfView = 70
	MinimapCamera.Parent = workspace	
	
	local cam = game.Workspace.CurrentCamera

	local uiCreationController = require(script:WaitForChild("UiCreationController"))

	local ui = uiCreationController:Init()

	local Handle = Roact.mount(ui,plr:WaitForChild("PlayerGui"))
	
	local mapsize = Settings["Gui"]["mapSize"]
	Settings["Y"] = (mapsize.Y.Offset / (math.tan(math.rad(35)) * 2)) + (mapsize.X.Offset / 2)
	
	game:GetService("RunService").RenderStepped:connect(function()
		local char = plr.Character or plr.CharacterAdded:wait()

		local rootpart = char:FindFirstChild("HumanoidRootPart")
		if rootpart then
			
			local ROOTPART_POS = rootpart.CFrame.p
			
			local y = Settings["Y"]
			local onepixel = Settings["Technical"]["onePixel"]
			local divide = Settings["Divide"]
			
			local P = Vector3.new(ROOTPART_POS.X, (y * onepixel), ROOTPART_POS.Z) / divide
			
			local heading = 0
			if Settings["Technical"]["rotation"] == true then
				local direction = cam.CFrame.lookVector
				heading = math.atan2(direction.x,direction.z)
				heading = math.deg(heading) + 180

			end
			MinimapCamera.CFrame = CFrame.new(P) * CFrame.Angles(math.rad(-90), 0, math.rad(heading))
		end
	end)
--else
--	error("The minimap has to be a child of ".. plr:WaitForChild("PlayerScripts"):GetFullName() .."! Current parent: "..script.Parent.Parent.Parent:GetFullName())
--end