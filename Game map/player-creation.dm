mob
	var
		inCreate = 0
		inLoad = 0
		charScreen
		loadScreen
		char_name


	verb
	//////////////////////////Closing Window Verbs//////////////////////
		exitCreate()//closing character screen
			set hidden=1
			del charScreen//deletes the HUD image
			src.inCreate=0//no longer in creation
			winset(src,"window-create-outer","is-visible=false")//show exit


		exitLoad()//closing Load screen
			set hidden=1
			del loadScreen//deletes HUD image
			src.inLoad=0//no longer in load
			winset(src,"window-load-outer","is-visible=false")//hides window
	/////////////////////////End Closing Window Verbs////////////////////////////



//////////////Loading Slots/////////////////////////////////
		LoadOne()//slot one
			set hidden = 1
			src.Load_Mob(1)

			//need to make it wait 5 seconds before being able to call again


		LoadTwo()//slot two
			set hidden = 1
			src.Load_Mob(2)



		LoadThree()//slot three
			set hidden = 1
			src.Load_Mob(3)

////////////End Loading Slots///////////////////////////////

////////////////////////Creation Character/////////////////////
		FinishCreation()//when okay is pressed
			set hidden=1
			char_name = winget(src,"window-character.inputChar","text")
			if(Review_Name(char_name))//checks the name if it's legal
				//winset(src,"window-character.inputChar","[]")
				return
			if(src.icon == null)//if user did not choose skin color
				Apopup(src,"Please select a skin tone.")
				return
			if(src.Village == null)//if user did not choose Village
				Apopup(src,"Please select a Village.")
				return
		//	if(hairOverlay == null)//must select a hair style
		//		Apopup(src,"Please select a hairstyle.")
			//	return

			else //if everything else is good to go
				exitCreate()//closes create window first
				if(fexists("players/[src.ckey]/[src.ckey](1).sav")) // checks if there is a file in 1
					if(fexists("players/[src.ckey]/[src.ckey](2).sav")) // if there's a file in 1,2
						if(fexists("players/[src.ckey]/[src.ckey](3).sav")) // if theres a file in 1,2,3
							Apopup(src,"You cannot create any more character(s)!")
							src.icon = null
							return

						else//if slot 1 and 2 is full, but 3 is not, save at 3
							Del_Menu()
							Load_HUD()
							src.name = char_name //name
							src.savefile3=1 // makes it so the save proc saves to file 3
							src.loc=locate(10,15,1)//MAY BE TEMPORARY
						//	move_type = DIAGONAL
						//	login
						//	src.client.StartHotkeys()//calls hotbars.dm
							src.Auto_Save() // starts the auto save loop



					else//if slot 1 is empty but slot 2 is open, then save at 2
						Del_Menu()
						Load_HUD()
						src.name = char_name //name
						src.savefile2=1 // makes it so the save proc saves to file 2
						src.loc=locate(10,15,1)//MAY BE TEMPORARY
					//	move_type = DIAGONAL
					//	src.client.StartHotkeys()//calls hotbars.dm
						src.Auto_Save() // starts the auto save loop


				else //if slot 1 is empty then save there
					Del_Menu()
					Load_HUD()
					src.name = char_name //name
					//winset(src,"window-load.name1","text =[]")
					src.savefile1=1 // makes it so the save proc saves to file 1

					/*for(var/i=1; i <= world.maxy; i++)
						for(var/j=1; j <= world.maxx; j++)
							new /turf/grass/Main(locate(j, i, 3))
					src.loc = locate(15, 15, 3)
					*/
					src.loc=locate(10,15,1)//MAY BE TEMPORARY
					//src.client.StartHotkeys()//calls hotbars.dm
					src.Auto_Save() // starts the auto save loop


		BaseChoiceTan()
			set hidden=1
			src.icon=null //incase another base was chosen before, reset it first
			src.icon='base.dmi'
			src.icon_state = "Run"
			Apopup(src,"Tan skin selected.")


		HairChoiceSpiky()
			set hidden=1
			alert("Hair set is currently disabled.")
			/*hairOverlay = null //make it bald first before adding a new 1
			hairOverlay =/obj/overlay/hairSpiky
			overlays += hairOverlay
			*/
//////////////End Creation Character/////////////////////////////////////

	proc
		NewCharacter()
			inCreate = 1//you're now in create a character
			winset(src,"window-create-outer","is-visible=true; pos = 630,180")//show character screen
			src.icon = null



		LoadCharacter()
			inLoad = 1
			var
				name_label//slot1 name
				name_label2//slot2 name
				name_label3//slot3 name
				VillageHud//for determining Village icon
				pClass//displays mob class

			if(fexists("players/[src.ckey]/[src.ckey](1).sav"))		///if slot 1 exist
				var/savefile/F = new("players/[src.ckey]/[src.ckey](1).sav")
				name_label = F["name"]
				VillageHud= F["VillageHUD"]
				pClass = F["class"]
				winset(src,"window-load.class1","text =\"[pClass]")
				winset(src,"window-load.name1","text =\"[name_label]")//name label
				winset(src,"window-load.slot1","image ='[VillageHud]'")//village image


			if(fexists("players/[src.ckey]/[src.ckey](2).sav"))	//if slot 2 exist
				var/savefile/F = new("players/[src.ckey]/[src.ckey](2).sav")
				name_label2 = F["name"]
				VillageHud= F["VillageHUD"]
				pClass = F["class"]
				winset(src,"window-load.class2","text =\"[pClass]")
				winset(src,"window-load.name2","text =\"[name_label2]")
				winset(src,"window-load.slot2","image ='[VillageHud]'")

			if(fexists("players/[src.ckey]/[src.ckey](3).sav"))	// if slot3 exist
				var/savefile/F = new("players/[src.ckey]/[src.ckey](3).sav")
				name_label3 = F["name"]
				VillageHud= F["VillageHUD"]
				pClass = F["class"]
				winset(src,"window-load.class3","text =\"[pClass]")
				winset(src,"window-load.name3","text =\"[name_label3]")
				winset(src,"window-load.slot3","image ='[VillageHud]'")

			winset(src,"window-load-outer","is-visible=true;pos= 500,350")





		Options()
				/*
			Place your Delete Character proc here

			*/

		Del_Menu()
			del arrow
			//src.frozen = FALSE
			src.loginscreen = 0

		Load_HUD()
			move_type = DIAGONAL
			loginscreen = 0
			winset(src,"1-main.childButtons","is-visible=true")//show buttons
			winset(src,"1-main.labelCPU","is-visible=true;text=[world.cpu]")
			//show HUDS
			src.ShowInvGrid()// hud-InventoryMAP.dm
			src.SkillGridGreen()//hud-SkillMAP
			src.SkillGridRed()//hud-SkillMAP
			src.SkillGridBlue()//ditto
			src.SkillGridBlack()

			src.client.screen += new/obj/HUD/HealthBar
			full = new/obj/HUD/HealthFull(client) //health filler
			chakra_full = new/obj/HUD/ChakraFull(client) //chakra filler
			exp_full = new/obj/HUD/ExpFull(client) //chakra filler
			src.client.screen += full; src.client.screen+= chakra_full
			src.client.screen += new/obj/HUD/ChakraBar
			src.client.screen += new/obj/HUD/V_HUD
			src.client.screen += new/obj/HUD/ExpBar
			src.client.screen += new/obj/HUD/SkillBar
			//end show HUDS

			src.UpdateVillage()//updates saved village file
			src.UpdateInvAll()//updates inv. see hud-inventoryMAP.dm
			src.UpdateSkillAll()//hud-skillMAP
			src.UpdateOverlay()//hud-invMAP.dm
			sleep(5)

			src.client.StartHotkeys()//calls hotbars.dm
			//spawn(100)
			src.checkState()//if dead or alive
			src.updateExp()
			src.updateChakra()
			src.updateHealth()
			///status
			src.totalpoints()
			src.statUpdatexp()
			src.statUpdateHC()
			src.statUpdatemain()//hud-stats

			world << "[src] Has Connected"

