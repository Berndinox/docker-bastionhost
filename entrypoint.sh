#!/bin/sh
echo "root:$PASSWORD | chpasswd
exec "/usr/sbin/sshd"-D
