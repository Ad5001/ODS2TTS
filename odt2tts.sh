#!/bin/bash
TEXT=`odt2txt $1`;
pattern="\[-- ([\w]+): Objet(\d+) --\]"
pico2wave -l=${2:-"fr-FR"} -w=/tmp/out.wav "${TEXT//$pattern/, $1$2}";
