#!/bin/sh
echo "root:"$PASSWORD | chpasswd
/bin/bash -c "/usr/sbin/sshd"
