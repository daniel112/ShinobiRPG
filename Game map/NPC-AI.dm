mob

	proc
		ai()
		// hit_by is called when a mob attacks you. src is the mob that
		// was attacked and m is the mob that attacked src. The default
		// behavior of the proc is to do nothing, but we can define a
		// different behavior for AI-controlled mobs.
		hit_by(mob/m)

		npcKO()
		// attack is called when one mob attacks another. src is the mob
		// that is attacking and target is the mob being attacked.
		attack(mob/M)
			M.hit_by(src)
			///put random moves to be executed here///
			//pick(Punch(),Bodyslam())//randomly picks death sentence
			Punch()

	Move()
		if(canMove == 1)
			..()

mob/npc
	var
		tmp
			mob/target
			direction

	// When a mob of type /mob/npc is created we want to start the AI loop.
	New()
		..()
		spawn(rand(10,20)) ai()
		// This way the ai-controlled mobs don't all move at the same time.

	ai()
		if(src.health == 0)//if npc hp is 0
			npcKO()
		if(target)//if there is a target
			if(get_dist(src, target) > 1)//go to him
				step_to(src, target)
				sleep(5)//essentially the speed

			else //attack him
				direction = get_dir(src,target)//face your target
				if(target.kod ==1)//if target is dead
					target = null//stop trying to kill him..
				else
					attack(target)
					src.dir = direction
				sleep(10)

		else//if no target. just walk around
			step_rand(src)
			sleep(20)

		spawn() ai() //repeats process

	// When an AI-controlled mob is attacked, it targets the mob
		// that attacked it.
	hit_by(mob/m)
		if(!target)
			target = m

	npcKO()
		if(!src.kod)//if not kod yet
			if(src.health == 0)
				src.canMove = 0
				src.kod = 1
				flick("koflick",src)
				src.icon_state = "ko"
			target = null
			sleep(50)
			src.health = src.max_health
			src.chakra = src.max_chakra
			src.icon_state = "Run"
			src.canMove = 1
			src.kod = 0