from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import subprocess

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(),  desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(),  desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),    desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current
    # stack. Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and
    # direction will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(),
        desc="Reset all window sizes"),
    
    Key([mod, "shift"], "Return", lazy.spawn(terminal),
        desc="Launch terminal"),
    
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(),
        desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(),
        desc="Kill focused window"),
    Key([mod], "q", lazy.reload_config(),
        desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(),
        desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn('rofi -show run'),
        desc="Run a command through rofi"),
    Key([mod, "control"], "p", lazy.spawn('rofi -show window'),
        desc="Go to a window through rofi"),
    Key([mod], "b", lazy.spawn('bwmenu'),
        desc="Access bitwarden vault using rofi"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move
            # focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}"
                .format(i.name),
            ),
        ]
    )

layouts = [
    layout.MonadTall(margin = 50),
    layout.Max(margin = 50),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper='~/Backgrounds/nge.jpeg',
        wallpaper_mode='fill',
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an
        # X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# Startup Applications
@hook.subscribe.startup
def autostart():
    # Restart Polybar
    subprocess.Popen("pkill polybar", shell=True).wait()
    subprocess.Popen("polybar xmonad", shell=True)
    
    # Restart Waybar
    subprocess.Popen("pkill waybar", shell=True).wait()
    subprocess.Popen("waybar", shell=True)
    
    # Restart Kanshi
    subprocess.Popen("pkill kanshi", shell=True).wait()
    subprocess.Popen("kanshi", shell=True)

wmname = "LG3D"
