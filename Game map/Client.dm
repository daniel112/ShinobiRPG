// client.dm   goes with interface - Copy.dmf
client
    New()
        . = ..()
        winset(src, null, {"
            1-main.child_main.left  = "login_splash";
            1-main.can-resize       = "false";
            1-main.statusbar        = "false";
            1-main.titlebar     = "true";
            1-main.macro        = null;
            1-main.menu         = null;
            1-main.output1.left. visible = "false";

        "})
		//winset(src,'1-main.output1',"visible=true")
        src.verbs += typesof(/player_entry/verb)

 // datum_entry.dm
player_entry
    verb
        NewCharacter()
            generic_interface_changing_code(usr.client)


        LoadCharacter()


        Options()


proc
    generic_interface_changing_code(client/C)
        winset(C, null, {"
            1-main.child_main.left  = "1-map";
            1-main.titlebar     = "true";
            1-main.macro        = "macro";
            1-main.menu         = "menu";
        "})

