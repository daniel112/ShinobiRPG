
mob
	var
		tmp/OpenS
	verb
		openStat()
			if(src.loginscreen)
				return
			else
				if(OpenS==0)//if inventory is not open
					winset(src, "StatHUD", "is-visible=true; focus = false")
					winset(src, "StatHUD", "pos=700,200")
					OpenS = 1
					//winset(src,"1-main.main","focus=true")//keeps focus on map screen
				else
					winset(src, "StatHUD", "is-visible=false; focus = false")
					OpenS = 0

		CloseStat()
			winset(src, "StatHUD", "is-visible=false")
			OpenS = 0

		///point distribution
		addstr()
			if(src.statpoints != 0)
				src.strength += 1
				src.statpoints -= 1
				spawn(3)
					src.totalpoints()
					src.statUpdatemain()
			else
				src<<"<b>You do not have enough point(s)!</b>"
		adddex()
			if(src.statpoints != 0)
				src.dexterity += 1
				src.statpoints -= 1
				spawn(3)
					src.totalpoints()
					src.statUpdatemain()
			else
				src<<"<b>You do not have enough point(s)!</b>"
		addagi()
			if(src.statpoints != 0)
				src.agility += 1
				src.statpoints -= 1
				spawn(3)
					src.totalpoints()
					src.statUpdatemain()
			else
				src<<"<b>You do not have enough point(s)!</b>"
		addpow()
			if(src.statpoints != 0)
				src.power += 1
				src.statpoints -= 1
				spawn(3)
					src.totalpoints()
					src.statUpdatemain()
			else
				src<<"<b>You do not have enough point(s)!</b>"
		addresist()
			if(src.statpoints != 0)
				src.resistance += 1
				src.statpoints -= 1
				spawn(3)
					src.totalpoints()
					src.statUpdatemain()
			else
				src<<"<b>You do not have enough point(s)!</b>"

	proc
		totalpoints()
			winset(src, "StatHUD.labelAP", "text = \"[src.statpoints]")
		statUpdateHC()
			winset(src, "StatHUD.labelHP", "text = \"[src.health]/[src.max_health]")
			winset(src, "StatHUD.labelChakra", "text = \"[src.chakra]/[src.max_chakra]")

		statUpdatexp()//HP and exp are seperated because they are being called more often
			winset(src, "StatHUD.labelExp", "text = \"[src.exp]/[src.max_exp]")

		statUpdatemain()
			winset(src, "StatHUD.labelName", "text = \"[src.name]");winset(src, "StatHUD.labelClass", "text = \"[src.class]")
			winset(src, "StatHUD.labelRank", "text = \"[src.MainLevel]")
			winset(src, "StatHUD.labelStr", "text = \"[src.strength]");winset(src, "StatHUD.labelDex", "text = \"[src.dexterity]")
			winset(src, "StatHUD.labelRes", "text = \"[src.resistance]");winset(src, "StatHUD.labelAgi", "text = \"[src.agility]")
			winset(src, "StatHUD.labelPow", "text = \"[src.power]")