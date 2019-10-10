#!/bin/bash

LOGFILE=$1
shift
printf "$@\n" >> $LOGFILE
