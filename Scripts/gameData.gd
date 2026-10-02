extends Resource
class_name data

@export var dayVariables = {
	"1":
	{
		"timerMax":
			80,
		"possible":
			["vodka","water","grenadine","citrus","soda water","whisky","orange","tequilla"],
		"Special":
			false,
		"Styles":
			false
	},
	"2":
	{
		"timerMax":
			70,
		"possible":
			["vodka","water","grenadine","citrus","soda water","whisky","on the rocks","orange","tequilla"],
		"Special":
			false,
		"Styles":
			false
	},
	"3":
	{
		"timerMax":
			60,
		"possible":
			["vodka","water","grenadine","citrus","soda water","whisky","on the rocks","orange","tequilla"],
		"Special":
			false,
		"Styles":
			true
	},
	"4":
	{
		"timerMax":
			50,
		"possible":
			["vodka","water","grenadine","citrus","soda water","whisky","on the rocks","orange","tequilla"],
		"Special":
			true,
		"Styles":
			true
	},
	"5":
	{
		"timerMax":
			40,
		"possible":
			["vodka","water","grenadine","citrus","soda water","whisky","on the rocks","orange","tequilla"],
		"Special":
			true,
		"Styles":
			true
	}
}

@export var Specials = {
	"Blue Moons":
		["vodka","grenadine","on the rocks","stirred"],
	"50/50/50":
		["whisky","soda water","vodka","stirred"],
	"De-Rusted Nail":
		["vodka","on the rocks","shaken"],
	"Surely Tower":
		["citrus","whisky","on the rocks"],
	"Tequilla, No Sunrise":
		["tequilla","grenadine","orange","shaken"],
	"Strawberry Daiquiri":
		["grenadine","vodka","blended"],
	"New Fashioned":
		["whisky","orange","citrus","shaken"],
	"MoreHito": 
		["vodka","citrus","soda water","shaken"],
	"Aperol Spritz but without the Aperol or the Spritz":
		["citrus","blended"]
}
