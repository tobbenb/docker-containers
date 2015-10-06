#!/bin/bash

LESSBIN=`which less`

if [ "$LESSBIN" = "" ]
then
  echo "You need to have 'less' program installed";
  exit 1;
fi

$LESSBIN $1

exit 0;
