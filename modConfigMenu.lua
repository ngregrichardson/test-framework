local helpers = include("helpers")

local MenuName = "T.E.S.T. Framework"
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
		ModConfigMenu.RemoveSetting(MenuName, SubMenuName, "InstructionsOpacity")

		ModConfigMenu.AddSetting(
			MenuName,
			SubMenuName,
			{
				Attribute = "InstructionsOpacity",
				Type = ModConfigMenu.OptionType.NUMBER,
				CurrentSetting = function()
					return mcmOptions.instructionsOpacity
				end,
				Minimum = 0,
				Maximum = 100,
				ModifyBy = 5,
				Display = function()
					return "Instructions Opacity: " .. mcmOptions.instructionsOpacity .. "%"
				end,
				OnChange = function(currentNum)
					mcmOptions.instructionsOpacity = currentNum
					helpers.SaveKey("mcmOptions.instructionsOpacity", currentNum)
				end,
				Info = {"The opacity of current test's instructions (Default 100%)"}
			}
		)
	end
end

return InitializeMCM