////-----Remember, there's always a better way of doing things-----//////////////////////////////
////-----IF Used It'd Be Nice Of You If You Can Mention Some Credit :P -----/////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
mob
	var
		targeting=0
		Target
mob//so that targets only mob(you can even make it turf or obj)
	DblClick()
		if(usr.targeting==0)//If you're not targetting anyone, then you can target anyone
			usr.targeting=1
			usr.Target= src
			if(src==usr)//if you try to target yourself
				usr<<"You cannot target yourself!"
				usr.Target = null
				usr.targeting=0//no longer targeting anyone

			else
				var/image/I = image('Target.dmi',src,layer = MOB_LAYER -1)//using image() makes the icon such that only you can see it
				usr.client.images += I
				usr<<"<font color=#550000>Target:[src]."
				usr<<"Health: [src.health]"
				/*spawn(600)//optional, that is if you want to untarget automatically after sometime.
				if(usr.targeting)
					usr<<"<font color=#000055>[src] was automatically untargetted."
					del(I)//Deleting the image from the target
					usr.Target= null
					usr.targeting=0
				*/
		else
			usr<<"<font color=#000055>Release target."
			for(var/image/I in usr.client.images)
				del(I)//Deleting the image from the target
			usr.Target= null
			usr.targeting=0

