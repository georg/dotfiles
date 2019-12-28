(* This script is adapted from
   https://github.com/adriantrunzo/dotfiles/blob/83e3c40db1339c1f130c21411b9ee9fe591a45b9/setup/set-terminal-theme.applescript *)

tell application "Terminal"

    local allOpenedWindows
    local initialOpenedWindows
    local windowID

    (* Set the fully qualified path to the .terminal file. We'll need to
       refer to the theme name separately though. *)
    set themeName to "Solarized Dark"
    set themePath to (system attribute "HOME") & "/.config/themes/osx-terminal.app-colors-solarized/"
    set themeFile to themePath & themeName & ".terminal"

    (* Set our desired font. *)
    set fontName to "SourceCodePro-Regular"
    set fontSize to 12

    (* Store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window

    (* Open the custom theme so that it gets added to the list of  available
       terminal themes. Note: this will open an additional terminal window. *)
    do shell script "open '" & themeFile & "'"

    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1

    (* Modify the custom theme to set our desired font. *)
    set font name of settings set themeName to fontName
    set font size of settings set themeName to fontSize

    (* Set the custom theme as the default terminal theme. *)
    set default settings to settings set themeName

    (* Get the IDs of all the currently opened terminal windows. *)
    set allOpenedWindows to id of every window

    repeat with windowID in allOpenedWindows

        (* Close the additional windows that were opened in order to add the
           custom theme to the list of terminal themes. *)
        if initialOpenedWindows does not contain windowID then
            close (every window whose id is windowID)

        (* Change the theme for the initial opened terminal windows to remove
           the need to close them in order for the custom theme to be applied. *)
        else
            set current settings of tabs of (every window whose id is windowID) to settings set themeName
        end if
    end repeat
end tell
