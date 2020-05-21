if streets.extendedBy.awards == true then
	awards.register_achievement("award_countryroads",{
		title = "Roadbuilder",
		description = "You built some quite big roads!",
		trigger =	{
			type = "place",
			node = "streets:asphalt",
			target = 175,
		},
	})
	awards.register_achievement("award_underworld",{
		title = "Start your sewers!",
		description = "You placed your first manhole! Did you know that you can open it with a right-click?",
		trigger =	{
			type = "place",
			node = "streets:manhole_adv_closed",
			target = 1,
		},
	})
end