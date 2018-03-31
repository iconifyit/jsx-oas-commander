# JSX-OAS Commander

## NB: This is a work-in-progress and not production-ready.

## Description

An AppleScript proxy to allow ExtendScript to run shell scripts and retrieve the results in JSON format. 

JavaScript Extension in Adobe Illustrator can call `File().execute()` but if you try to run this on a shell script, it will open the script in the Terminal app but does not run or return the results. The approach in this utility allows JSX to call `File().execute()` on the **Commander.app** applet and retrive the results.

The idea is to create an applet that will take any commands and parameters, execute them on the shell, including bash and NodeJS, and return the results in JSON format via a known output file.

## Installation 

@TODO:

## Usage 

@TODO:
