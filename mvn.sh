#!/bin/sh

# Written by Mike Ensor (mike@ensor.cc)
# Copywrite 2012
# Use as needed, modify, have fun!
# This is intended to be used for Maven3 + Mac OSX
#
# To use:
# in your ".bashrc" or ".bash_profile" add the following line:
# source ~/<path to script>/colorize-maven.sh
#

c_black=
c_cyan=
c_magenta=
c_red=
c_white=
c_green=
c_yellow=
c_blue=
c_bg_black=
c_bg_cyan=
c_bg_magenta=
c_bg_red=
c_bg_white=
c_bg_green=
c_bg_yellow=
c_bg_blue=
c_end=
c_bold=

xterm_color() {
	#	0	Black
	#	1	Red
	#	2	Green
	#	3	Yellow
	#	4	Blue
	#	5	Magenta
	#	6	Cyan
	#	7	White

    # Yes, this could be a map
    c_bold=`tput setaf 0`
    c_bg_bold=`tput setab 0`
    c_black=`tput setab 0`
    c_bg_black=`tput setab 0`
    c_cyan=`tput setaf 6`
    c_bg_cyan=`tput setab 6`
    c_magenta=`tput setaf 5`
    c_bg_magenta=`tput setab 5`
    c_red=`tput setaf 1`
    c_bg_red=`tput setab 1`
    c_white=`tput setaf 7`
    c_bg_white=`tput setab 7`
    c_green=`tput setaf 2`
    c_bg_green=`tput setab 2`
    c_yellow=`tput setaf 3`
    c_bg_yellow=`tput setab 3`
    c_blue=`tput setaf 4`
    c_bg_blue=`tput setab 4`
    c_end=`tput sgr0`
}

ansi_color() {
    c_bold=   '[1m'
    c_blue=   '[1;34m'
    c_black=  '[1;30m'
    c_green=  '[1;32m'
    c_magenta='[1;35m'
    c_red=    '[1;31m'
    c_cyan=   '[1;36m'
    c_end=    '[0m'
}

color_maven() {

    # pick color type
    if [[ $TERM = 'xterm-color' || $TERM = 'xterm-256color' ]]
    then
        xterm_color
    # elif [ $TERM = 'ansi' ]
    # then
    #     ansi_color
    else
        echo "${c_red}WARNING:::Terminal '${TERM}' is not supported at this time. Colorized output will not happen for Maven${c_end}"
        echo "Add the following line to your ~/.bashrc or ~/.zshrc file in order to enable the color support:"
        echo
        echo "export TERM=\"xterm-256color\""
        echo
    fi

    errorhighlight=${c_yellow}
    error=${c_bold}${c_red}
    info=${c_end}
    debug=${c_blue}
    warn=${c_yellow}
    success=${c_green}
    projectname=${c_bold}${c_black}${c_bg_white}
    skipped=${c_blue}
    downloading=${c_magenta}
    separator=${c_cyan}
    defaulttext=${c_white}

	mvn $* | sed -E -e "s/(\[INFO\] )(Building .*)/${info}\1${projectname}\2${c_end}/g" \
                    -e "s/(Time elapsed: )([0-9]+[.]*[0-9]*.sec)/${defaulttext}\1${c_cyan}\2${c_end}/g" \
                    -e "s/(Downloading: .*)/${downloading}\1${c_end}/g" \
                    -e "s/(\[INFO\])(.* Successfully .*)/${info}\1${success}\2${c_end}/g" \
                    -e "s/(\[INFO\])(.* Attempting .*)/${info}\1${warn}\2${c_end}/g" \
                    -e "s/(\[INFO\])(.* Warning:)(.*)/${info}\1${warn}\2${defaulttext}\3${c_end}/g" \
                    -e "s/(\[INFO\])(.* Note:)(.*)/${info}\1${debug}\2${defaulttext}\3${c_end}/g" \
                    -e "s/(\[INFO\].*)(Installing )(.*)( to )(.*)/${defaulttext}\1${c_blue}\2${defaulttext}\3${c_blue}\4${defaulttext}\5${c_end}/g" \
                    -e "s/(BUILD SUCCESS.*)/${success}\1${c_end}/g" \
                    -e "s/BUILD FAILURE/${error}BUILD FAILURE${c_end}/g" \
                    -e "s/WARNING: (\([a-zA-Z0-9./\\ :-]\+\))/${warn}WARNING: \1${c_end}/g" \
                    -e "s/SEVERE: (.+)/${c_white}${c_bg_red}SEVERE: \1${c_end}/g" \
                    -e "s/Caused by: (.+)/${c_white}${c_bg_green}Caused by: \1${c_end}/g" \
                    -e "s/Running (.+)/${c_cyan}Running \1${c_end}/g" \
                    -e "s/SUCCESS (\[[0-9.:]+s\])/${success}SUCCESS \1${c_end}/g" \
                    -e "s/FAILURE (\[[0-9.:]+s\])/${error}FAILURE \1${c_end}/g" \
                    -e "s/SKIPPED/${skipped}SKIPPED${c_end}/g" \
                    -e "s/(--- android-maven-plugin.*)/${separator}\1${c_end}/g" \
                    -e "s/(--- maven.*)/${separator}\1${c_end}/g" \
                    -e "s/(\[INFO.*)/${info}\1${c_end}/g" \
                    -e "s/(\[DEBUG.*)/${debug}\1${c_end}/g" \
                    -e "s/INFO: (.+)/${info}INFO: \1${c_end}/g" \
                    -e "s/(Error: No resource found that matches the given name)/${errorhighlight}\1${info}/g" \
                    -e "s/(\[WARN.*)/${warn}\1${c_end}/g" \
                    -e "s/(\[ERROR.*)/${error}\1${c_end}/g" \
                    -e "s/(DISABLED)/${c_red}\1${c_end}/g" \
                    -e "s/(\[ERROR.*)(on project.*: )(.*)(-> \[Help 1\])/${error}\1${error}\2${errorhighlight}\3${error}\4${c_end}/g" \
                    -e "s/(No online devices attached.)/${errorhighlight}\1${c_red}/g" \
                    -e "s/(Unable to run launcher Activity)/${errorhighlight}\1${c_red}/g" \
                    -e "s/(No such file or directory)/${errorhighlight}\1${c_red}/g" \
                    -e "s/(No plugin found for prefix 'android' in the current project and in the plugin groups)/${errorhighlight}\1${c_red}/g" \
                    -e "s/(There are test failures.)/${errorhighlight}\1${c_red}/g" \
                    -e "s/(<<< FAILURE!)/${error}\1${c_end}/g" \
                    -e "s/(Building jar: )(.*)/${c_bg_black}${success}\1${c_yellow}\2${c_end}/g" \
                    -e "s/(Add native libraries from )(.*)/${success}\1${c_yellow}\2${c_end}/g" \
                    -e "s/(Manifest merging disabled. Using project manifest only)/${success}\1${c_end}/g" \
                    -e "s/(Enabling )(.*)( for apk.)/${success}\1${c_yellow}\2${success}\3${c_end}/g" \
                    -e "s/(Picked up _JAVA_OPTIONS: )(.*)/${c_green}\1${c_yellow}\2${c_end}/g" \
                    -e "s/(\[INFO\].*\.\.SUCCESS.*)/${success}\1${c_end}/g" \
                    -e "s/(\[INFO\].*Passed: )([0-9]*)(.*Failed: )([0-9]*)(.*Errors: )([0-9]*)(.*Skipped: )([0-9]*)/${defaulttext}\1${success}\2${defaulttext}\3${warn}\4${defaulttext}\5${error}\6${defaulttext}\7${skipped}\8${defaulttext}/g" \
                    -e "s/^(Tests run: )([0-9]*)(.*Failures: )([0-9]*)(.*Errors: )([0-9]*)(.*Skipped: )([0-9]*)/${defaulttext}\1${success}\2${defaulttext}\3${warn}\4${defaulttext}\5${error}\6${defaulttext}\7${skipped}\8${defaulttext}/g" ;
}