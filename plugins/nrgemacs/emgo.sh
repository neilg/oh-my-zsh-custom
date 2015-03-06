#!/bin/sh

if [ -z $DISPLAY ]; then
  emacsclient --alternate-editor "" -t "$@"
else
  emacsclient --alternate-editor '' --eval "(x-close-connection \"$DISPLAY\")" 2>/dev/null
  if [ $? -eq 0 ]; then
    emacsclient --alternate-editor "" --create-frame $@
  else
    emacsclient --alternate-editor "" $@
  fi
fi
