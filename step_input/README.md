# Code for simulations after learning to display output for phasic and tonic response to step input -> panel E from figures 4, 8 and 10

## How to run

On the terminal, execute the file run.sh -> $bash run.sh

Or change the file to executable -> $chmod +x run.sh

and then run it directly -> $./run.sh

It will ask which simulation you would like to run, press 1, 2, or 3 according to your choice.

1 -> Co-tuned only from Hebbian (figure 4)

2 -> Co-tuned from Hebbian + flat from scaling (figure 8)

3 -> Co-tuned from Hebbian + counter-tuned from anti-Hebbian (figure 10)

It will take approximately 30 minutes to run ~80 minutes of simulation time (more or less depending on your processor). 
It consists of 100 trials for each input signal, for 9 different step inputs, and for 3 cases. 
The figure will be generated automatically once simulation is over.

## Folders

There are three source data files for the three different simulations. 
Folder "Hebbian" contains weight matrix after learning with Hebbian plasticity only (for figure 4). 
Folder "Hebbian_scaling" contains weight matrix after learning with Hebbian plasticity only (for figure 8). 
Folder "Hebbian_antiHebbian" contains weight matrix after learning with Hebbian plasticity only (for figure 10).

## Parameters

Parameters for models are in "config.f90" file, in the vector "pr" and other specific variable names. 

## Initial conditions.

Initial conditions are in file "initial_conditions.f90" and "initial_conditions2.f90".
