mob
	var
		tmp
			//Caster//mob who is using it
			placed = 0
obj
	Tag
		var/Caster
		icon ='tag.dmi'
		icon_state = "idle"
		layer = 4

	Explosion
		icon = 'explosion.dmi'
		icon_state =""
		layer = MOB_LAYER + 10
		pixel_x = - 15


mob
	var
	//some var in player-combat
	cooldown
	SkillCost//amount of energy/chakra used to perform a skill
	range//used in tag, to increase range proximitay

	verb
		/////Melee skills
		Bodyslam()
			if(src.kod == 1) return
			if(src.attacking == 0)
				src.attacking = 1
				src.move_disabled = 1
				flick("slam",src)
				for(var/mob/M in get_step(src,usr.dir))
					if(M.kod == 1) //if target is kod
						src.move_disabled = 0
						return
					sleep(4)//synching animation purposes
					src.PushEnemy(M,3,16)//2 tiles at rate of 16 px per 1/10 sec
				spawn(10)//doesn't allow movement while slam is in process
				//basic cooldown..
					src.move_disabled = 0
					src.attacking = 0
			else return

		///Ability/Ninjutsu skills
		TagDown()
			var/obj/Tag/t
			//var holder
			if(src.kod == 1 || src.attacking ==1||src.move_disabled ==1)//if user is dead/atking or cant move
				return//dont place tag

			else if(src.attacking == 0 && src.placed == 0)
				src.placed = 1
				attacking = 1
				src.move_disabled = 1
					//world << "loc: ([x],[y],[z])"
				t=new(src.loc)
				t.Caster = src//belongs to user
				src<<"You set down a tag."
				spawn(5)
					src.move_disabled = 0
					src.attacking = 0

			else if(src.attacking == 0)//if one is already placed... detonate it
				src.attacking = 1
				for(t in oview(src))//if tag is in sight and is yours
					if(t.Caster == src)
						src<<"Detonating tag..."
						src.show_explosion(t)
						spawn(10)
							src.placed = 0
							src.attacking = 0
					else src.attacking = 0




		//weaponry Skills

		//Special Skills

	proc
		execute(obj/Skillcards/skill)
			call(src, skill.action)()



		show_explosion(obj/t)
			var/obj/Explosion/o;var/mob/a
			var
				damage

			o=new(t.loc)
			for(a in orange(o, 1)) //mob that is a tile away
				var
					diffx = abs(a.x - t.x)
					diffy = abs(a.y - t.y)

				if(diffx != diffy || a.loc == t.loc)
					if(a.kod == 1)//if person is kod
						return
					a.move_disabled = 1//cant move while being blown
					o.dir = pick(NORTH, SOUTH, EAST, WEST)
					o.PushEnemy(a,2,16)
					spawn(10)
						if(istype(t,/obj/Tag))//if the obj is a Tag
							damage = tagFormula(src,a)
							a.health -= damage
							a<<"[a] took [damage] damage from [src]'s Tag!"
						//else if (other explosive obj)
							a.move_disabled = 0
							a.updateHealth()

			spawn(10)
				for(var/obj/Explosion/all)	//deletes explosion effect
					del all
				del t//deletes tag


			//var
				//X = t.x;Y = t.y;Z = t.z //gets location of obj t
			/*
			//creates the explosions NESW of obj t
			o=new();o1=new();o2=new();o3=new()
			o.Move(locate(X+1,Y,Z))
			o1.Move(locate(X-1,Y,Z))
			o2.Move(locate(X,Y+1,Z))
			o3.Move(locate(X,Y-1,Z))
			//o.mouse_opacity = 9000


			for(var/atom/a in orange(t,1))
				var
					diffx = abs(a.x - t.x)
					diffy = abs(a.y - t.y)
				if(isturf(a) && diffx != diffy)
					world << "a : [a], a.loc: ([a.x],[a.y],[a.z])"
					o = new/obj/Explosion(locate(a.x,a.y,a.z))
				if(ismob(a) in orange(o, 1))
					o.PushEnemy(a,2,16)

					*/






