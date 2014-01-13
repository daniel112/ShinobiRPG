//here is where we initialize HUD images, non interactable
/////HUD
obj
	HUD
		SkillBar
			icon = 'skillboxV3.png'
			layer = MOB_LAYER+100
			screen_loc = "25:15,6:15"

		HealthBar
			icon = 'hud-health-empty.png'
			layer = MOB_LAYER+100
			screen_loc = "3:16,20:24"


		ChakraBar
			icon = 'hud-chakra-empty.png'
			layer = MOB_LAYER+100
			screen_loc = "3:16,19:32"

		V_HUD
			icon = 'VillageIcon.dmi'
			icon_state ="default"
			layer = MOB_LAYER+100
			screen_loc = "1:30,20"

		ExpBar
			icon = 'hud-exp-empty.png'
			layer = MOB_LAYER+101
			screen_loc = "1:28,19:20"

		//leveling
		LevelUp
			icon = 'levelup.dmi'
			icon_state ="level"
			layer = MOB_LAYER + 30//above most things
////scalable HUD

	//hudMeters
		HealthFull
			icon = 'hud-health-full.png'
			layer = MOB_LAYER+101
			New(client/c)
				screen_loc = "3:16,20:25"
				//world << "FROM HUDS! Client reads as: [c]"
				c.screen+=src

		ChakraFull
			icon = 'hud-chakra-full.png'
			layer = MOB_LAYER+101
			New(client/c)
				screen_loc = "3:16,19:32"
				//world << "FROM HUDS! Client reads as: [c]"
				c.screen+=src

		ExpFull
			icon = 'hud-exp-full.png'
			layer = MOB_LAYER+104
			New(client/c)
				screen_loc = "2:22,19:24"
				c.screen+=src

	SplashScreen
		byondSplash
			icon = 'byond splashV2.png'
			layer = MOB_LAYER + 303
			New(client/c)
				screen_loc = "1:07,1:10"
				c.screen+=src




