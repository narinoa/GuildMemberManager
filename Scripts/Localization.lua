Global("localization", nil)

Global("Locales", {
	["rus"] = { -- Russian, Win-1251
    ["GMHeader"] = "Изменения в гильдии: ",
    ["GNHeader"] = "Вступили в гильдию: ",
    ["Button"] = "Запомнить",
    ["ButtonYes"] = "Да да!",
    ["Rename"] = "Ренейм: ",
    ["Leave"] = "Покинул: ",
    ["Gui"] = "Это ваша гильдия?",
	},
		
	["eng_eu"] = { -- English, Latin-1
    ["GMHeader"] = "Leave guild: ",
	["GNHeader"] = "Join guild: ",
	["Button"] = "Remember",
	["ButtonYes"] = "Of course!",
	["Rename"] = "Rename: ",
	["Leave"] = "Leave: ",
	["Gui"] = "Is this your guild?",
	}
})

--We can now use an official method to get the client language
localization = common.GetLocalization()
function GTL( strTextName )
	return Locales[ localization ][ strTextName ] or Locales[ "eng_eu" ][ strTextName ] or strTextName
end
