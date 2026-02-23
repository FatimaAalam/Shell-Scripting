#!/bin/bash

echo "This is me trying new things."
echo "Lets create new user using users input as variable."
read -p "enter user name" username
echo "you entered username $username"
sudo useradd -m $username
echo "User have been addedg"
