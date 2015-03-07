#!/bin/zsh

zparseopts -E -a opts t

if [ -z $DISPLAY ] && [ -z ${opts[(r)-t]} ]; then
    emacsclient -a '' -t "$@"
else
    displays=`emacsclient -a '' --eval "(mapcar (lambda (frame)
                                              (terminal-name (frame-terminal frame)))
                                                             (frame-list))"`
    echo "$displays" | grep -q '"'$DISPLAY'"'
    if [ $? -eq 0 ]; then
	# TODO don't execute this if there are no args
	emacsclient -a '' "$@" 2>/dev/null
	# always execute this
	emacsclient -a '' --eval "(raise-frame)" >/dev/null
    else
	emacsclient -a '' --create-frame "$@"
    fi
fi
