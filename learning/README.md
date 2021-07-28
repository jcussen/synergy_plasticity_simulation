# Code for simulations with learning -> figures 7 and 9

## How to run

On the terminal, execute the file run.sh -> $bash run.sh

Or change the file to executable -> $chmod +x run.sh

and then run it directly -> $./run.sh

It will ask which simulation you would like to run, press 1 or 2 according to your choice.

1 -> Hebbian + scaling (figure 7)

2 -> Hebbian + anti-Hebbian (figure 9)

It will take approximately 10 mins to run 20 mins or simulation time (more or less depending on your processor). 
The figure will be generated automatically once simulation is over.

## Folders

There are two source code for the two different simulations. 
Folder "Hebbian_scaling" contains the code for the simulation with Hebbian and scaling models (figure 7). 
Folder "Hebbian_antiHebbian" contains the code for the simulation with Hebbian and anti-Hebbian models (figure 9). 

## Parameters

Parameters for models are in "config.f90" file, in the vector "pr" and other specific variable names. 

## Initial conditions.

Initial conditions are in "initial_conditions.f90" file.

## Questions

Feel free to contact me if you have any questions about the code.
