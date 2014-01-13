obj

	SkillGrid
		icon ='skillSlots2.png'
		layer = 1
		Green
			screen_loc = "mapGreen:1:14,1:15"
		Red
			screen_loc = "mapRed:1:14,1:15"
		Blue
			screen_loc = "mapBlue:1:14,1:15"
		Black
			screen_loc = "mapBlack:1:14,1:15"

	SkillBox
		var
			free
		icon = 'skillBox.dmi'
		layer = 3

///list for each skills tab


mob
	var
		///item lists//
		list
			GreenSkills = list()//Melee/Taijutsu
			RedSkills = list()//weaponry
			BlueSkills = list()//Ninjutsu/chakra
			BlackSkills = list()//????
		OpenK = 0
		sizeSkill = 20
		obj/SkillBox/S_boxesGreen[20]
		obj/SkillBox/S_boxesRed[20]
		obj/SkillBox/S_boxesBlue[20]
		obj/SkillBox/S_boxesBlack[20]

	verb
	////////////////TEMPORARY TEST VERBS////////////////////
		testSkill()//adding Skill
			var/obj/Skillcards/Taijutsu/BodySlam/new_item = locate() in usr.GreenSkills

			if(new_item)//if you already have it
				return

			else
				new_item = new()
				usr.GreenSkills.Add(new_item)
				UpdateSkill(GreenSkills[GreenSkills.len])
		testSkill2()//adding Skill
			var/obj/Skillcards/Weaponry/Shuriken/new_item = locate() in usr.RedSkills

			if(new_item)//if you already have it
				return

			else
				new_item = new()
				usr.RedSkills.Add(new_item)
				UpdateSkill(RedSkills[RedSkills.len])
		testSkill3()//adding Skill
			var/obj/Skillcards/Ability/TagActivate/new_item = locate() in usr.BlueSkills

			if(new_item)//if you already have it
				return

			else
				new_item = new()
				usr.BlueSkills.Add(new_item)
				UpdateSkill(BlueSkills[BlueSkills.len])
	///////////////TEMPORARY TEST VERBS/////////////////////////

		showSkill()//macro K
			set hidden = 1
			if(src.loginscreen)
				return
			else
				if(OpenK==0)//if skillbox is not open

					winset(src, "SkillHUD", "is-visible=true; focus = false")
					winset(src, "SkillHUD", "pos=800,220")
					OpenK = 1
					//winset(src,"1-main.main","focus=true")//keeps focus on map screen
				else
					winset(src, "SkillHUD", "is-visible=false; focus = false")
					OpenK = 0

		showRED()//button
			winset(src,"SkillHUD.childControl","left = SkillRed")//changes map element
			winset(src,"SkillHUD.InfoLabel","text = Weaponry")//change label text


		showGREEN()//button
			winset(src,"SkillHUD.childControl","left = SkillGreen")
			winset(src,"SkillHUD.InfoLabel","text = Melee")//change label text

		showBLUE()//button
			winset(src,"SkillHUD.childControl","left = SkillBlue")
			winset(src,"SkillHUD.InfoLabel","text = Ability")//change label text

		showBLACK()//button
			winset(src,"SkillHUD.childControl","left = SkillBlack")
			winset(src,"SkillHUD.InfoLabel","text = Special")//change label text


	proc
		UpdateSkill(obj/Skill)
			if(Skill.SkillType == "Taijutsu")//if it is a melee/taijutsu skill
				for(var/obj/SkillBox/slot in S_boxesGreen)//put in the right tab
					if(slot.free=="TRUE")
						Skill.screen_loc  = slot.screen_loc//stores the current box location/transfer the box location to the shirt location
						usr.client.screen += Skill //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						usr<<"You learned [Skill.name]."
						break//if an item is placed, break out of loop

					else if(slot == S_boxesGreen[size])
						usr<<"You do not have enough space."

			else if(Skill.SkillType =="Weaponry")//weaponry type
				for(var/obj/SkillBox/slot in S_boxesRed)//put in the right tab
					if(slot.free=="TRUE")
						Skill.screen_loc  = slot.screen_loc//stores the current box location/transfer the box location to the shirt location
						usr.client.screen += Skill //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						usr<<"You learned a new weapon type: [Skill.name]."
						break//if an item is placed, break out of loop

					else if(slot == S_boxesRed[size])
						usr<<"You do not have enough space."

			else if(Skill.SkillType =="Ability")//Ability type
				for(var/obj/SkillBox/slot in S_boxesBlue)//put in the right tab
					if(slot.free=="TRUE")
						Skill.screen_loc  = slot.screen_loc//stores the current box location/transfer the box location to the shirt location
						usr.client.screen += Skill //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						usr<<"You learned [Skill.name]."
						break//if an item is placed, break out of loop

					else if(slot == S_boxesBlue[size])
						usr<<"You do not have enough space."

			else if(Skill.SkillType =="Special")//Ability type
				for(var/obj/SkillBox/slot in S_boxesBlack)//put in the right tab
					if(slot.free=="TRUE")
						Skill.screen_loc  = slot.screen_loc//stores the current box location/transfer the box location to the shirt location
						usr.client.screen += Skill //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						usr<<"You learned [Skill.name]."
						break//if an item is placed, break out of loop

					else if(slot == S_boxesBlack[size])
						usr<<"You do not have enough space."



		UpdateSkillAll()//update learned skill upon loading
			//green skill updated
			for(var/obj/SkillBox/slot in S_boxesGreen)
				slot.free="TRUE"

			for(var/obj/O in usr.GreenSkills)//for objects in Items list.
				for(var/obj/SkillBox/slot in S_boxesGreen)//try to put in an open slot box
					if(slot.free=="TRUE")
						O.screen_loc = slot.screen_loc//transfer the box location to the shirt location
						usr.client.screen += O //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						break//if an item is placed, break out of loop

			//red skills
			for(var/obj/SkillBox/slot in S_boxesRed)
				slot.free="TRUE"

			for(var/obj/O in usr.RedSkills)//for objects in Items list.
				for(var/obj/SkillBox/slot in S_boxesRed)//try to put in an open slot box
					if(slot.free=="TRUE")
						O.screen_loc = slot.screen_loc//transfer the box location to the shirt location
						usr.client.screen += O //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						break//if an item is placed, break out of loop

			//blue skills
			for(var/obj/SkillBox/slot in S_boxesBlue)
				slot.free="TRUE"

			for(var/obj/O in usr.BlueSkills)//for objects in Items list.
				for(var/obj/SkillBox/slot in S_boxesBlue)//try to put in an open slot box
					if(slot.free=="TRUE")
						O.screen_loc = slot.screen_loc//transfer the box location to the shirt location
						usr.client.screen += O //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						break//if an item is placed, break out of loop

			//black skills
			for(var/obj/SkillBox/slot in S_boxesBlack)
				slot.free="TRUE"

			for(var/obj/O in usr.BlackSkills)//for objects in Items list.
				for(var/obj/SkillBox/slot in S_boxesBlack)//try to put in an open slot box
					if(slot.free=="TRUE")
						O.screen_loc = slot.screen_loc//transfer the box location to the shirt location
						usr.client.screen += O //place the shirt Object on screen
						slot.free = "FALSE" //so it cannot be used while there is an item in
						break//if an item is placed, break out of loop



////Grids for the 4 tabs. placed in Load_HUD
		SkillGridGreen()//displays the Green Grid on mapGreen
			client.screen += new/obj/SkillGrid/Green //edit

			var/obj/SkillBox/boxG
			var/xTile = 1, xPixel = 14, yTile = 4, yPixel = 18
			var/widthLimit = 5

			for(var/i = 1, i <= sizeSkill, i++)
				boxG = new()
				boxG.icon_state = "default"
				boxG.screen_loc = "mapGreen:[xTile]:[xPixel],[yTile]:[yPixel]"
			//	boxS.screen_loc = "mapRed:[xTile]:[xPixel],[yTile]:[yPixel]"
			//	boxS.screen_loc = "mapBlue:[xTile]:[xPixel],[yTile]:[yPixel]"
			//	boxS.screen_loc = "mapBlack:[xTile]:[xPixel],[yTile]:[yPixel]"
				boxG.free = "TRUE"
				S_boxesGreen[i] = boxG
				src.client.screen += boxG
			//	if(i == size) //it's not like this part is really needed, since the for
				if(i%widthLimit == 0)   //loop ends right after these values get assigned, but anyway.
					//r++
					//c = 1
					yTile -= 1
					yPixel -= 1
					xTile = 1
					xPixel = 14
				else
					//c++
					xTile += 1
					xPixel += 1

		SkillGridRed()//displays the Red Grid on mapRed
			client.screen += new/obj/SkillGrid/Red

			var/obj/SkillBox/boxR
			var/xTile = 1, xPixel = 14, yTile = 4, yPixel = 18
			var/widthLimit = 5

			for(var/i = 1, i <= sizeSkill, i++)
				boxR = new()
				boxR.icon_state = "default2"
			//	boxS.screen_loc = "mapGreen:[xTile]:[xPixel],[yTile]:[yPixel]"
				boxR.screen_loc = "mapRed:[xTile]:[xPixel],[yTile]:[yPixel]"
			//	boxS.screen_loc = "mapBlue:[xTile]:[xPixel],[yTile]:[yPixel]"
			//	boxS.screen_loc = "mapBlack:[xTile]:[xPixel],[yTile]:[yPixel]"
				boxR.free = "TRUE"
				S_boxesRed[i] = boxR
				src.client.screen += boxR
			//	if(i == size) //it's not like this part is really needed, since the for
				if(i%widthLimit == 0)   //loop ends right after these values get assigned, but anyway.
					yTile -= 1
					yPixel -= 1
					xTile = 1
					xPixel = 14
				else
					xTile += 1
					xPixel += 1

		SkillGridBlue()//displays the Blue Grid
			client.screen += new/obj/SkillGrid/Blue

			var/obj/SkillBox/boxB
			var/xTile = 1, xPixel = 14, yTile = 4, yPixel = 18
			var/widthLimit = 5

			for(var/i = 1, i <= sizeSkill, i++)
				boxB = new()
				boxB.icon_state = "default3"
				boxB.screen_loc = "mapBlue:[xTile]:[xPixel],[yTile]:[yPixel]"
				boxB.free = "TRUE"
				S_boxesBlue[i] = boxB
				src.client.screen += boxB
			//	if(i == size) //it's not like this part is really needed, since the for
				if(i%widthLimit == 0)   //loop ends right after these values get assigned, but anyway.
					yTile -= 1
					yPixel -= 1
					xTile = 1
					xPixel = 14
				else
					xTile += 1
					xPixel += 1

		SkillGridBlack()//displays the Black Grid
			client.screen += new/obj/SkillGrid/Black

			var/obj/SkillBox/boxBlack
			var/xTile = 1, xPixel = 14, yTile = 4, yPixel = 18
			var/widthLimit = 5

			for(var/i = 1, i <= sizeSkill, i++)
				boxBlack = new()
				boxBlack.icon_state = "default4"
				boxBlack.screen_loc = "mapBlack:[xTile]:[xPixel],[yTile]:[yPixel]"
				boxBlack.free = "TRUE"
				S_boxesBlack[i] = boxBlack
				src.client.screen += boxBlack
			//	if(i == size) //it's not like this part is really needed, since the for
				if(i%widthLimit == 0)   //loop ends right after these values get assigned, but anyway.
					yTile -= 1
					yPixel -= 1
					xTile = 1
					xPixel = 14
				else
					xTile += 1
					xPixel += 1

