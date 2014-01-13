atom
	var
		speechBubbleOn = 0  // to help keep track of speech bubble existence, 0 by default until someone speaks i guess
var
	SpeechBubbleSettings/SpeechBubble = new()
mob/var/SpeechBubble/speech     // decided to just store the variable 's' from the demo here, also renamed as 'speech' to make it
							// distinguishable from the var/s used further down this code file. This does mean you'll need to
							// perform a check as to whether it already exists everytime a new bubble is about to be created,
							// in case several speech bubbles are being made in quick succession, so that you can delete the
							// last occurrence first: otherwise you'd get speeches being left behind on the turf, amongst other
							// things... Although, in a real situation a game should stop that from happening.

SpeechBubbleSettings
	parent_type = /mob
	var
		Font/font
		sicon

SpeechBubble
//	parent_type = /mob
	var
		slayer = MOB_LAYER + 0.5

		atom/owner
		atom/movable/bubble
		atom/movable/stext

		list/__text

		width = 3
		height = 3

	New(atom/a, txt, w = 0)

		owner = a
		owner.speechBubbleOn = 1 // setting the flag to 1 to mean a speech bubble is currently present
		//world << owner.speechBubbleOn //used for help when debugging e.t.c

		if(w) width = w

		var/atom/Sourceloc = owner
		while(!isturf(Sourceloc))
			Sourceloc = Sourceloc.loc

		bubble = new(Sourceloc)
		stext = new(Sourceloc)
		stext.pixel_x = 6

		__text(txt)

		stext.pixel_y = 32+32 * height + 8
		bubble.pixel_y = 64 + 8

		if(owner.dir & WEST)
			stext.pixel_x = -58
			bubble.pixel_x = -64

	Del()

		del stext
		del bubble
		owner.speechBubbleOn = 0    // resetting the flag to 0 for 'Speech Bubble no longer present'
	//	world << owner.speechBubbleOn //used for help when debugging e.t.c


	proc
		Follow(atom/a)
			bubble.loc = a.loc
			stext.loc = a.loc

			//^that is the original code, if you do wish to be able to just call the speech bubble's move proc here to make it
			// follow the user then you can simply switch it to be structured as such below: (unless you know how to get t at the user's location:/)
 			/*  proc
					Move(atom/Atom)
						bubble.loc = Atom.loc
						stext.loc = Atom.loc
			*/
			// you would then change the code at client/Move() or whatever to call speech.Move(usr) under it. However i'd suggest
			// just setting the variable locs directly as i did within the client/Move() in the demo, so as to avoid the
			// overhead from repeated calling of this move proc everytime the player moved while a speech bubble was up.

		__text(t)

			t = SpeechBubble.font.wrap_text(t, width * 32 - 12)

			// if the object already has stext attached to it,
			// we delete the old stext.
			if(__text)
				for(var/i in __text)
					stext.overlays -= i
					del i
				__text.Cut()

			// otherwise we initialize the __stext list
			else
				__text = list()

			// create objects to represent each letter in the string
			var/px = 0
			var/py = 64 - SpeechBubble.font.line_height - SpeechBubble.font.descent
			for(var/i = 1 to length(t))
				var/char = copytext(t, i, i + 1)

				// handle line breaks
				if(char == "\n")
					px = 0
					py -= SpeechBubble.font.line_height
					continue

				// we create an image object for every symbol in the string
				// of stext. the images are attached to the screen object so
				// that moving the screen object moves the stext.
				var/image/symbol = image(SpeechBubble.font.icon, icon_state = char, layer = slayer)
				// var/obj/symbol = new()
				// symbol.icon = SpeechBubble.font.icon
				// symbol.icon_state = char
				symbol.pixel_x = px
				symbol.pixel_y = py

				__text += symbol
				stext.overlays += symbol

				px += SpeechBubble.font.char_width(char) + SpeechBubble.font.spacing

			// we create the bubble second because we have to position all
			// of the letters so we know how many lines of stext there are,
			// this affects how tall the speech bubble is.
			__bubble(py)

		__bubble(py)

			height = round(1 + abs(64 - py) / 32)

			for(var/x = 1 to width)
				for(var/y = 1 to height)

					// figure out the icon_state based on what edge
					// each icon needs to show
					var/n = 0
					if(y > 1) n += 1
					if(x < width) n += 2
					if(y < height) n += 4
					if(x > 1) n += 8

					var/image/t = image(SpeechBubble.sicon, icon_state = "[n]", layer = slayer)
					t.pixel_x = (x - 1) * 32
					t.pixel_y = (height - y) * 32+32
					bubble.overlays += t

			var/image/t = image(SpeechBubble.sicon, icon_state = "point", layer = slayer, dir = owner.dir)
			t.pixel_x = 32
			t.pixel_y = 1 //original -31
			bubble.overlays += t

atom
	proc
		speech_bubble(txt, width = 0, duration = 0)
			var/SpeechBubble/s = new(src, txt, width)

			if(duration)
				spawn(duration)
					del s

			return s