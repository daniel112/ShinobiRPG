/*client
	var
		// the client is what actually stores your bank since
		// its shared between all of your characters.
		mob/bank/bank

mob
	var
		// every mob has a reference to their bank
		tmp/mob/bank/bank

	// your bank is really just a mob, this lets us use the get_item()
	// and drop_item() procs to transfer items to and from it.
	bank
		inventory_size = Constants.BANK_SIZE*/


obj
	testItem
		icon ='inventory grid.dmi'
		icon_state = "test"
	testItem2
		icon ='inventory grid.dmi'
		icon_state = "test2"



mob/var/list/items = list()//store your items here

mob
	var
		OpenI = 0
	verb
		testItem()//adding test item 1
			var/obj/testItem/new_item = locate() in usr.items//checks list
			if(new_item)//if item is already in your list
				usr << "You have this item already"
				return
			new_item = new() // if not.. create it
			usr.items.Add(new_item) //then add it
			UpdateGrid()

		testItem2()//adding test item 1
			var/obj/testItem2/new_item = locate() in usr.items
			if(new_item)
				usr << "You have this item already"
				return
			new_item = new() // create a new fireball object
			usr.items.Add(new_item)
			UpdateGrid()

		UpdateGrid()
			usr << output(null,"window-Invent2.grid2") // clear the grid.
			src << output("<img src='inventoryBox32'>", "window-Invent2.grid2")
			src << output(src, "window-Invent2.grid2")
			//src << output(src,"grid2:1,2")displays you o.o
			for(var/obj/O in usr.items)
				usr << output(O,"window-Invent2.grid2:1,[usr.items.Find(O)]")

		showInvent()
			if(usr.loginscreen)
				return
			else
				if(OpenI==0)//if inventory is not open
					winset(src,null,{"
						window-Invent2.pos = "400,220";
						window-Invent2.is-visible = "true";
						window-invent2.grid2.show-names="false"
						window-invent2.grid2.image='inventoryBox32.png';
						"}) //.pos sets the position of the spawn area
					OpenI = 1
					UpdateGrid()

				else
					winset(src,null,{"
						window-Invent2.is-visible = "false";
						"})
					OpenI = 0