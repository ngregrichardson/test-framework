local helpers = include("helpers")

local MenuName = "T.E.S.T Framework"
local SubMenuName = "Instructions"

local function InitializeMCM(defaultMcmOptions)
	if not TestFramework.mcmOptions then
		TestFramework.mcmOptions = helpers.DeepCopyTable(defaultMcmOptions)
	else
		for key, value in pairs(defaultMcmOptions) do
			if not TestFramework.mcmOptions[key] then
				TestFramework.mcmOptions[key] = value
			end
		end
	end
	local mcmOptions = TestFramework.mcmOptions
	if ModConfigMenu then
		ModConfigMenu.RemoveSetting(MenuName, SubMenuName, "InstructionsTransparency")

		ModConfigMenu.AddSetting(
			MenuName,
			SubMenuName,
			{
				Attribute = "InstructionsTransparency",
				Type = ModConfigMenu.OptionType.NUMBER,
				CurrentSetting = function()
					return mcmOptions.instructionsTransparency
				end,
				Minimum = 0,
				Maximum = 100,
				ModifyBy = 5,
				Display = function()
					return "Instructions Transparency: " .. mcmOptions.instructionsTransparency .. "%"
				end,
				OnChange = function(currentNum)
					mcmOptions.instructionsTransparency = currentNum
					helpers.SaveKey("mcmOptions.instructionsTransparency", currentNum)
				end,
				Info = {"The transparency level of Test instructions (Default 0%)"}
			}
		)
	end
end

return InitializeMCM