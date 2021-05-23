--[[
	This is the settings. Here you can change things, that make the experince with the minimap different.
	You can add new icons, and add new things to display on the minimap.
--]]

local Settings = 
	{
		["Tags"] = { --This is where the tags are put. The tagged thing will be displayed on the minimap with the desired settings. You can use a plugin like Tag Editor to give parts tags.
			{
				tagName = "Template";
				toolTip = "I don't want to snap to the borders! I rotate tho!";
				iconID = 5254553771;
				color = Color3.fromRGB(255,255,255);
				size = UDim2.new(0, 20, 0, 20);
				snapToBorder = true;
				rotate = false;
			};

			{
				tagName = "John";
				toolTip = "I snap to the borders! I don't rotate tho.";
				iconID = 149369874;
				color = Color3.fromRGB(255,255,255);
				size = UDim2.new(0, 20, 0, 20);
				snapToBorder = true;
				rotate = false;
			};

			{
				tagName = "Roblox";
				toolTip = "I snap to the borders, and i rotate!";
				iconID = 73737626;
				color = Color3.fromRGB(255,255,255);
				size = UDim2.new(0, 20, 0, 20);
				snapToBorder = true;
				rotate = true;
			};
			--[[
			EXPLANATION OF THE DIFFERENT VARIABLES:
			{
				{
				tagName = "Template"; --This is the name of the tag. All assets with the given tag will be shown on the minimap.
				toolTip = "This is the tooltip!"; --This is the text, that will be shown, when a player hovers the mouse over the blip on the map. Write "" if you don't want a tooltip to be shown.
				iconID = 000000000; --This is the icon of the blip. All the blips on the map with this tag will have this icon. (Paste the textureid of the decal.)
				color = Color3.fromRGB(255,255,255); --This is the color of the blip's icon. Set it to "255,255,255" if your blip's icon has the color you want already.
				size = UDim2.new(0, 20, 0, 20); --The size of the blip shown on the map. The player blip is 25x25 pixels.
				snapToBorder = true/false; --Set this to true/false to choose if it will snap to the border of the minimap.
				rotate = true/false; --Choose if the blip will rotate with the asset. I recommend setting "snapToBorder" to false if this is true.
			}; --The ";" is VERY important. Make sure that it's here after every line.
			--]]
		};
		
		["Gui"] = { --This is all the settings for the Guis. (This is more advanced! Please don't touch if you're not experienced!)
			["mapSize"] = UDim2.new(0,250,0,150); --This is the size of the map.
			["borderSize"] = 3; --This is the size of the border surrounding the map.
			["anchorPoint"] = Vector2.new(1,1); --This is the anchorpoint for the map gui.
			["mapPosition"] = UDim2.new(1,-5,1,-5); --This is the position of the map. "anchorPoint" will have an effect on the position.

			--This is the colors of the things
			["mapColor"] = Color3.fromRGB(103, 161, 255); --This is the color, if some parts of the map are transparent / you're at the edge of the map.
			["borderColor"] = Color3.fromRGB(51,51,51); --The color of the border sorrounding the map.
			
			--This is the transparency of the gui elements
			["mapTransparency"] = .5; --This is the backgroundtransparency of the map.
			["borderTransparency"] = 0; --This is the backgroundtransparency of the border.
			
			--This is the rounded corners of the gui things
			["mapCornerRoundness"] = UDim.new(0, 5); --This is the roundness of the map gui.
			["borderCornerRoundness"] = UDim.new(0, 5); --This is the roundness of the border sorrounding the map gui. (I recommend keeping it the same as the roundness of the map gui).
			
			["blipColor"] = Color3.fromRGB(255,255,255); --This is the backgroundcolor for the blips
			["blipTransparency"] = .5; --This is the background transparency for the blips.
			["blipBorderSizePixel"] = 2; --This is the bordersize for the blips.
			["blipBorderColor"] = Color3.fromRGB(0,0,0); --This is the color for the blip's border.
			
			["playerSize"] = UDim2.new(0,25,0,25); --This is the size of the player that is in the center of the map. Default is 25x25 pixels.
			["playerIcon"] = 5483943698; --This is the textureid for the player displayed in the center of the map.
			
			["toolTipHeight"] = 15;
			["toolTipColor"] = Color3.fromRGB(30, 30, 30);
			["toolTipBorderColor"] = Color3.fromRGB(0, 0, 0);
			["toolTipTransparency"] = .5;
			["toolTipBorderSize"] = 2;
			["toolTipTextColor"] = Color3.fromRGB(255, 255, 255);
		};
		
		["Map"] = {
			["mapId"] = 6313124211; --The textureid for the map.
			["size"] = Vector2.new(5000,5000); --The size of the map in studs.
			["mapCenter"] = Vector3.new(0,0,0)
		};
		
		["Technical"] = { --This is some technical settings.
			["onePixel"] = .75; --This is what one pixel is in studs.
			["maxBlipDistance"] = 1000; --This is how far away the blips can be from the character before disappearing from the map (In studs). Default is 500.
			["rotation"] = true; --This controlls of the map is rotating with the camera. Set it to false to make it stop rotating with the camera.
			["Visible"] = true; --This is for when you want to have your minimap hidden when the player initially joins. You will have to toggle the minimap with scripts if this is set to false.
			["mapRotation"] = -180; --The amount of degrees the map has to be rotated for it to be correct.
		};
	}


return Settings
