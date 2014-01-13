//When show_popup_menus is set to 0 it causes the client to use a right click instead.
client/show_popup_menus = 0

///mouse icon
var/icon/I = new('mouse.dmi', "normal")

client
	New()
		mouse_pointer_icon = I
		return ..()

	Click()
		mouse_pointer_icon =  new /icon('mouse.dmi', "click")
		sleep(2)
		mouse_pointer_icon = I
		..()

///mouseclick icon



turf/Click() //click movement

	if(usr.loginscreen)
		return
	//else
	//	walk_to(usr,src)



/*This is the MouseDown proc. It will check the built in params to see what all you've done..
They are pretty self explanitory.
*/
////////////////////mousedrag movement//////////////////
mob/var/spot

mob/proc/Roam(var/n)
	if(src.spot != null)
		if(src.moves == 0)
			src.spot = null
		else
			var/l = src.loc
			step_towards(src,src.spot)
			src.movelis += src.dir
			var/tos = null
			if(istype(src.spot,/obj/))
				tos = src.spot:loc
			if(istype(src.spot,/turf/))
				tos = src.spot
			if(src.loc == tos)
				src.spot = null
			else
				if(src.loc == l)
					src.spot = null
	else
		if(length(src.movelis) > 0)
			if(src.moves == 1)
				if(n == null)
					n = 0
				if(n >= length(src.movelis))
					n = 0
				n += 1
				var/nn = 0
				for(var/v in src.movelis)
					nn+=1
					if(nn == n)
						step(src,v)
						break
			else
				src.movelis = new/list
		else
			n = null
	spawn(2)
		src.Roam(n)


mob/var
	movelis = new/list
	moves = 0
////////////////// End mousedrag movement/////////////////////

//////////////////right click/left click/middle click stuff////////////////
atom/MouseDown(anything,anything,var/c)
	c = params2list(c)
	if(usr.loginscreen)
		return

	else if(c["right"] == "1")
		if(usr.targeting == 1)
			usr<<"<font color=#000055>Release target."
			for(var/image/I in usr.client.images)
				del(I)//Deleting the image from the target
			usr.Target= null
			usr.targeting=0

	/*else if(c["middle"] == "1")
			stuff
	*/
	else if(c["left"] == "1")
		usr.moves = 1
		usr.movelis = new/list
		usr.spot = src
//////////////////////////End click stuff//////////////////////

//MouseUp stops the movement proc.
atom/MouseUp()
	usr.moves = 0

//Just updates your mouse's location
atom/MouseDrag(atom/o,anything,anything,anything,anything,var/a)
	o.MouseDown(anything,anything,a)