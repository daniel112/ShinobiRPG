
mob
	var
		kod
		tmp
			attacking = 0
			attack1 = "punch1"
			attack2 = "punch2"
			attack3 = "kick"
			canMove = 1 //self explanatory
			//kod
			//add cooldown var


	verb
		Punch()
			if(src.kod == 1)
				src.move_disabled = 1
				return //if you're dead.. u cant punch duh
			if(src.attacking == 0)
				var/mob/M
				src.attacking = 1
				src.move_disabled = 1
				flick(pick(attack1,attack2,attack3),src)
				for(M in get_step(src,src.dir))//if target is in range and infront of usr
					if(M.kod == 1) //if enemy is down, cant damage it
						spawn(5)
							src.move_disabled = 0
							src.attacking = 0
							return
					else
						var/damage = mFormula(src,M)
						M.health -= damage
						M.updateHealth()
						M.hit_by(src)
						M<<"You have been hit for [damage] damage!"
						src<<"You hit [M] for [damage] damage!"
						//world <<" [M] is hit by [src]'s attack for [damage] damage!"
				spawn(5) //so the verb doesn't get spammed before it finishes
					src.move_disabled = 0
					src.attacking = 0


	proc
		mFormula(mob/hitter,mob/target)//melee formula
			var
				maxhit //max hit
				targetD;hitterD; percentMiss
				damage
			hitterD = round( (hitter.strength*hitter.power)/100) //1%
			maxhit = round( ((hitter.strength*hitter.power)*0.25)) // str*power *.25.. 25dmg
			targetD = round( (( target.strength*target.resistance) /100) ) //str * resist * .25.. 2%
			percentMiss = targetD - hitterD
			if(percentMiss <= 0)
				percentMiss = 0
			else if(percentMiss > 50)
				percentMiss = 50
			if(prob(percentMiss))
				damage = 0
			else
				damage = rand(0,maxhit)//random number from 0 - max hit
			return damage

		tagFormula(mob/hitter,mob/target)//expl tag formula
			var
				hit;damage
				targetD;hitterD;percentReduce;
			hit = round( (hitter.dexterity*1.5*hitter.power*0.10 +10) )//max hit
			targetD = round( target.resistance *target.power/100 )
			hitterD =  round( (hitter.dexterity*hitter.power/100) )
			percentReduce = targetD - hitterD
			if(percentReduce <= 0)
				percentReduce = 0
			if(prob(percentReduce))//probability of resisting some damage
				hit -= round( ((percentReduce/100)*hit) ) //reduce by % of max hit
			else
				damage = hit
			return damage

		KO()//dead state
			if(!src.kod && src.health == 0)//if not kod yet
				src.move_disabled = 1
				src.kod = 1
				flick("koflick",src)
				src.icon_state = "ko"
				src<<"Oh dear! you have been knocked out."
				sleep(5)
				src<<"<b>Respawning in 5 seconds...</b>"
				spawn(50) src.respawn()

			else return


atom
	proc
		PushEnemy(mob/e, tileOffset, pixelOffset)
			var/static/step = 0 			// How far we have moved (tiles).
			var/static/pixel_step = 0		// How far we have moved in pixels.
			//
			//var/list/acceptedTypes = typesof(/turf)//(typesof(/atom) - /area - /mob -/atom -/atom/movable)
			e.canMove = 0					// We don't want the enemy to move while their being pushed.

			pixel_step += pixelOffset		// Update the amount of pixel movement.

			// Here you should check the tile offset. If we only want to move the player
			// by 1 tile then this is pretty pointless. If we want to move the player
			// more than 1 tile, then we'll have something really interesting going on.
			var/tmp/pointOfStoppage[] = list("x"=0,"y"=0,"z"=0)

		//	for(var/item in acceptedTypes)
		//		world << "[item]: [acceptedTypes[item]]"
		//	sleep(20)

			switch (src.dir)
				if (NORTH)
					//(a.type in acceptedTypes) : istype(a, acceptedTypes)-----block(e.loc, locate(e.x,e.y-tileOffset,e.x))orange(tileOffset,src)
					for(var/atom/a in orange(tileOffset+1,src))
						if(a.density==1 && isturf(a))
							//world << "testing path plotted: ([a.x],[a.y],[a.z])" //debug
							pointOfStoppage["x"] = a.x
							pointOfStoppage["y"] = a.y
							pointOfStoppage["z"] = a.z

							break; break;

				if (SOUTH)
					for(var/atom/a in orange(tileOffset+1,src))
						if(a.density==1 && isturf(a))
						//	world << "testing path plotted: ([a.x],[a.y],[a.z])" //debug
							pointOfStoppage["x"] = a.x
							pointOfStoppage["y"] = a.y
							pointOfStoppage["z"] = a.z
							break; break;
				if (EAST)
					for(var/atom/a in orange(tileOffset+1,src))

						if(a.density==1 && isturf(a))
						//	world << "testing path plotted: ([a.x],[a.y],[a.z])" //debug
							pointOfStoppage["x"] = a.x
							pointOfStoppage["y"] = a.y
							pointOfStoppage["z"] = a.z
							break; break;
				if (WEST)
					for(var/atom/a in orange(tileOffset+1,src))
						if(a.density==1 && isturf(a))
						//	world << "testing path plotted: ([a.x],[a.y],[a.z])" //debug
							pointOfStoppage["x"] = a.x
							pointOfStoppage["y"] = a.y
							pointOfStoppage["z"] = a.z
							break; break;
			//debug stuff V
			//world << {"\nshould be stored values of\n a.loc: ([pointOfStoppage["x"]], [pointOfStoppage["y"]], [pointOfStoppage["z"]])"}
			//sleep(20)
			if (tileOffset == 1)
				step++
			else if(32 - pixel_step <= 0)
				step++
				pixel_step = 0
			//debug stuff V
			//world << "step: [step]"
			// Here we'll just wait 1/10 of a second before we call the function again. Also,
			// we base the movement of the enemy from our direction.
			spawn(1)
				//flick("push back",e) //push back state
				if (step != tileOffset)
					switch (src.dir)
						if (NORTH)
							var/value = round(((e.y-1)*32 + pixelOffset)/32) + 1
							if(pointOfStoppage["y"]!= 0 && value >= pointOfStoppage["y"])
								//opposite
								e.pixel_y -= pixelOffset
								e.dir = NORTH
							else
								e.pixel_y += pixelOffset
								e.dir = SOUTH
						if (SOUTH)
							var/value = round(((e.y-1)*32 - pixelOffset)/32) + 1
							if(pointOfStoppage["y"]!= 0  && value <= pointOfStoppage["y"])
								//opposite
								e.pixel_y += pixelOffset
								e.dir = SOUTH
							else
								e.pixel_y -= pixelOffset
								e.dir = NORTH
						if (EAST)
							var/value = round(((e.x-1)*32+ pixelOffset)/32) + 1
							if(pointOfStoppage["y"]!= 0  && value >= pointOfStoppage["x"])
								e.pixel_x -= pixelOffset
								e.dir = EAST
							else
								e.pixel_x += pixelOffset
								e.dir = WEST
						if (WEST)
							var/value = round(((e.x-1)*32 - pixelOffset)/32) + 1
							if(pointOfStoppage["y"]!= 0  && value <= pointOfStoppage["x"])
								e.pixel_x += pixelOffset
								e.dir = WEST
							else
								e.pixel_x -= pixelOffset
								e.dir = EAST

					flick("push back",e) //push back state
					PushEnemy(e, tileOffset, pixelOffset)
				else
					switch (src.dir)
						if (NORTH)
							var/value = e.y+step
							if(pointOfStoppage["y"]!= 0  && value >= pointOfStoppage["y"])
								//opposite
								e.loc = locate(e.x, e.y-step, 1)
							else
								e.loc = locate(e.x, e.y+step, 1)
						if (SOUTH)
							var/value = e.y-step
							if(pointOfStoppage["y"]!= 0  && value <= pointOfStoppage["y"])
								//opposite
								e.loc = locate(e.x, e.y+step, 1)
							else
								e.loc = locate(e.x, e.y-step, 1)
						if (EAST)
							var/value = e.x+step
							if(pointOfStoppage["x"]!= 0  && value >= pointOfStoppage["x"])
								e.loc = locate(e.x-step, e.y, 1)
							else
								e.loc = locate(e.x+step, e.y, 1)
						if (WEST)
							var/value = e.x-step
							if(pointOfStoppage["x"]!= 0  && value <= pointOfStoppage["x"])
								e.loc = locate(e.x+step, e.y, 1)
							else
								e.loc = locate(e.x-step, e.y, 1)
				/* <.<	if (NORTH)
							e.loc = locate(e.loc.x, e.loc.y+step, 1)
						if (SOUTH)
							e.loc = locate(e.loc.x, e.loc.y-step, 1)
						if (EAST)
							e.loc = locate(e.loc.x+step, e.loc.y, 1)
						if (WEST)
							e.loc = locate(e.loc.x-step, e.loc.y, 1)
				*/

					// We want to reset these variables. The pixel_x and pixel_y distort the
					// location of the character and we want to make sure we set them back to 0.
					// Furthermore we want to set step and pixel_step back to 0 since they are
					// static variables.

					pointOfStoppage["x"] = 0
					pointOfStoppage["y"] = 0
					pointOfStoppage["z"] = 0
					e.canMove = 1
					e.pixel_x = -15
					e.pixel_y = 0
					step = 0
					pixel_step = 0
