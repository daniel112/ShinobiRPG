//client/proc/StartInventory()
//	new/obj/InventGrid(src)
//	new/obj/InventBox/box1(src)
obj

	InventGrid
		icon ='inventoryBox32.png'
		layer = 1
		screen_loc = "Imap:1:13,1:11"

	InventBox
		var
			free
		icon = 'inventBox.dmi'
		layer = 2
		/*box1
			icon_state = "r1c1"
			screen_loc ="Imap:1:13,6:21"
			free = "TRUE"

		box2
			icon_state = "r1c2"
			screen_loc = "Imap:2:15,6:21"
			free = "TRUE"
		*/



mob
	var
		tmp/OpenI = 0
		size = 24
		obj/InventBox/boxes[24]

	//var/list/boxes
	//boxes=new/list(24)//create a list of max 24 to store Inventboxes
	verb
		showInvent()
			if(src.loginscreen)
				return
			else
				if(OpenI==0)//if inventory is not open
					/*winset(src,"windowTest",{"
						windowTest.pos = "400,220";
						windowTest.is-visible = "true";
						"}) //.pos sets the position of the spawn area
					*/
					winset(src, "InventoryHUD", "is-visible=true; focus = false")
					winset(src, "InventoryHUD", "pos=700,220")
					OpenI = 1
					//winset(src,"1-main.main","focus=true")//keeps focus on map screen
				else
					winset(src, "InventoryHUD", "is-visible=false; focus = false")
					OpenI = 0

		CloseInvent()
			winset(src, "InventoryHUD", "is-visible=false")
			OpenI = 0

	proc
		ShowInvGrid()//displays the inventory boxes on Imap
			client.screen += new/obj/InventGrid
			var/obj/InventBox/box
			var/r = 1, c = 1, xTile = 1, xPixel = 13, yTile = 6, yPixel = 21
			var/widthLimit = 4

			for(var/i = 1, i <= size, i++)
				box = new()
				box.icon_state = "r[r]c[c]"
				box.screen_loc = "Imap:[xTile]:[xPixel],[yTile]:[yPixel]"
				box.free = "TRUE"
				boxes[i] = box
				src.client.screen += box
			//	if(i == size) //it's not like this part is really needed, since the for
				if(i%widthLimit == 0)   //loop ends right after these values get assigned, but anyway.
					r++ //+= 1 ..as you know, keep whichever format you wish i guess
					c = 1
					yTile -= 1
					yPixel -= 2
					xTile = 1
					xPixel = 13
				else
					c++
					xTile += 1
					xPixel += 2

//mob/var/list/EquipType = list()//used to store equipped item type
obj
	var
		equip//Track whether it's being worn or not. 1 for equipped, null for not
		overlay_clothes//The object that is added and removed to overlays
		ItemType //used to identify item piece
		storeType

	//Items
	//	layer = 3

	ItemObj
	//////////////////ItemObj//////////
		icon = 'ItemGUI.dmi'
		layer = 3

		//Equip
			//icon_state = "equipped"
		Top
			//hasTooltip=1
			B_Shirt
				ItemType = "Shirt"
				desc= "A Black Shirt."
				icon_state = "blackShirt"
				name = "Black Shirt"
				overlay_clothes = /obj/overlay/blackShirt

			R_Shirt
				ItemType = "Shirt"
				desc = "A Red Shirt."
				icon_state = "redShirt"
				name = "Red Shirt"
				overlay_clothes = /obj/overlay/redShirt

			L_Vest
				ItemType = "Armor"
				desc = "Shinobi Vest"
				icon_state = "Lvest"
				name = "Shinobi Vest"
				overlay_clothes = /obj/overlay/leafVest

///drag swapping
		proc
			swap(obj/ItemObj/a, obj/ItemObj/b)
				var/placeHolder
				var
					aIndex = usr.Items.Find(a)
					bIndex = usr.Items.Find(b)
				// you can't swap two equipped items
				if(a.equip != null || b.equip != null)
					usr<<"Unequip your Item(s) first!"
					return
				else
					if(aIndex && bIndex) // if it's an obj in your Item list
						usr.Items.Swap(aIndex, bIndex)
						//do the swap
						placeHolder = a.screen_loc//store a's location in a variable
						a.screen_loc = b.screen_loc //move obj a to obj b's location
						b.screen_loc = placeHolder // move obj b to obj a's location

					else
						usr<<"Cannot swap there!"
						return


		MouseDrop(obj/ItemObj/a)
			src.mouse_drag_pointer = icon(src.icon,src.icon_state)//changes mouse icon
			swap(src,a) //calls swap proc

////drag swapping


		//MouseEntered(obj/O)//show tooltip here

		Click(obj,InventoryHUD,params)
			params = params2list(params)
			var/mob/player/M=usr
			var/equip_overlay = /obj/overlay/Equip

			if("left" in params)//left click
				if(src in usr.Items)
					if(equip==null)
						equip = 1 //is equipped
							////Auto switch equip
						storeType = ItemType
						for(var/obj/ItemObj/Equipment in usr.Items)//for every item that exist
							if(Equipment.ItemType == storeType)//if it has the same ItemType
								if(Equipment.equip == 1 && Equipment!= src)//and if usr is wearing it
									Equipment.equip = null
									Equipment.overlays -- //equip icon (remove all overlay)
									M.overlays -= Equipment.overlay_clothes//take it off
							///END Auto switch equip
						M.overlays += overlay_clothes
						overlays += equip_overlay//equip icon
						usr<<"you put on [desc]"
					else
						M.overlays -= overlay_clothes
						overlays -- //equip icon (remove all overlay)
						usr<<"You take off [desc]"
						equip = null

			else if("right" in params)//right click
				if(equip != null)//if item is currently equipped
					Apopup(M,"Unequip the item first!")
				else
					Apopup(M,"Drop this item?",1)
					if(M.popupvalue ==1)
						//alert("put drop code here.. ff")
						src.Move(usr.loc) //puttin it down!
						usr << "You've dropped [src]"
						usr.Items.Remove(src)


////////////End ItemObj///////////////////////

///////////////////obj ends///////////////////

mob/var/list/Items = list()//store your items here

mob

	verb
		testEquip()//adding test item 1
			var/obj/ItemObj/Top/B_Shirt/new_item = locate() in usr.Items

			if(new_item)//if you already have B_Shirt
				var/obj/ItemObj/Top/R_Shirt/new_item2 = locate() in usr.Items//then add R_Shirt instead
				if(new_item2)//if you already have R_Shirt
					usr<<"You have both shirts already."
					//UpdateInv()
					return
				else
					new_item2 = new()
					usr.Items.Add(new_item2)
					usr << "You received redShirt because you have blackShirt already"
					UpdateInv(Items[Items.len]) //
					//return

			else
				new_item = new()
				usr.Items.Add(new_item)
				usr<<"You received a black shirt."
				UpdateInv(Items[Items.len])

		testEquipVest()//adding Vest
			var/obj/ItemObj/Top/L_Vest/new_item = locate() in usr.Items

			if(new_item)//if you already have B_Shirt
				usr<<"You have this vest already."

			else
				new_item = new()
				usr.Items.Add(new_item)
				usr<<"You received a vest."
				UpdateInv(Items[Items.len])

///for debugging
		showList()
			usr<<"Items List:"
			usr<<list2params(Items)//list the items in Items list
		clearList()
			usr.Items.Remove(Items)//i want to clear everything inside Items list..
			usr<<"Item list Cleared."
///^^debugging^^
	proc
		UpdateOverlay()//equip gear on load
			for(var/obj/O in usr.Items)//looks through item list
				if(O.equip ==1)
					usr.overlays += O.overlay_clothes
			usr<<"Equipping previous gear.."


		UpdateInv(obj/Item)
			for(var/obj/InventBox/slot in boxes)
				if(slot.free=="TRUE")
					Item.screen_loc  = slot.screen_loc//stores the current box location/transfer the box location to the shirt location
					usr.client.screen += Item //place the shirt Object on screen
				//	slot.screen_loc = null//remove the box obj
				//	Item.screen_loc = boxLoc//transfer the box location to the shirt location

					slot.free = "FALSE" //so it cannot be used while there is an item in
					break//if an item is placed, break out of loop

				else if(slot == boxes[size])
					usr<<"You do not have enough space."

		UpdateInvAll()
			var
				num=1
				equip_overlay = /obj/overlay/Equip
			for(var/obj/InventBox/slot in boxes)
				slot.free="TRUE"

			for(var/obj/O in usr.Items)//for objects in Items list.

				for(var/obj/InventBox/slot in boxes)//try to put in an open slot box
					if(slot.free=="TRUE")
						O.screen_loc = slot.screen_loc//transfer the box location to the shirt location
						usr.client.screen += O //place the shirt Object on screen
						if(O.equip ==1)
							O.overlays += equip_overlay
						slot.free = "FALSE" //so it cannot be used while there is an item in
						break//if an item is placed, break out of loop
					else
						usr<<"Inventory slot[num] is full."
						num++













