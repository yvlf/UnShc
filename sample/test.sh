#!/bin/bash
# This script is very critical !
echo "I'm a super critical and private script !"
PASSWORDROOT="SuPeRrOoTpAsSwOrD"';
myService --user=root --password=$PASSWORDROOT > /dev/null 2>&1
