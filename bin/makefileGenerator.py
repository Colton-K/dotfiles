#!/bin/python3

'''

A fun little script I made with Carter Goldman @cgoldma2 while waiting for arm simulations on the Notre Dame student machines

'''

import os

files = os.listdir()

# BACK UP CURRENT IF THERE
if "Makefile" in files:
    os.rename("Makefile", "Makefile.old")


cFiles = []
cppFiles = []

linesToWrite = []

def writeLines(linesToWrite):
    with open("Makefile", "w") as fh:
        for line in linesToWrite:
            fh.write(line + "\n")

for fn in files:
    if ".c" in fn[-3:]:
        # gcc to do it
        cFiles.append(fn)
    elif ".cpp" in fn[-5:]:
        # c++ to do it
        cppFiles.append(fn)

# structure make file

# make all
line = "all: "
for l in cFiles:
    line += l[:-2]
    line += " "
for l in cppFiles:
    line += l[:-4]
    line += " "

linesToWrite.append(line)
linesToWrite.append("")

# make individual ones
for f in cFiles:
    linesToWrite.append("{}:".format(f[:-2]))
    linesToWrite.append("\tgcc {} -o {}".format(f, f[:-2]))
    linesToWrite.append("\t# ./{}".format(f[:-2]))
    linesToWrite.append("")
    
for f in cppFiles:
    linesToWrite.append("{}:".format(f[:-4]))
    linesToWrite.append("\tg++ {} -o {}".format(f, f[:-4]))
    linesToWrite.append("\t# ./{}".format(f[:-4]))
    linesToWrite.append("")

# make clean - should be same items as make all
linesToWrite.append("clean:")

line = "\t rm "
for l in cFiles:
    line += l[:-2]
    line += " "
for l in cppFiles:
    line += l[:-4]
    line += " "

linesToWrite.append(line)
linesToWrite.append("")

writeLines(linesToWrite)
