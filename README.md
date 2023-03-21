# Context-switching neuronal plasticity model

## Original model

This repository is forked from [flexible_switch_2ISP](https://github.com/ejagnes/flexible_switch_2ISP). The original neuronal simulation model was used to produce results and figures for the following publication:
[Complementary Inhibitory Weight Profiles Emerge from Plasticity and Allow Flexible Switching of Receptive Fields](https://www.jneurosci.org/content/40/50/9634).

Everton J. Agnes (1), Andrea I. Luppi (1), and Tim P. Vogels (1,2).

1 - Centre for Neural Circuits and Behaviour, University of Oxford, Oxford, UK

2 - Institute for Science and Technology Austria 

## Modifications

This forked repository is used to generate data for information-theoretic analysis of neuronal activity. It is part of an investigation of how synaptic plasticity rules affect synergistic information processing. 

The main modificatons are the output of spiking and firing rate data, and 'snapshots' of the system and its inhibitory weights during the learning phase.

## How to use

### Set up

For reproducibility the code posted here was rewritten to run with GNU Fortran (gfortran; free). Plots are generated with gnuplot. To run the code from this repository you need both GNU Fortran (gfortran) and Gnuplot installed. Figures were generated with gnuplot and edited with [Inkscape](https://inkscape.org/).

### GNU Fortran

```
brew install gcc
```

https://www.gnu.org/software/gcc/fortran/

### Gnuplot

```
brew install gnuplot
```

http://www.gnuplot.info/

## Repository organisation

Each folder contains the code to run simulations and generate figures.

Folder "membrane_potential" for panel B from figures 4, 8 and 10

Folder "correlation" for panel D (top) from figuress 4, 8 and 10

Folder "step_input" for panel E from figures 4, 8 and 10

Folder "learning" for figures 7 and 9

