mob
	Read(var/savefile/F)

		..()


		var/last_x // var defined
		var/last_y
		var/last_z
		F >> last_x
		F >> last_y
		F >> last_z
		Move(locate(last_x, last_y, last_z)) // locates you to your last map location
		//F["key"] >> src.key
		////PLAYER VARS/////
		F["name"] >> name
		F["base"] >> icon
		F["baseState"] >> icon_state
		//F["hairStyle"] << overlays
		F["Village"] >>Village
		F["Villagehud"]>>VillageHUD
		F["health"]>>health
		F["chakra"]>>chakra
		//var/obj/fortesting = overlays[overlays.len]
		//world << "test: [OverlayShirt], layer: [OverlayShirt.layer], icon: [OverlayShirt.icon]"
		//world << "Loaded OL: [fortesting], layer: [fortesting.layer], icon: [fortesting.icon]"
	//	usr.overlays = OverlayShir


