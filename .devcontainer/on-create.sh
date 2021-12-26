#!/bin/bash

echo "on-create start" >> $HOME/status

# add your commands here

# set file permissions so we can load functions
chmod -R go-w .

echo "on-create complete" >> $HOME/status
