mob
	verb
		macchat()//macro
			set name="macchat"
			set hidden = 1
			if(istype(usr,/mob/player))
				if(openChat != 1)//if chatbox isnt open
					return
				else
					winset(usr, "chatBox.input1", "focus=true")

		say(msg as text)
		/////////////////////////////////////// outputs in chatbox
			var/global
				firstInChain
				current = 0
				total = 0
			if(msg == "")
				return
			if(length(msg) >= 100)//char limit
				usr<<"<i>Message exceeded character limit</i>"
				return
			usr << output("[Village] [usr]: [msg]","chatBox.output")  //  ex: Danny: text
			oview(src) << "[Village] [usr]:, [msg]"

		/////////////////////////////////////////end outputs in chatbox

			///////////////////////Chat Bubble start

			if(speech)
				current++
				del speech

			// Call the mob's speech_bubble proc to create a speech bubble.
			// The proc returns a reference to the object that we store in
			// a local variable so we can delete the speech bubble later.
				speech = speech_bubble("[msg]")

				// Three seconds later, delete the speech bubble.
				// world << "current (before if sleep): [current], and total: [total]"
				sleep(50)
				total++
			else
			//	firstInChain = 1
				current++
				total++
				speech = speech_bubble("[msg]")


			// Three seconds later, delete the speech bubble.
				sleep(50)
			//	del speech
			if(current == total) del speech

			////////////////////Chat Bubble end


