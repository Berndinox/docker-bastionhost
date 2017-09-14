#!/bin/sh
echo "root:"$PASSWORD | chpasswd
exec "$@"
