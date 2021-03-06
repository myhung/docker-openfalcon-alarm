#!/bin/bash

APP="falcon-alarm"
WAIT_SERVICE_READY=10

function check_service(){
  status=$($WORKDIR/control status)
  echo $status | grep -q "stoped"
  if [ $? -eq 0 ] ; then
    return 1
  else
    return 0
  fi
}

tar -zxf $PACKDIR/$PACKFILE -C $WORKDIR
cp $CONFIGDIR/$CONFIGFILE $WORKDIR

$WORKDIR/control restart
while sleep $WAIT_SERVICE_READY; do
  check_service
  if [ $? -eq 1 ] ; then
    echo "$APP exited"
    exit 1
  fi
done
