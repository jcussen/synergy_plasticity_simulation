# Forked Agnes et al. (2020) context switching model of synaptic plasticity

This repo is used to generate data for information-theoretic analysis of neuronal activity as part of a MSc thesis investigating the effects of synaptic plasticity rules on synergy.

The main modificatons are the output of spiking and firing rate data, and 'snapshots' of the system and its inhibitory weights during the learning phase.


## Code used for article: Complementary Inhibitory Weight Profiles Emerge from Plasticity and Allow Flexible Switching of Receptive Fields

Everton J. Agnes (1), Andrea I. Luppi (1), and Tim P. Vogels (1,2)

1 - Centre for Neural Circuits and Behaviour, University of Oxford, Oxford, UK

2 - Institute for Science and Technology Austria 

https://doi.org/10.1523/JNEUROSCI.0276-20.2020

## Repository organisation

Each folder contains the code to run simulations and generate figures.

Folder "membrane_potential" for panel B from figures 4, 8 and 10

Folder "correlation" for panel D (top) from figuress 4, 8 and 10

Folder "step_input" for panel E from figures 4, 8 and 10

Folder "learning" for figures 7 and 9

## Coding language and compilers

The code was originoriginally written to run on Intel Fortran compiler. For reproducibility the code posted here was rewritten to run with GNU Fortran (gfortran; free). Plots are generated with gnuplot. To run the code from this repository you need both GNU Fortran (gfortran) and Gnuplot installed on a linux machine (not tested on Windows or iOS).

Figures in the original article were generated with gnuplot and edited with Inkscape.

### GNU Fortran

https://www.gnu.org/software/gcc/fortran/

### Gnuplot

http://www.gnuplot.info/

### Inkscape

https://inkscape.org/

### Contact

If you have any questions, or found a bug, please contact me at everton (dot) agnes (at) gmail (dot) com
