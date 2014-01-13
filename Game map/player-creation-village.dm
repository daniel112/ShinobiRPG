/////////////////Village////////////////
mob
	var
		Village
		VillageHUD
		hudOverlay

	verb
		ChooseKonoha()
			set hidden = 1
			src.Village = null//resets everything first
			src.VillageHUD = null
			src.hudOverlay = null
			src.Village = "<b><font color =\"#005500\">{Konoha}</font></b>"
			src.VillageHUD = 'png/menu/villageLoad/Village-leaf.png'
			src.hudOverlay = "leaf"
			src.class = "Genin"
			UpdateVillage()
			if(loginscreen)//if village change is in main menu
				Apopup(src,"Konoha Selected.")

		ChooseSuna()
			set hidden = 1
			src.Village = null//resets everything first
			src.VillageHUD = null
			src.hudOverlay = null
			src.Village = "<b><font color =\"#CC9933\">{Suna}</font></b>"
			src.VillageHUD = 'png/menu/villageLoad/suna.png'
			src.hudOverlay = "sand"
			src.class = "Genin"
			UpdateVillage()
			if(loginscreen)//if village change is in main menu
				Apopup(src,"Suna Selected.")

		ChooseKiri()
			set hidden = 1
			src.Village = null//resets everything first
			src.VillageHUD = null
			src.hudOverlay = null
			src.Village = "<b><font color =\"#003366\">{Kiri}</font></b>"
			src.VillageHUD = 'png/menu/villageLoad/kiri.png'
			src.hudOverlay = "mist"
			src.class = "Genin"
			UpdateVillage()
			if(loginscreen)//if village change is in main menu
				Apopup(src,"Kiri Selected.")

	proc
		UpdateVillage()//image hud. VillageIcon.dmi
			for(var/obj/HUD/V_HUD/v in src.client.screen)
				v.overlays += src.hudOverlay








