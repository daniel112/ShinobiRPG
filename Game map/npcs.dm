//var
	//list/moblist = list()

mob
	npc
		icon = 'base.dmi'
		icon_state = "Run"
		pixel_x = -15


	Bump(mob/obstacle)
		// When a mob bumps into something, give the bumpee a chance to react.
		obstacle.Bumped(src)
		//obstacle.say("Watch it!")






