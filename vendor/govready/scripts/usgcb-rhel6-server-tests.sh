#!/bin/sh

#
# Bash shell script to run openSCAP test of RHEL-6
# Copyright 2014, Greg Elin
# License: Apache 2.0
#
# Usage: sudo sh openscap-ssg-rhel6.sh
# Dependencies: 
#   - openscap, see install-openscap.sh
#   - ssg, see install-ssg.sh
#

echo "oscap xccdf eval --profile usgcb-rhel6-server"

oscap xccdf eval --profile usgcb-rhel6-server \
	--results /var/www/govready-html/usgcb-rhel6-server-$(date +%Y%m%d-%H-%M).xml \
	--report /var/www/govready-html/usgcb-rhel6-server-$(date +%Y%m%d-%H-%M).html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml ; true

#
# Gotchas
#
# Adding the `; true` allows Vagrant to continue and not trap for exit status code `0` from scap run. 
# From oscap man page: 
#    Probe the system and evaluate all definitions from OVAL Definition file. Print result of  each  definition
#    to standard output. The return code is 0 after a  successful evaluation. On error, value 1 is returned.
#
