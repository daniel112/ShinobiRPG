mob
	var
		tmp
			savefile1 = 0
			savefile2 = 0
			savefile3 = 0

//var
//	global
		//Slot//for chosing which slot will be loaded

//client
mob
	proc
		Save_Mob() // the save proc
			if(src.savefile1) // if your character is slot 1
				src<<"Character Saved!" // tells you that you saved
				var/savefile/F = new("players/[src.ckey]/[src.ckey](1).sav") // creates the save file
				if(fexists(F)) fdel(F)
				Write(F) // writes your locat
				savefile1=1 // just makes sure you are still in slot 1

			else if(src.savefile2) // slot 2
				src<<"Character Saved!" // tells you that you saved
				var/savefile/F = new("players/[src.ckey]/[src.ckey](2).sav") // creates the save file
				if(fexists(F)) fdel(F)
				Write(F) // writes your location
				savefile2=1 // just makes sure you are still in slot 1

			else if(src.savefile3) // slot 3
				src<<"Character Saved!" // tells you that you saved
				var/savefile/F = new("players/[src.ckey]/[src.ckey](3).sav") // creates the save file
				if(fexists(F)) fdel(F)
				Write(F) // writes your location
				savefile3=1 // just makes sure you are still in slot 1

		Load_Mob(Slot) // load proc
			//switch(Slot)
			if(Slot==1) // if you chose slot 1.....
				var/F = ("players/[src.ckey]/[src.ckey](1).sav")
				if(fexists(F)) // checks if there is a file...
					exitLoad() //must go first, anti spam click
					var/savefile/S = new(F)
					Del_Menu()
					Read(S) // reads the old location
					Load_HUD()
					/////////macro skill load
					MacroBarUpdate()
					///macro skil load
					//sleep(1)
					src.savefile1=1 // makes your character go to slot one for saves
					src.Auto_Save() // starts the auto save loop
				else
					alert("No savefile found in this slot!") // if there is no file...


			else if(Slot==2) // slot 2
				var/F = ("players/[src.ckey]/[src.ckey](2).sav")
				if(fexists(F))
					var/savefile/S = new(F)
					exitLoad() //woot
					Del_Menu()
					Read(S)
					Load_HUD()// yayy
					//////////macro skill load
					MacroBarUpdate()
					///macro skil load
					//sleep(1)
					src.savefile2=1
					src.Auto_Save()
				else
					alert(src,"No savefile found in this slot!")

			else if(Slot==3) // slot 3
				var/F = ("players/[src.ckey]/[src.ckey](3).sav")
				if(fexists(F))
					var/savefile/S = new(F)
					exitLoad() //woot
					Del_Menu()
					Read(S)
					Load_HUD()// yayy
					//////////macro skill load
					MacroBarUpdate()
					///macro skil load
					//sleep(1)
					src.savefile3=1
					src.Auto_Save()
				else
					alert(src,"No savefile found in this slot!")


/*		Delete_Mob()
			switch(alert(src, "Which Slot would you like to delete your character from?", "Delete your character?","Slot 1","Slot 2","Slot 3")) // asks which slot you want to delete
				if("Slot 1") // if you chose slot 1....
					if(fexists("players/[src.ckey]/[src.ckey](1).sav")) // checks if there is a file...
						switch(alert(src, "Delete character from Slot-1? *YOUR CHARACTER WILL BE GONE!*", "Character Deletion", "Yes","No")) // warns you that your character will be gone
							if("Yes") // if you choose yes..
								src<<"<font color=red>Accessing server database...</font>" // sends the message
								var/savefile/F = new("players/[src.ckey]/[src.ckey](1).sav") // accesses save file...
								src<<"<font color=red>Accessing save file...</font>"
								sleep(1)
								src.Read(F) // reads save
								sleep(1)
								fdel("players/[src.ckey]/[src.ckey](1).sav") // deletes saves
								src<<"<font color=red>Savefile deleted.</font>" // another message
								src.Choice() // calls choice proc
							else
								src<<"Okay" // if no
								src.Choice() // calls choice proc
					else
						alert("No savefile found in this slot!")
						src.Choice()
				if("Slot 2") // slot 2
					if(fexists("players/[src.ckey]/[src.ckey](2).sav"))
						switch(alert(src, "Delete character from Slot-2? *YOUR CHARACTER WILL BE GONE!*", "Character Deletion", "Yes","No"))
							if("Yes")
								src<<"<font color=red>Accessing server database...</font>"
								var/savefile/F = new("players/[src.ckey]/[src.ckey](2).sav")
								src<<"<font color=red>Accessing save file...</font>"
								sleep(1)
								src.Read(F)
								sleep(1)
								fdel("players/[src.ckey]/[src.ckey](2).sav")
								sleep(1)
								src<<"<font color=red>Savefile deleted.</font>"
								src.Choice()
							else
								src<<"Okay"
								src.Choice()
					else
						alert("No savefile found in this slot!")
						src.Choice()

				if("Slot 3") // slot 3
					if(fexists("players/[src.ckey]/[src.ckey](3).sav"))
						switch(alert(src, "Delete character from Slot-3? *YOUR CHARACTER WILL BE GONE!*", "Character Deletion", "Yes","No"))
							if("Yes")
								src<<"<font color=red>Accessing server database...</font>"
								var/savefile/F = new("players/[src.ckey]/[src.ckey](3).sav")
								src<<"<font color=red>Accessing save file...</font>"
								sleep(1)
								src.Read(F)
								sleep(1)
								fdel("players/[src.ckey]/[src.ckey](3).sav")
								sleep(1)
								src<<"<font color=red>Savefile deleted.</font>"
								src.Choice()
							else
								src<<"Okay"
								src.Choice()
					else
						alert("No savefile found in this slot!")
						src.Choice()
*/
mob/Logout() // logout proc
	//src.client.Save_Mob() // saves when you log out
	src.Save_Mob()
mob/verb/Save() // verb to save
	//src.client.Save_Mob() // calls save proc
	src.Save_Mob()
	winset(src,"1-main.labelCPU","text=[world.cpu]")


mob/proc/Auto_Save() // autosave
	//src.client.Save_Mob() //calls save proc
	src.Save_Mob()
	spawn(600) // waits 1 minute
	spawn() src.Auto_Save() // calls autosave proc again
/*mob
    Write(savefile/F) // Write proc
        ..()
        F["last_x"] << x // saves your x location on the map
        F["last_y"] << y // saves your y location on the map
        F["last_z"] << z // saves your z location on the map
    Read(savefile/F)
        ..()
        //var/last_x // var defined
        //var/last_y
        //var/last_z
        F["last_x"] >> coord_X// reads your x location on the map
        F["last_y"] >> coord_Y // reads your y location on the map
        F["last_z"] >> coord_Z // reads your z position on the map
        //src.loc = locate(last_x, last_y, last_z) // locates you to your last map location
*/