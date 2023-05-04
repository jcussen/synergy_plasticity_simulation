# Code for learning simulations

## How to run

On the terminal, execute the file run.sh -> $bash run.sh

Or change the file to executable -> $chmod +x run.sh

and then run it directly -> $./run.sh

It will ask which simulation you would like to run, press 1, 2 or 3 according to your choice.

1 -> Hebbian + scaling

2 -> Hebbian + anti-Hebbian

3 -> Hebbian + Hebbian

It will take approximately 10 mins to run 20 mins or simulation time (more or less depending on your processor). 
The figure will be generated automatically once simulation is over.

## Folders

There are three source code for the three different simulations. 
Folder "Hebbian_Hebbian" contains the code for the simulation with Hebbian plasticity in both inhibitory populations. 
Folder "Hebbian_scaling" contains the code for the simulation with Hebbian plasticity in one inhibitory population and homeostatic scaling plasticity in the other inhibitory population. 
Folder "Hebbian_antiHebbian" contains the code for the simulation with Hebbian plasticity in one inhibitory population and anti-Hebbian plasticity in the other inhibitory population. 

## Parameters

Parameters for models are in "config.f90" file, in the vector "pr" and other specific variable names. 

## Initial conditions.

Initial conditions are in "initial_conditions.f90" file.