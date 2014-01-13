
mob

	var
	//	frozen=0
	//	loginscreen=0
		arrow = new/obj/Arrow()

	Login()

		/*
		if(findtext(src.key,"Guest",1,6)) //If it's a guest
			usr	<<	"<center><font size=+4>Guests not allowed" //we crush him
			del src //Because we don't like guests right?
		*/
	//	src.frozen=TRUE//Make the variable "frozen" 1
		/*
		SplashImage = new /obj/SplashScreen/byondSplash(src.client) //create the splash image
		animate(SplashImage, alpha = 0, time = 90)//fade away
		sleep(90)
		del SplashImage//deletes it after it's finish
		*/

		..()



	Logout()
		//nothing yet


	verb
		Select()
			set hidden=1//Hides the verb

			if(inCreate == 1) //if creation is open
				return //can't select another option until closed

			else if(inLoad == 1)//if load menu is open
				return// can't do anything until closed

			else
				for(var/obj/Arrow/a in src.client.screen)//For the Arrow on the player's screen
					var/s = a.screen_loc
					switch(s)
						if("4:5,9:16")//If the screen_loc of the Arrow is "4,8"
							src.NewCharacter()//Calls the NewCharacter() procedure
						if("4:5,7:24")
							src.LoadCharacter()
						if("4,5:28")
							src.Options()

			//if(src.loginscreen == FALSE)
				//user can speak

obj
	icon='login-arrow.dmi'

	Arrow
		layer = MOB_LAYER +301//So it will appear over the Login turf
		screen_loc="4:5,9:16"//The arrow's position on the player's screen.

turf
	Login
		icon='menu screen stretch3.png'
		layer = MOB_LAYER + 300
