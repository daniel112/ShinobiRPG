mob
	Write(var/savefile/F) // Write proc

	//	for(var/n in src.vars)
	//		if(n == src.vars["full"])

		..()
		F << x
		F << y
		F << z

		//F["key"] << "[src.key]"
		////PLAYER VARS/////
		F["name"] << name
		F["base"] << icon
		F["baseState"] << icon_state
		//F["hairStyle"] <<overlays
		F["Village"] <<Village
		F["Villagehud"]<<VillageHUD
		F["health"]<<health
		F["chakra"]<<chakra




