/*
CleanSave written by Ter13 (Terrey West) Mar 5, 2013

version 1.0a

CleanSave is a simple solution to saving data for BYOND games.

Simply include this file in your source code, and specify what variables should never be saved within
the supplied NeverSave function.

For further details, check out the hub for this project, which includes a link to a tutorial on
how to use this system, as well as a primer on how to use savefiles in general.

This work is distributed under the creative commons attribution 3.0 license.

TERMS OF USE:

The author in no way takes responsibility for loss or damage of data or computer systems
during the use of this product. In addition, you agree to comply with the terms and conditions
of a CC BY 3.0 license by using this product.

Works derived from this library must include a link to the original library, and all distribution
in code form, modified or not, must also include attribution to the author as well as a link
to the original download.

Compiled products using this library in whole or in part do not need to offer attribution to the
author, but are barred from distributing this library in source code form without proper attribution.

Removal of this comments section violates the terms of use of this product.

Please check out my hub: http://www.byond.com/members/Ter13
*/
#ifndef TER13_CLEANSAVE
#define TER13_CLEANSAVE 1


datum
	proc
		NeverSave(var/list/L)
			return L
	//set up the new save behavior.
	Write(var/savefile/F,var/list/neversave=null)
		//make sure neversave has been initialized as a list with contents
		if(neversave!=null&&istype(neversave,/list)&&neversave.len>=1)
			//define i for storing initial variables
			var/i
			//var/count = 1
			//run through neversave one time
			for(var/v in neversave)
				//DEBUG TIME

				//world << text("Neversave Item []: [neversave[v]]/[]",count++, neversave[i]);
				//if the variable is not savable (tmp/const/global/static) just remove it,
				//as it will never save anyway.
				if(!issaved(src.vars[v]))
					neversave.Remove(v)
				else
					//get the initial value of the variable.
					i = initial(src.vars[v])
					//now, check if the variable would normally save.
					if(i!=src.vars[v])
						//if it has been changed since runtime, store the current value in neversave.
						neversave[v] = src.vars[v]
						//and set the variable to default so it won't save.
						src.vars[v] = i
					else
						//remove the variable as it won't save because it's the default value.
						neversave.Remove(v)
			//call the default behavior.
			. = ..(F)
			//go back through everything and set it to whatever it should be.
			for(var/v in neversave)
				src.vars[v] = neversave[v]
			//return whatever default would have returned.
			return.
		else
			//fall back to normal behavior if neversave is not set up.
			return ..(F)

	//set up the new load behavior.
	Read(var/savefile/F,var/list/neversave=null)
		//check if neversave has been initialized as a list with contents
		if(neversave!=null&&istype(neversave,/list)&&neversave.len>=1)
			//run through neversave once
			for(var/v in neversave)
				//if the variable shouldn't be saved (tmp/const/global/static)
				if(!issaved(src.vars[v]))
					//remove the variable
					neversave.Remove(v)
				else
					//store the current value.
					neversave[v] = src.vars[v]
			//call the default behavior.
			. = ..(F)
			//run back through the list
			for(var/v in neversave)
				//reset the values that may have been overwritten
				src.vars[v] = neversave[v]
			//return the default return.
			return .
		else
			//fall back to normal behavior if neversave is not set up.
			return ..(F)

atom
	NeverSave(var/list/L)
		//add what we don't want to save
		L.Add("speech","owner","underlays")
		if(!istype(src, /obj/Keys))
			L.Add("overlays")
		return ..(L) //return whatever the parent type does.
	Write(var/savefile/F,var/list/neversave=null)
		//if we don't have any defined nonsavables yet.
		if(neversave==null)
			neversave = src.NeverSave(list())

		//we want to get a local copy of the overlays and underlays
		//because you can't just assign a list to overlays or underlays
		//at runtime. Things get messy.
		var/list/ol
		var/list/ul

		if(src.overlays!=initial(src.overlays)&&neversave.Find("overlays"))
			ol = src.overlays.Copy(1,0)
			src.overlays = initial(src.overlays)
			neversave.Remove("overlays")
		if(src.underlays!=initial(src.underlays)&&neversave.Find("underlays"))
			ul = src.underlays.Copy(1,0)
			src.underlays = initial(src.underlays)
			neversave.Remove("underlays")

		. = ..(F,neversave)

		if(ol!=null&&ol.len)
			src.overlays.Add(ol)
		if(ul!=null&&ul.len)
			src.underlays.Add(ul)
	Read(var/savefile/F,var/list/neversave=null)
		if(neversave==null)
			neversave = src.NeverSave(list())
		return ..(F,neversave)
/*	movable
		NeverSave(var/list/L)
			L.Add("screen_loc")
			return ..(L) */
mob

	Write(var/savefile/F,var/list/neversave=null)
		. = ..(F,neversave)
		F.dir.Remove("key")
		var/ocd = F.cd
		F.cd = "location"
		F << src.x
		F << src.y
		F << src.z
		//F<<	src.owner
		F.cd = ocd

		return .

	Read(var/savefile/F,var/list/neversave=null)
		. = ..(F,neversave)
		var/ocd = F.cd
		F.cd = "location"
		F >> src.x
		F >> src.y
		F >> src.z
		//F>>	src.owner
		F.cd = ocd
		return .


#endif