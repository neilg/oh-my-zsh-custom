#!/bin/zsh

zparseopts -E -a opts t
#echo $opts

if [ -z $DISPLAY ] && [ -z ${opts[(r)-t]} ]; then
    echo asdf
    echo emacsclient -a '' -t "$@"
else
    displays=`emacsclient -a '' --eval "(mapcar (lambda (frame)
                                              (terminal-name (frame-terminal frame)))
                                                             (frame-list))"`
    echo "$displays" | grep -q '"'$DISPLAY'"'
    if [ $? -eq 0 ]; then
	emacsclient -a '' "$@"
    else
	emacsclient -a '' --create-frame "$@"
    fi
fi



