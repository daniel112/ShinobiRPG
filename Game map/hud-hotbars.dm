client/proc/StartHotkeys()// This is the proc for actually giving the bare hud as objects to the user, implement this
	screen += new/obj/Keys/Key1()
	screen += new/obj/Keys/Key2()
	screen += new/obj/Keys/Key3()
	screen += new/obj/Keys/Key4()
	screen += new/obj/Keys/Key5()
	screen += new/obj/Keys/Key6()
	screen += new/obj/Keys/Key7()
	screen += new/obj/Keys/Key8()
	screen += new/obj/Keys/Key9()
	screen += new/obj/Keys/Key0()
//////numbers//////////////////////
	screen += new/obj/Numbers/Key1()
	screen += new/obj/Numbers/Key2()
	screen += new/obj/Numbers/Key3()
	screen += new/obj/Numbers/Key4()
	screen += new/obj/Numbers/Key5()
	screen += new/obj/Numbers/Key6()
	screen += new/obj/Numbers/Key7()
	screen += new/obj/Numbers/Key8()
	screen += new/obj/Numbers/Key9()
	screen += new/obj/Numbers/Key0()

obj/Hotkeys
	layer = MOB_LAYER + 101
	icon='hotbars.dmi'
	var/locc
	New(client/C)// Creating on the clients screen, so that no one else can see the hotbars
		screen_loc=locc
		C.screen+=src

/*	box1
		icon_state = "1"
		locc = "15:10,4:22"
		Click()
			Apopup(usr,"You clicked box1")// An output for set-in-stone macro's

	box2
		icon_state = "2"
		locc = "16:17,4:22"
		Click()
			Apopup(usr,"You clicked box2")// An output for set-in-stone macro's
*/

obj/Keys// Creating blank boxes so that the hotbars 'identity' remains hovering
	layer=MOB_LAYER+101// over skillcards added to the bar
	icon='hotbars.dmi'
	icon_state = "default"
	var
		locc
		number //change this value for skillcard placed on box. 0 means its empty
	New()//client/C)
		screen_loc=locc
	//	C.screen+=src
	Key1
		locc = "25:18,17:25"
		number = 1
	Key2
		locc = "25:18,16:17"
		number = 2
	Key3
		locc = "25:18,15:9"
		number = 3
	Key4
		locc = "25:18,14:1"
		number = 4
	Key5
		locc = "25:18,12:25"
		number =5
	Key6
		locc = "25:18,11:17"
		number = 6
	Key7
		locc = "25:18,10:9"
		number = 7
	Key8
		locc = "25:18,9:1"
		number = 8
	Key9
		locc = "25:18,7:25"
		number = 9
	Key0
		locc = "25:18,6:17"
		number = 0

obj/Numbers
	layer=MOB_LAYER +102 //testing
	icon='hotbars.dmi'
	var
		locc
	New()//client/C)
		screen_loc=locc
	//	C.screen+=src
	Key1
		icon_state = "1"// The hotbar identities, this is the '~' identity, it will hover over skillcards
		locc = "25:18,17:25"

	Key2
		icon_state = "2"
		locc = "25:18,16:17"

	Key3
		icon_state = "3"
		locc = "25:18,15:9"

	Key4
		icon_state = "4"
		locc = "25:18,14:1"

	Key5
		icon_state = "5"
		locc = "25:18,12:25"

	Key6
		icon_state = "6"
		locc = "25:18,11:17"

	Key7
		icon_state = "7"
		locc = "25:18,10:9"

	Key8
		icon_state = "8"
		locc = "25:18,9:1"

	Key9
		icon_state = "9"
		locc = "25:18,7:25"

	Key0
		icon_state = "0"
		locc = "25:18,6:17"



mob
	var
		macList[] = list()
	//	obj/Keys/macbox[10]

	proc
		MacroBarUpdate()
			var/macros=params2list(winget(usr,null,"macro"))
			for(var/m in src.macList)
				var/obj/Keys/inner = src.macList["[m]"]
				for(var/ms in macros)
					winset(usr,"[inner.number]","parent=[ms];name=[inner.number];command=[m]")
				inner.screen_loc= inner.locc
				src.client.screen+= inner

		/*MacBox()
			var/obj/Keys/box
			var/yTile = 17, yPixel = 25
			var/widthLimit = 1

			for(var/i = 1, i <= 10, i++)
				box = new()
				box.screen_loc = "25:18,[yTile]:[yPixel]"

				macbox[i] = box
				src.client.screen += box
				if(i%widthLimit == 0)   //loop ends right after these values get assigned, but anyway.
					yTile -= 1
					yPixel -= 1
				else
					xTile += 1
					xPixel += 1
		*/


obj
	var/tmp
		screenlocation
		SlotLoc = 0
		SkillType = "None"
		description
		action// proc or verb name

	Skillcards
		layer = MOB_LAYER+101

		Taijutsu//Green Skills
			icon = 'Taijutsu.dmi'
			SkillType = "Taijutsu"

			BodySlam
				icon_state = "slam"
				name = "Body Slam"
				action = "Bodyslam"

				description = {" Push back your enemy for an easy escape!\n
								Skillcost:N/A"}
				//Click()
					//usr.Bodyslam()//calls bodyslam verb

		Weaponry//Red skills
			icon = 'Weaponry.dmi'
			SkillType = "Weaponry"

			Shuriken
				icon_state = "shuriken"
				name = "Shuriken"
				action = "Shuri"
				//Click()
				//	alert("Shuriken stuff")

		Ability//aka jutsus. Blue skills
			icon = 'Jutsus.dmi'
			SkillType = "Ability"

			TagActivate
				icon_state = "expTag"
				name = "Exploding Tag(activate)"
				action = "TagDown"
				description = {"Set up an explosive trap, and detonate it anytime with your chakra energy!\n
								Skill cost: 10 Chakra"}
			//	Click()
					//usr.TagDown()

		Special//Black skills
			//icon = ''
			SkillType = "Special"


		New()
			..()
			src.mouse_drag_pointer = icon(src.icon,src.icon_state)// Changes the mouse's icon when holding a technique tile

		Click(obj,Skillcards,params)
			params = params2list(params)
			if("left" in params) //usr<<"stuff"
				usr.execute(src)

			else if("right" in params)//right click
				winset(usr,"SkillHUD.label1","text = \"[src.description]")

		MouseDrop(obj/over_object,src_location,over_location,src_control,over_control,params)
			var/global/i = 1
			if(istype(over_object,/obj/Keys))
				var/obj/Keys/A = over_object
				var/macros=params2list(winget(usr,null,"macro"))

			//	for(var/obj/Keys/A in usr.client.screen) //just realised you don't need this
			//		if(A==over_object)					 //including this
				usr.macList["[src.action]"] = A
				A.overlays-- //deletes any other overlay on it first
				A.overlays+= image(icon = src.icon,icon_state = src.icon_state)
				for(var/m in macros)
					winset(usr,"[A.number]","parent=[m];name=[A.number];command=[src.action]")

			else
				return

			/*if(Slot)// must be dropped in a slot, must be on your screen due it having to be in a slot etc.
				usr.client.screen += src
				src.screenlocation = src.screen_loc
				src.screen_loc=Slot.screen_loc
				if(istype(Slot,/obj/Skillcards))
					usr.client.screen -= Slot
					//Slot.screenlocation = null
			else
				..()
			*/


		/*MouseDrop(src)
			if(istype(src,/obj/Keys)||istype(src,/obj/Skillcards/Taijutsu))// must be a skillcard being dropped onto a key
				..()
			//if(istype(src,/obj/InventBox)||istype(src,/obj/ItemObj/Top))//for invent window
			//	..()
			//if(istype(src,/obj/Keys)||istype(src,/obj/Skillcards/Ninjutsu))// as i named my 'hud slots' under obj/Keys its making sure that they're being dropped onto the right area's
			//	..()													// and as i named my skillcard sections obj/Skillcards then further divided them into Ninjutsu and Taijutsu, it's making sure

			else														// that they are defined skill cards
				return
		*/
