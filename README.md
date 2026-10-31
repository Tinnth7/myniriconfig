# myniriconfig

A minimal, rounded, transparent and blurred [niri](https://github.com/niri-wm/niri) setup on CachyOS (Arch).

Includes configs for:

| Part | What it does |
|------|--------------|
| **niri** | Compositor: no borders, rounded corners, blur on kitty and fuzzel |
| **waybar** | Floating bar with workspaces, clock, volume, network, battery |
| **kitty** | Terminal at 60% opacity |
| **fuzzel** | App launcher and emoji picker backend |
| **awww** | Wallpaper daemon (the renamed `swww`) |

> Screenshot: add one here (`Mod+Shift+S` in niri), e.g. `![preview](screenshots/preview.png)`

## Requirements

- **niri 26.04 or newer.** Background blur (`background-effect`) does not exist in older versions, and the config will fail to validate. Check with `niri --version`.
- A [Nerd Font](https://www.nerdfonts.com/) for the bar icons.

Install everything:

```bash
sudo pacman -S niri waybar kitty fuzzel awww networkmanager \
    wl-clipboard wtype noto-fonts-emoji ttf-jetbrains-mono-nerd pavucontrol
paru -S bemoji
```

`pavucontrol` is optional (right-click on the volume widget opens it).

## Install

**Back up your current configs first**, since this overwrites them:

```bash
mkdir -p ~/config-backup
cp -r ~/.config/{niri,waybar,kitty,fuzzel} ~/config-backup/ 2>/dev/null
```

Then clone and copy:

```bash
git clone https://github.com/Tinnth7/myniriconfig.git
cd myniriconfig
cp -r .config/* ~/.config/
chmod +x ~/.config/waybar/network.sh
mkdir -p ~/Pictures/Screenshots
```

Validate and reload:

```bash
niri validate
niri msg action load-config-file
```

If you are not already in niri, log out and pick the niri session.

## Wallpaper

Put an image somewhere and set it with awww:

```bash
awww-daemon &
awww img ~/Pictures/wallpaper.jpg
```

To make it persistent, add these to `~/.config/niri/config.kdl` (change the path):

```kdl
spawn-at-startup "awww-daemon"
spawn-at-startup "sh" "-c" "sleep 1 && awww img /home/YOURNAME/Pictures/wallpaper.jpg"
```

## Keybinds

`Mod` is Super on a TTY and Alt when niri runs inside another window.

| Keys | Action |
|------|--------|
| `Mod+T` | Open kitty |
| `Mod+D` | Open fuzzel launcher |
| `Mod+.` | Emoji picker (bemoji + fuzzel) |
| `Mod+Shift+.` | Expel window from column |
| `Mod+Shift+S` | Screenshot (select a region) |
| `Mod+Ctrl+S` | Screenshot the whole screen |
| `Mod+Ctrl+Shift+S` | Screenshot the focused window |
| `Mod+Alt+Up` / `Mod+Alt+Down` | Volume up / down |
| `Mod+Alt+M` | Mute toggle |
| `Mod+Q` | Close window |
| `Mod+O` | Overview |
| `Mod+Shift+/` | Show niri's hotkey list |

Everything else is niri's default binds. Screenshots are saved to `~/Pictures/Screenshots/` and copied to the clipboard.

Volume can also be changed on the bar: scroll over the volume widget, left-click to mute, right-click for pavucontrol.

## Customizing

**Terminal transparency** — `~/.config/kitty/kitty.conf`:

```
background_opacity 0.6
```

Lower is more transparent. Reload with `Ctrl+Shift+F5`.

**Launcher transparency** — `~/.config/fuzzel/fuzzel.ini`, the last two hex digits of `background` are the alpha (`ff` is solid).

**Blur** — in `config.kdl`, kitty and fuzzel each have a rule like:

```kdl
window-rule {
    match app-id="^kitty$"
    background-effect {
        blur true
        xray false
    }
}
```

`xray false` blurs everything under the window instead of only the wallpaper. Remove the block to turn blur off.

**Bar network text** — `~/.config/waybar/network.sh` shows `Connected : WiFi`, `Ethernet` or `WiFi + Ethernet`. It needs NetworkManager (`nmcli`).

**Bar fonts and icons** — change `font-family` in `~/.config/waybar/style.css`. If icons show as empty boxes, the Nerd Font is missing.

## Troubleshooting

- **Config won't load:** run `niri validate`. It names the line. Duplicate keybinds are a common cause.
- **`background-effect` is not recognised:** niri is older than 26.04. Update it.
- **Waybar looks wrong:** run `waybar` in a terminal to see config errors (usually a missing comma in the JSON).
- **Emoji show as boxes:** install `noto-fonts-emoji` and log out and back in.
- **Terminal not transparent:** close all kitty windows and open a new one.

## Credits

Built on the default [niri](https://github.com/niri-wm/niri) config. Made by Tinnth7 (LiTuz).
