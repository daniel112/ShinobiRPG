// the delay between mousing in, and when the tooltip is shown
#define TOOLTIP_DELAY 4

// the box around where the mouse enters the atom, which will still let the tooltip show
// this is a 5x5 box, centered around the point where HasMouseEntered() is called
#define TOOLTIP_BOX_SIZE 5

// check whether or not the mouse is in it's grace-range for the tooltip to appear
#define in_range(x, y) (x > y-TOOLTIP_BOX_SIZE && x < y+TOOLTIP_BOX_SIZE)

client
	var
		// the x position (from the top left) of the mouse
		mouse_x

		// the y position (from the top left) of the mouse
		mouse_y

		// a unique number for this client
		uid = 0

	proc

		// get the new mouse coordinates, and send them to Topic()
		update_mouse()
			src << output({"
				<html>
					<head>
						<script type="text/javascript">
							function coordinate(event) {
								window.location="?action=mousecoord&x="+event.screenX+"&y="+event.screenY
							}
						</script>
					</head>

					<body onload="coordinate(event)"></body>
				</html>
			"},"hidden.browser")
			// #modification_interface

	// just for intercepting the above javascript
	Topic(href, hlist[], hsrc)

		..(href, hlist, hsrc)

		switch(hlist["action"])

			if("mousecoord")
				mouse_x = text2num(hlist["x"])
				mouse_y = text2num(hlist["y"])

	// this is probably a very inefficient way to do it, but it is just a demonstration
	MouseEntered(atom/object, location, control, params)

		if(object.hasTooltip)

			// we have to update the mouse coordinates before we spawn a tooltip
			update_mouse()

			//give the user some time to get his/her mouse inside the item and pause it
			sleep(TOOLTIP_DELAY/2)

			object.HasMouseEntered(src, location, control, params)

	//MouseExited()

/**#atom
 *  atom.hasTooltip
 *  atom.tooltipRows
 *  atom.HasMouseEntered()
 */
atom

	icon = 'ItemGUI.dmi'

	var
		// this is just one way it can be done
		hasTooltip	= 0

		// since the tooltip supports CSS, it's a bit harder to *always* know how big it should be
		// this is the way I got around that, even though it's more lazy than it should be
		tooltipH = 2//height of box
		tooltipW = 1/2

	proc
		// this is basically MouseEntered, except it isn't always called,
		// and it has an explicit reference to the client that mouses over it
		// basically, I </3 usr, and this is my way around it.
		HasMouseEntered(client/c, location, control, params)
			var
				_oldx = c.mouse_x
				_oldy = c.mouse_y

			//wait a bit before comparing it again
			sleep(TOOLTIP_DELAY)

			c.update_mouse()
			if(in_range(c.mouse_x, _oldx) && in_range(c.mouse_y, _oldy))
				tooltip(c, "[c.uid++]", "<br />[desc]", 256*tooltipW, 24*tooltipH, c.mouse_x, c.mouse_y, 30, TRUE)
/**#obj
 *  --- these objects override the (now) default atom properties
 *  --- and not a whole lot more
 */
//obj
//	_hastooltip
		//hasTooltip=1

/*		rainbow_box
			desc 		= "A Red Shirt used to fight things."
			tooltipRows = 2
			name 		= "Red Shirt"
			icon_state	= "RedShirt"

		purple_orb
			desc		= "A Blue Shirt.. what else?"
			tooltipRows	= 3
			name		= "Blue Shirt"
			icon_state	= "BlueShirt"

*/
//////////////////////////////////////ToolTip//////////////////////////
proc/tooltip(
			c = null,
			id = "",
			content = "",
			size_x = 256,
			size_y = 24,
			pos_x = 0,
			pos_y = 0,
			timeout = -1,
			fadeout = FALSE,
			focus_window = "1-main.main",
			css = {"
				font-family: "Georgia";
				background-color: #EEEEEE;
				border: 1px solid #000000;
				margin: 0px;
				padding: 0px;
				padding-left: 3px;
				width: [size_x]px;
				height: [size_y]px;
			"}
			)
	/*
	c = who to display the tooltip to (needs to be a client or a mob)
	id = an id to give the tooltip. reusing an id will reuse an existing tooltip,

	size_x, size_y = the size of the tooltip (in pixels)
	pos_x, pos_y = the position of the tooltip (pixels, screen coordinates)

	timeout = the amount of time (in ticks) to wait before the tooltip is to disappear (-1 for no timeout, default = -1)
	fadeout = whether or not to fade the window out, or make it disappear instantly after timeout (default setting = FALSE)

	focus_window = the main window control to give focus back to after displaying tooltips (default setting = default)
	*/

	spawn()
		ASSERT(c && id && content && pos_x && pos_y)
		id = "_[id]_tooltip"

		if(size_y < 24) size_y = 24

		if(pos_x < 0) pos_x = 0
		if(pos_y < 0) pos_y = 0

		var/browser_id = "[id]_browser"

		if(!winexists(c, id))
			winclone(c, "window", id)

		winset(c, id, "statusbar=false;\
						can-close=false;\
						can-resize=false;\
						can-minimize=false;\
						can-scroll=false;\
						titlebar=false;\
						size=[size_x],[size_y];\
						pos=[pos_x],[pos_y];\
						focus=false;\
						alpha=255")

		if(!winexists(c, browser_id))
			winset(c, browser_id, "parent=[id];\
				type=browser;\
				pos=0,0;\
				size=[size_x + 17],[size_y + 17];\
				anchor1=0,100;\
				anchor2=100,0;\
				focus=false;")

		var/tooltip_page =\
		{"
<html>
	<head>
		<style type="text/css">
			BODY {
				margin: 0px;
				padding: 0px;
				overflow: none;
			}

			div#content {
				[css]
			}
		</style>
	</head>
	<body>
		<div id="content">
			[content]
		</div>
	</body>
</html>
	"}

		c << output(tooltip_page, "[id].[browser_id]")
		winshow(c, id, 1)

		if(winexists(c, focus_window)) winset(c, focus_window, "focus=true")

		if(timeout != -1)
			sleep(timeout)

			if(fadeout)
				var/alpha = 255
				while(alpha > 0)
					winset(c, id, "alpha=[alpha]")
					alpha -= 20

					sleep(1)

			winshow(c, id, FALSE)