#define DEBUG

Font
	Trebuchet8pt
		icon = 'trebuchet-8pt.dmi'

		// see fonts.dm for descriptions of these vars
		char_width = list(" " = 4, "a" = 5, "b" = 5, "c" = 5, "d" = 5, "e" = 5, "f" = 4, "g" = 6, "h" = 5, "i" = 2, "j" = 3, "k" = 5, "l" = 1, "m" = 7, "n" = 5, "o" = 5, "p" = 5, "q" = 5, "r" = 3, "s" = 4, "t" = 4, "u" = 5, "v" = 5, "w" = 7, "x" = 5, "y" = 5, "z" = 5, "A" = 5, "B" = 5, "C" = 6, "D" = 6, "E" = 5, "F" = 5, "G" = 6, "H" = 6, "I" = 1, "J" = 4, "K" = 5, "L" = 4, "M" = 7, "N" = 6, "O" = 7, "P" = 5, "Q" = 8, "R" = 6, "S" = 4, "T" = 5, "U" = 6, "V" = 7, "W" = 9, "X" = 6, "Y" = 7, "Z" = 5, "0" = 5, "1" = 3, "2" = 5, "3" = 5, "4" = 5, "5" = 4, "6" = 5, "7" = 5, "8" = 5, "9" = 5, "," = 2, "." = 1, "'" = 1, "\"" = 3, "?" = 4, "(" = 2, ")" = 2, "<" = 4, ">" = 4, "/" = 4, ";" = 2, ":" = 1, "-" = 3, "+" = 5, "=" = 4, "_" = 6, "!" = 1, "@" = 8, "#" = 6, "$" = 4, "%" = 7, "^" = 5, "&" = 7, "*" = 5)
		descent = 2
		spacing = 1
		line_height = 13

	Georgia
		icon = 'Georgia8pt.dmi'

		// see fonts.dm for descriptions of these vars
		char_width = list(" " = 4, "a" = 5, "b" = 5, "c" = 5, "d" = 5, "e" = 5, "f" = 4, "g" = 6, "h" = 5, "i" = 2, "j" = 3, "k" = 5, "l" = 1, "m" = 7, "n" = 5, "o" = 5, "p" = 5, "q" = 5, "r" = 3, "s" = 4, "t" = 4, "u" = 5, "v" = 5, "w" = 7, "x" = 5, "y" = 5, "z" = 5, "A" = 5, "B" = 5, "C" = 6, "D" = 6, "E" = 5, "F" = 5, "G" = 6, "H" = 6, "I" = 1, "J" = 4, "K" = 5, "L" = 4, "M" = 7, "N" = 6, "O" = 7, "P" = 5, "Q" = 8, "R" = 6, "S" = 4, "T" = 5, "U" = 6, "V" = 7, "W" = 9, "X" = 6, "Y" = 7, "Z" = 5, "0" = 5, "1" = 3, "2" = 5, "3" = 5, "4" = 5, "5" = 4, "6" = 5, "7" = 5, "8" = 5, "9" = 5, "," = 2, "." = 1, "'" = 1, "\"" = 3, "?" = 4, "(" = 2, ")" = 2, "<" = 4, ">" = 4, "/" = 4, ";" = 2, ":" = 1, "-" = 3, "+" = 5, "=" = 4, "_" = 6, "!" = 1, "@" = 8, "#" = 6, "$" = 4, "%" = 7, "^" = 5, "&" = 7, "*" = 5)
		descent = 21
		spacing = 2
		line_height = 13

world
	New()
		..()

		// The library doesn't define any fonts (though you're more
		// than welcome to use the one defined here in your project
		// too), so we have to tell the speech bubbles what font to
		// use.
		SpeechBubble.font = new /Font/Trebuchet8pt()

		// The library also doesn't define what icon to use, that's
		// left up to the program using the library. You're welcome
		// to use speech-bubble.dmi in your own project.
		SpeechBubble.sicon = 'speech-bubble.dmi'

/*
client
	Move()
		..()
		*/


