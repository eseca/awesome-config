-- default rc.lua for shifty
--
-- Standard awesome library
require("awful")
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Shifty - dynamic tagging library
require("shifty")
-- Vicious - widget framework
vicious = require("vicious")

-- useful for debugging, marks the beginning of rc.lua exec
print("Entered rc.lua: " .. os.time())

-- Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
-- theme_path = "/usr/share/awesome/themes/default/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme"

theme_path = awful.util.getdir("config") .. "/themes/darkblue/theme.lua"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
browser = "chromium-browser"
mail = "thunderbird"
terminal = "gnome-terminal"
file_manager = "pcmanfm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key, I suggest you to remap
-- Mod4 to another key using xmodmap or other tools.  However, you can use
-- another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false

-- Shifty configured tags.
shifty.config.tags = {
    ["1:web"] = {
        layout      = awful.layout.suit.floating,
        mwfact      = 0.50,
        position    = 1,
        spawn       = browser,
        exclusive   = true,
    },
    ["2:code"] = {
        layout      = awful.layout.suit.tile.left,
        mwfact      = 0.65,
        position    = 2,
    },
    foo = {
        layout    = awful.layout.suit.floating,
        mwfact    = 0.60,
        exclusive = false,
        init      = true,
        screen    = 1,
        slave     = true,
    },
    draw = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.65,
        exclusive = true,
    },
    vm = {
        layout    = awful.layout.suit.magnifier,
        mwfact    = 0.70,
        exclusive = true,
    },
    game = {
        layout    = awful.layout.suit.floating,
        exclusive = true,
    },
    steam = {
        layout    = awful.layout.suit.tile,
        mwfact      = 0.70,
    },
    media = {
        layout    = awful.layout.suit.fair.horizontal,
        exclusive = false,
    },
    im = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.30,
        exclusive = true,
    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "Chromium",
            "Navigator",
            "Vimperator",
            "Gran Paradiso",
        },
        tag         = "1:web",
        geometry    = {nil, 18, nil, nil},
        float       = false,
    },
    -- YouTube full-screen video mode.
    {
        match = {
            "exe",          
        },
        tag         = "1:web",
        fullscreen  = true,
        float       = true,
        slave       = true,
    },
    {
        match = {
            "vim",          
        },
        tag         = "2:code",
    },
    {
        match = {
            "Inkscape",
            "gimp",
            "FreeCAD",
        },
        tag = "draw",
    },
    {
        match = {
            "VirtualBox",
        },
        tag = "vm",
    },
    {
        match = {
            "steam",
            "Steam",
            "killingfloor-bin",
            "KillingFloor",
            "Killing Floor",
        },
        tag = "steam",
    },
    --[[{
        match = {
            name="Steam - Update News. ",
        },
        float = true,
    },]]
    {
        match = {
            "mednafen",
            "zsnes",
            "stepmania",
            "armagetronad",
        },
        tag = "game",
    },
    {
        match = {
            "pcmanfm",
        },
        slave = true
    },
    {
        match = {
            "Mplayer.*",
            "mplayer",
            "Mirage",
            "gtkpod",
            "Ufraw",
            "easytag",
            "Reproductor",
            "Totem",
            "pitivi",
            "lingot",
            "Gnome Subtitles",
            "ncmpc",
            "spotify",
            "ncmpcpp",
        },
        tag = "media",
        nopopup = true,
    },
    {
        match = {
            "emesene",
            "Pidgin",
            "skype",
            "Viber",
        },
        tag = "im",
        slave = true,
        float = false,
    },
    {
        match = {
            "MPlayer",
            "Gnuplot",
            "galculator",
            "Banshee",
        },
        float = true,
    },
    {
        match = {
            terminal,
        },
        honorsizehints = false,
        slave = true,
    },
    {
        match = {""},
        geometry = {nil, 18, nil, nil},
        honorsizehints = false,
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
                end),
            awful.button({modkey}, 3, awful.mouse.client.resize)
        )
    },
}

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.tile,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}

--
-- Wibox
--
-- {{{ Vicious widgets definitions:
--
-- Separator/Spacer icons
separator = widget({ type = "textbox", align = "left"})
separator.text = '<span color="#000000"> ▪ </span>'
space = widget({ type = "textbox" })
space.text = "  "
--
-- Date widget
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%d %b, %I:%M%P")
--
-- CPU widget
cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, 
function (widget, args)
    r = "<span color=\"#909090\">CPU:</span>"..
    "<span color=\"white\">".. args[1] .."%</span>"

    if #args > 2 then
        r = r .. " <span color=\"#909090\">[</span>"
        for i=2, #args, 1 do
            r = r
            .."<span color=\"white\">"..args[i].."%</span>"
            .."<span color=\"#909090\">,</span>"
        end
        r = r .. "<span color=\"#909090\">]</span>"
    end

    return r
end, 3)
--
-- Memory widget
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem,
    "<span color=\"#909090\">RAM:</span>" ..
    "<span color=\"#FFFFFF\">$1%</span>", 13)
--
-- MPD widget
mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget,
vicious.widgets.mpd,
function (widget, args)
	if args["{state}"] == "Stop" then
        return ""
	else
        return (args["{state}"]=='Play' and '♫' or  '('.. args["{state}"] .. ')') ..
        ': <span color="white">'..  args["{Title}"]..'</span> '..
		'<span color="#909090">por</span> '..
		'<span color="white">'.. args["{Artist}"] ..  '</span> '..
		'<span color="#909090">de</span> '..
		'<span color="white">'.. args["{Album}"] ..  '</span> '
	end
end)
--
-- Volume widget
volwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.volume)
vicious.register(volwidget, vicious.widgets.volume,
    "<span color=\"#909090\">VOL:</span>" ..
    "<span color=\"#FFFFFF\">$1%</span>", 2, "Master")
--
-- Battery widget
batnotification = 0
batwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.volume)
vicious.register(batwidget, vicious.widgets.bat,
function (widget, args)
    local color = "#FFFFFF"
    if args[1]=='-' and args[2]<=15 then
        color = "#F7D434"
        if batnotification==0 then
            naughty.notify({
                timeout = 10,
                text="Battery is low.",
                replaces_id=1,
            })
            batnotification = 1
        end
    end

    if args[1]=='-' and args[2]<=5 then
        color = "#ED3232"
        if batnotification<=1 then
            naughty.notify({
                timeout = 0,
                fg=color,
                text="Battery is low.", })
            batnotification = 2
        end
    end

    if args[1]=='+' then
        color = "#C8CDE0"
        batnotification=0
    end

    return "<span color=\"#909090\">BAT:</span>"
    .."<span color=\""..color.."\">" ..args[2].."%</span>"
end, 1, "BAT1")
-- }}}

-- Create a laucher widget and a main menu
myawesomemenu = {
    {"manual", terminal .. " -e man awesome"},
    {"edit config",
     editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}

mymainmenu = awful.menu(
    {
        items = {
            {"awesome", myawesomemenu, beautiful.awesome_icon},
              {"open terminal", terminal}}
          })

mylauncher = awful.widget.launcher({image = image(beautiful.awesome_icon),
                                     menu = mymainmenu})

-- Create a systray
mysystray = widget({type = "systray", align = "right"})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({}, 1, awful.tag.viewonly),
    awful.button({modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, function(tag) tag.selected = not tag.selected end),
    awful.button({modkey}, 3, awful.client.toggletag),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        client.focus = c
        c:raise()
        end),
    awful.button({}, 3, function()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({width=250})
        end
        end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
        end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
        end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] =
        awful.widget.prompt({layout = awful.widget.layout.leftright})
    -- Create an imagebox widget which will contains an icon indicating which
    -- layout we're using.  We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
            awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s,
                                            awful.widget.taglist.label.all,
                                            mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                        return awful.widget.tasklist.label.currenttags(c, s)
                    end,
                                              mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({position = "top", screen = s})
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        datewidget,
        s == 1 and mysystray or nil,
        separator,
        memwidget,
        separator,
        cpuwidget,
        separator,
        volwidget,
        separator,
        batwidget,
        separator,
        mpdwidget,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        }

    mywibox[s].screen = s
end

-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()

-- Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = awful.util.table.join(
    -- Tags
    --awful.key({modkey,}, "Left", awful.tag.viewprev),
    awful.key({modkey, "Control"}, "k", awful.tag.viewprev),
    --awful.key({modkey,}, "Right", awful.tag.viewnext),
    awful.key({modkey, "Control"}, "j", awful.tag.viewnext),
    awful.key({modkey,}, "Escape", awful.tag.history.restore),

    -- Shifty: keybindings specific to shifty
    awful.key({modkey, "Shift"}, "d", shifty.del), -- delete a tag
    awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
    awful.key({modkey}, "n", shifty.send_next), -- client to next tag
    awful.key({modkey, "Control"},
              "n",
              function()
                  local t = awful.tag.selected()
                  local s = awful.util.cycle(screen.count(), t.screen + 1)
                  awful.tag.history.restore()
                  t = shifty.tagtoscr(s, t)
                  awful.tag.viewonly(t)
              end),
    awful.key({modkey}, "a", shifty.add), -- creat a new tag
    awful.key({modkey,}, "r", shifty.rename), -- rename a tag
    awful.key({modkey, "Shift"}, "a", -- nopopup new tag
    function()
        shifty.add({nopopup = true})
    end),

    awful.key({modkey,}, "j",
    function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "k",
    function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "w", function() mymainmenu:show(true) end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "j",
        function() awful.client.swap.byidx(1) end),
    awful.key({modkey, "Shift"}, "k",
        function() awful.client.swap.byidx(-1) end),
    --awful.key({modkey, "Control"}, "j", function() awful.screen.focus(1) end),
    --awful.key({modkey, "Control"}, "k", function() awful.screen.focus(-1) end),
    awful.key({modkey,}, "u", awful.client.urgent.jumpto),
    awful.key({modkey,}, "Tab",
    function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    -- MPD control trough MPC
    awful.key({ }, "XF86AudioPlay",
    function ()
        awful.util.spawn("mpc toggle" )
    end),

    -- Volume control media key.
    awful.key({ }, "XF86AudioRaiseVolume",
    function ()
        awful.util.spawn("amixer -q sset Master 3%+" )
    end),
    awful.key({ }, "XF86AudioLowerVolume",
    function ()
        awful.util.spawn("amixer -q sset Master 3%-" )
    end),

    -- Standard program
    awful.key({modkey,}, "Return", function() awful.util.spawn(terminal) end),
    awful.key({modkey,}, ".", function() awful.util.spawn(file_manager) end),
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),

    awful.key({modkey,}, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({modkey,}, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1) end),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
    awful.key({modkey,}, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({modkey, "Shift"}, "space",
        function() awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({modkey}, "F1", function()
        awful.prompt.run({prompt = "Run: "},
        mypromptbox[mouse.screen].widget,
        awful.util.spawn, awful.completion.shell,
        awful.util.getdir("cache") .. "/history")
        end),

    awful.key({modkey}, "F4", function()
        awful.prompt.run({prompt = "Run Lua code: "},
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
        end)
    )

-- Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({modkey,}, "f", function(c) c.fullscreen = not c.fullscreen  end),
    awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
    awful.key({modkey, "Control"}, "Return",
        function(c) c:swap(awful.client.getmaster()) end),
    awful.key({modkey,}, "o", awful.client.movetoscreen),
    awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
    awful.key({modkey}, "t", awful.client.togglemarked),
    awful.key({modkey,}, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, i, function()
            local t =  awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({modkey, "Control"}, i, function()
            local t = shifty.getpos(i)
            t.selected = not t.selected
            end),
        awful.key({modkey, "Control", "Shift"}, i, function()
            if client.focus then
                awful.client.toggletag(shifty.getpos(i))
            end
            end),
        -- move clients to other tags
        awful.key({modkey, "Shift"}, i, function()
            if client.focus then
                t = shifty.getpos(i)
                awful.client.movetotag(t)
                awful.tag.viewonly(t)
            end
        end))
    end

-- Set keys
root.keys(globalkeys)

-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- {{{ Startup programs
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

run_once("xcompmgr")
run_once("dropbox","start")
run_once("nm-applet")
run_once("gnome-sound-applet")
run_once("conky")
run_once("gnome-do")
--run_once("mpd")
--run_once("mpdscribble")
run_once("mopidy")
run_once("fluxgui")
run_once("/usr/lib/notification-daemon/notification-daemon")
run_once("/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
-- }}}
