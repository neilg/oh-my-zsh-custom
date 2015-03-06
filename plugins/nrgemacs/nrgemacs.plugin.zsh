# required launcher functionality
# 1. in terminal, can be used as $EDITOR, i.e. open and block in terminal
# 2. in xterminal can be used as $EDITOR, i.e. open as window (existing or new if needed) and block terminal
# 3. in terminal can be used to open file, i.e. open and block in terminal

# 4. in xterminal can be used to open file, i.e. open as window (existing or new if needed) blocking optional
# 5. in xterminal can be used to get frame, i.e. create frame if none exists

if "$ZSH/tools/require_tool.sh" emacs 23 2>/dev/null ; then
    export EMACS_PLUGIN_LAUNCHER="$ZSH/custom/plugins/nrgemacs/emgo.sh"

    # set EDITOR if not already defined.
    # export EDITOR="${EDITOR:-${EMACS_PLUGIN_LAUNCHER}}"

    alias emacs="$EMACS_PLUGIN_LAUNCHER --no-wait"
    alias e=emacs

    # same than M-x eval but from outside Emacs.
    alias eeval="$EMACS_PLUGIN_LAUNCHER --eval"
    # create a new X frame
    alias eframe='emacsclient --alternate-editor "" --create-frame'

    # Write to standard output the path to the file
    # opened in the current buffer.
    function efile {
        local cmd="(buffer-file-name (window-buffer))"
        "$EMACS_PLUGIN_LAUNCHER" --eval "$cmd" | tr -d \"
    }

    # Write to standard output the directory of the file
    # opened in the the current buffer
    function ecd {
        local cmd="(let ((buf-name (buffer-file-name (window-buffer))))
                     (if buf-name (file-name-directory buf-name)))"

        local dir="$($EMACS_PLUGIN_LAUNCHER --eval $cmd | tr -d \")"
        if [ -n "$dir" ] ;then
            echo "$dir"
        else
            echo "can not deduce current buffer filename." >/dev/stderr
            return 1
        fi
    }
fi

## Local Variables:
## mode: sh
## End:
