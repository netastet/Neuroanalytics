#!/bin/bash
#Original Script

echo -ne '/';
sleep 1;
echo -ne '\b-';
sleep 1;
echo -ne '\b\\'
sleep 1;
echo -ne '\b|';
sleep 1;
echo -ne '\b/';
sleep 1;
echo -ne '\b-';
sleep 1;
echo -ne '\b\\';
sleep 1;
echo -ne '\b|';
echo -ne "\b \n";

#Different Optiops for the Echo Command
#asside from text, numbers, and variables echo has several other options

#This option continues without creating a new line \c. Below I have written text to appear behind the input field after the first swirl.

echo -e "This text is in front of the next text\c"
sleep 1

#The \t option creates large spaces in between outputs in the echo function output. Below I have written text to appear spaced out

echo -e "This \ttext \tis \treally \tfar \tappart"
sleep 1

#The \v option creates indents in text. Below I have written text that indents out three times. 

echo -e "\vThis \vtext \vis \vmaking \vstair \vsteps"
sleep 1

#the asterix can be used with the echo command to perform the same role as the ls command. The code below will show you all visible files in your directory. 
echo "Now I am going to show you all the folders in this directory"

echo -ne "\n"
echo *
sleep 1

#This script reverses the direction of spin for the swril

echo -ne '/';
sleep 1;
echo -ne '\b|';
sleep 1;
echo -ne '\b\\'
sleep 1;
echo -ne '\b-';
sleep 1;
echo -ne '\b/';
sleep 1;
echo -ne '\b|';
sleep 1;
echo -ne '\b\\';
sleep 1;
echo -ne '\b-';
sleep 1;
echo -ne "\b/"
echo -ne "\b \n"

#This script is the faster swirl

echo -ne '/';
sleep .1;
echo -ne '\b-';
sleep .1;
echo -ne '\b\\'
sleep .1;
echo -ne '\b|';
sleep .1;
echo -ne '\b/';
sleep .1;
echo -ne '\b-';
sleep .1;
echo -ne '\b\\';
sleep .1;
echo -ne '\b|';
echo -ne "\b";

#loop for a spinner with 10 revolutions

echo -ne '/';
for i in $(seq 1 2 20)
do
    echo -ne '\b/'
    sleep 1;
    echo -ne '\b-';
sleep 1;
echo -ne '\b\\'
sleep 1;
echo -ne '\b|';
sleep 1;
echo -ne '\b/';
sleep 1;
echo -ne '\b-';
sleep 1;
echo -ne '\b\\';
sleep 1;
echo -ne '\b|';
sleep 1;
done

#Delete the hash left over from the loop

echo -ne "\b \n"

#This the first spinning shape. We are going to do a very basic spinnging W. Each line presents the symbol with the subsequent lines replaceing the previous symbol with the new one using the \b option. This creates the illusion of spinning

echo -ne 'W';
sleep 1;
echo -ne '\bE';
sleep 1;
echo -ne '\bM';
sleep 1;
echo -ne "\b3";
sleep 1;
echo -ne "\b \n";

#looping the above shape to spin 10 times

for i in $(seq 1 2 20)
do
echo -ne 'W';
sleep 1;
echo -ne '\bE';
sleep 1;
echo -ne '\bM';
sleep 1;
echo -ne "\b3";
sleep 1;
echo -ne "\b";
done

#reversing this shape's spin

for i in $(seq 1 2 20)
do
echo -ne 'W';
sleep 1;
echo -ne '\b3';
sleep 1;
echo -ne '\bM';
sleep 1;
echo -ne "\bE";
sleep 1;
echo -ne "\b";
done

#delete the has left over from the loop

echo -ne "\b \n"

#some word play "spinning" with a classic. Note the phrase has to be written in and out using spaces

echo -ne "\r          H";
sleep .5;
echo -ne "\r         He";
sleep .5;
echo -ne "\r        Hel";
sleep .5;
echo -ne "\r       Hell";
sleep .5;
echo -ne "\r      Hello";
sleep .5;
echo -ne "\r     Hello ";
sleep .5;
echo -ne "\r    Hello W";
sleep .5;
echo -ne "\r   Hello Wo";
sleep .5;
echo -ne "\r  Hello Wor";
sleep .5;
echo -ne "\r Hello Worl";
sleep .5;
echo -ne "\rHello World";
sleep .5;
echo -ne "\rello World ";
sleep .5;
echo -ne "\rllo World  ";
sleep .5;
echo -ne "\rlo World   ";
sleep .5;
echo -ne "\ro World    ";
sleep .5;
echo -ne "\r World     ";
sleep .5;
echo -ne "\rWorld      ";
sleep .5;
echo -ne "\rorld       ";
sleep .5;
echo -ne "\rrld        ";
sleep .5;
echo -ne "\rld         ";
sleep .5;
echo -ne "\rd          ";
sleep .5;
echo -ne "\r           ";

#looping the hello world annimation

for i in $(seq 1 2 20)
do
    echo -ne "\r           H";
sleep .5;
echo -ne "\r          He";
sleep .5;
echo -ne "\r         Hel";
sleep .5;
echo -ne "\r        Hell";
sleep .5;
echo -ne "\r       Hello";
sleep .5;
echo -ne "\r      Hello ";
sleep .5;
echo -ne "\r     Hello W";
sleep .5;
echo -ne "\r    Hello Wo";
sleep .5;
echo -ne "\r   Hello Wor";
sleep .5;
echo -ne "\r  Hello Worl";
sleep .5;
echo -ne "\r Hello World";
sleep .5;
echo -ne "\rHello World!";
sleep .5;
echo -ne "\rello World! ";
sleep .5;
echo -ne "\rllo World!  ";
sleep .5;
echo -ne "\rlo World!   ";
sleep .5;
echo -ne "\ro World!    ";
sleep .5;
echo -ne "\r World!     ";
sleep .5;
echo -ne "\rWorld!      ";
sleep .5;
echo -ne "\rorld!       ";
sleep .5;
echo -ne "\rrld!        ";
sleep .5;
echo -ne "\rld!         ";
sleep .5;
echo -ne "\rd!          ";
sleep .5;
echo -ne "\r!           ";
sleep .5
echo -ne "\r           ";
done

#line to reset position of input

echo -ne "\b \n"
