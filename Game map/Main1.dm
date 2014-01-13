

var/tmp
	Constants/Constants = new()
	//Options/Options = new()

world
	view ="26x21:1" //26x19
	fps = 20
	icon_size=32
	// Set the world's name. This will appear in the title bar.
	name = "Online Test Game"
	// Configure the default mob object players will log in as.
	mob = /mob/player
	hub = "Danny112.AnRPG"
	hub_password = "dnl992004"
	map_format = TOPDOWN_MAP



// The parent class for anything that can show on the map. Let anything visible be bumpable.
atom
	proc/Bumped(mob/M)
		// Subclasses need to implement this if they want to do something when bumped.
		return

overlay

client
	Del()
		..()
		if(istype(mob,/mob/player))
			var/mob/M=usr
			M.Save_Mob()
		del (mob)
		 //..()


mob
	player
		pixel_x = -15  //nudges 15 the base 15 pix, necessary so the player is in the square

	////player verb
		verb
			//tests verbs
			level()
				src.exp = src.max_exp
				src.updateExp()
			add() //for testing health hud

				if(src.health >= max_health)
					src.health = max_health

				else
					src.health+=rand(5,15)
					updateHealth()
				src<<"[src.health]/[src.max_health]"

			sub()	//for testing health hud
				if(src.chakra <= min_chakra)
					src.chakra = min_chakra
				else
					src.chakra-=rand(5,15)
					updateChakra()
				src<<"[src.chakra]/[src.max_chakra]"
			addxp()
				if(src.exp >= src.max_exp)
					src.exp = 0
				else
					src.exp += rand(5,15)
					updateExp()
					src.statUpdatexp()
				src<<"experience:[src.exp]/[src.max_exp]"

				//if(src.exp
			addS()
				src.strength +=10
			addD()
				src.dexterity +=10
			addR()
				src.resistance += 10
			addP()
				src.power +=10
			checkStat()
				src<<"max HP:[src.max_health]/max Chakra:[src.max_health]"
				src<<"exp:[src.exp]/[src.max_exp]"
				src<<"Rank: [src.MainLevel]"
				src<<"Strength:[src.strength]/Dexterity:[src.dexterity]"
				src<<"Power:[src.power]/Resistance:[src.resistance]"
			////tests verbs end


			q_game() //close game
				switch(alert("Are you sure you want to exit?","Exit","Yes","No"))
					if("Yes")
						winset(src, null, "command=.quit")


			toggleChat()//show/hide chat
				if(openChat!= 1)
					winset(src,"1-main.childChat","is-visible = true")
					openChat = 1
				else if(openChat ==1)
					winset(src,"1-main.childChat","is-visible = false")
					openChat = null
	/////////////End player verb/////////////
	var
		//last_x
		//last_y
		//last_z


		tmp/openChat
		tmp/obj/HUD/HealthFull/full; tmp/obj/HUD/ChakraFull/chakra_full //fillers are temporary
		tmp/obj/HUD/ExpFull/exp_full;//obj/HUD/ChatBubble/c_bubble
		tmp/obj/SplashScreen/byondSplash/SplashImage


	proc
		healAll()
			src.health = src.max_health
			src.chakra = src.max_chakra

		respawn()//used upon respawn
			src.kod= 0
			src.healAll()
			src.updateHealth();src.updateChakra()
			src.checkState()
			src.attacking = 0
			src.loc=locate(10,15,1) //make location HOME,later

		checkState()
			if(src.kod==1)
				src.move_disabled = 1
				spawn(50) src.respawn()
			else
				src.move_disabled = 0
				src.icon_state ="Run"
		/*DisableMove()//movement-dynamic.dm
			move_disabled=1
			//src<<"Movement is now disabled."

		EnableMove()//movement-dynamic.dm
			move_disabled=0
			//src<<"Movement is now enabled!"
		*/
	//////////////////////////////////////////////
		updateExp()
			var
				fractional=(src.exp / src.max_exp)//ex: 90/100 = 9/10
				leftover = src.exp - src.max_exp //exp carried over
				icon/hudIcon = icon(exp_full.icon)//defines icon variable
				px = hudIcon.Width() //checks width of "chakra_full"

			if(src.exp <= 0)
				fractional = 0
				src.exp = 0
			else if( src.exp >= src.max_exp)
				src.LevelUp()//level up
				fractional = leftover/src.max_exp
				src.exp = leftover

			px -= px * fractional// width = width - [width*fraction]
			px = px/2

			var/matrix/M = matrix()  //used to stretch/shrink image
			M.Scale(fractional,1)
			M.Translate(-px,0)
			exp_full.transform = M

		/////health
		updateHealth()
			var
				fractional=(src.health / src.max_health)//ex: 90/100 = 9/10
				icon/hudIcon//defines icon variable
				px  //checks width of "full"

			if(src.health <= 0)
				fractional = 0
				src.health = 0
				if(istype(src,/mob/player))//if src is a player
					src.KO()

			else if( src.health >= src.max_health) //if health exceeds max health
				fractional = 1
				src.health = src.max_health

			else if(src.health != 0)
				src.kod = 0
				if(src.move_disabled)
					src.move_disabled = 0
				src.icon_state ="Run"

			if(src.client)
				hudIcon = icon(full.icon)
				px = hudIcon.Width()
			else
				return

			px -= px * fractional// width = width - [width*fraction]
								//storing # pixels taken away/gained
			px = px/2

			var/matrix/M = matrix()//used to stretch/shrink image
			M.Scale(fractional,1)
			M.Translate(-px,0)
			full.transform = M


	///////////////////////////////////////////////

		updateChakra()
			var
				fractional=(src.chakra / src.max_chakra)//ex: 90/100 = 9/10

				icon/hudIcon = icon(chakra_full.icon)//defines icon variable
				px = hudIcon.Width() //checks width of "chakra_full"

			if(src.chakra <= 0)
				fractional = 0
				src.chakra = 0
			else if( src.chakra >= src.max_chakra)
				fractional = 1
				src.chakra = max_chakra

			px -= px * fractional// width = width - [width*fraction]
			px = px/2

			var/matrix/M = matrix()  //used to stretch/shrink image
			M.Scale(fractional,1)
			M.Translate(-px,0)
			chakra_full.transform = M
		//////////////////////////////////////////////////////////////

		////level///////////////
		LevelUp()
			if(src.MainLevel == maxMainlvl)
				return
			src.max_exp += round( (0.10*src.max_exp) + (MainLevel*10) )//eh
			src.max_health += round( (0.10*src.max_health) + (src.strength * 10) )
			src.max_chakra += round( (0.10*src.max_chakra) + (src.dexterity * 10) )
			src.MainLevel += 1
			src.statpoints += 4
			src.healAll()//heals you after level up
			src.updateHealth()
			src.updateChakra()
			src.updateExp()
			src.levelHUD()//level up overlay
			src.totalpoints()//show total AP
			src.statUpdatexp()//update stat HUD for xp
			src.statUpdateHC()//update stat HUD for health and chakra
			src.statUpdatemain()//hud-stats


		levelHUD()
			var/obj/HUD/LevelUp/lev = new()
			overlays += lev
			spawn(9)
				overlays -= lev
				src<<"<b>Congratulations! You are now rank [MainLevel]!"






















