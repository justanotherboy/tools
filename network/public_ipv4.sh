#!/bin/sh

# This script will get return the public IPv4 address of the running host.
# Credit goes to www.commandlinefu.com:
# http://www.commandlinefu.com/commands/view/5253/get-your-outgoing-ip-address

DIG_CMD="dig +short myip.opendns.com @resolver1.opendns.com"

ipv4=`$DIG_CMD`
echo "$ipv4"
