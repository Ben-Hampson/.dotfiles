#!/bin/bash

# Pomodoro
# Credit bashbunni https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106

# work 90 -> Work Pomodoro for 90 minutes.
work () {
	timer $1m && $NOTIFICATION_APP -message 'Pomodoro'\
		-title 'Work Timer is up! Take a break 😊'\
		-appIcon '~/Pictures/pumpkin.png'\
		-sound Crystal
	}

rest () {
	timer $1m && $NOTIFICATION_APP -message 'Pomodoro'\
		-title 'Rest Timer is up! Back to work 😊'\
		-appIcon '~/Pictures/pumpkin.png'\
		-sound Crystal
	}
