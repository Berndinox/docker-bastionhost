#!/bin/sh
echo "root:"$PASSWORD | chpasswdexec
exec "$@"
