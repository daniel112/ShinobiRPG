Constants
	var
		const
			// the icon used for graphical effects


			// used to make selections and close menus
			KEY_SELECT = "space"
			KEY_CANCEL = "escape"

			// used to move the cursor in menus
			KEY_UP = "w"
			KEY_DOWN = "s"
			KEY_RIGHT = "d"
			KEY_LEFT = "a"

			// used to open/close the loot and inventory panels
			KEY_INVENTORY = "i"
			KEY_ABILITIES = "k"
			KEY_QUESTS = "q"
			KEY_PARTY = "p"
			KEY_INFO_BAR = "h"

			// other controls
			KEY_CHAT = "return"

	// the size of the on-screen inventory
			INVENTORY_DISPLAY_SIZE = "5x3"
			BANK_DISPLAY_SIZE = "6x4"

			// the number of items a player can hold
			INVENTORY_SIZE = 15
			BANK_SIZE = 32

			// the size of an icon in pixels
			ICON_WIDTH = 64
			ICON_HEIGHT = 64

			VIEW_WIDTH = 16
			VIEW_HEIGHT = 12

			// Bit flags that correspond to the different teams a mob
			// can belong to. The library only defines two teams, players
			// and enemies.
			TEAM_PLAYERS = 1
			TEAM_ENEMIES = 2

			// this is the number of frames between health/mana regen events
			REGEN_TICK_LENGTH = 40

			// The number of characters a player can have
			SAVE_SLOTS = 4

			// 1 for client-side savefiles, 0 for server-side
			CLIENT_SIDE_SAVING = 0

			///clothing stuff
			ARMOR_LAYER = FLOAT_LAYER -1
			CLOTHES_LAYER= FLOAT_LAYER-2
