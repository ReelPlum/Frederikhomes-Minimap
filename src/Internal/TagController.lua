local Tag = {}

local Settings = require(script.Parent.Parent:WaitForChild("Settings"))

function Tag:findTag(tagName)
	for _, tag in pairs(Settings["Tags"]) do
		if tag.tagName == tagName then
			return tag
		end
	end
end

return Tag
