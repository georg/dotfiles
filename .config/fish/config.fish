if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_should_add_to_history
        string match -qr "^\s" -- $argv; and return 1
        return 0
    end
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/georgf/google-cloud-sdk/path.fish.inc' ]
    . '/Users/georgf/google-cloud-sdk/path.fish.inc'
end
