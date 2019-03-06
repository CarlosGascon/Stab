%% Script to run the simulations
clear all; close all; clc;

%% Data Input

TargetList1 = {'24 Sex', ['b', 'c']; 
              '47 UMa', ['b', 'c', 'd']
              '55 Cnc', ['b', 'c', 'f']
              'HD 10180', ['c', 'e', 'f', 'h']};
          
TargetList2 = {'75 Cet',  ['b']
               '81 Cet',  ['b']
               '91 Aqr',  ['b']
               'GJ 179',  ['b']
               'HD 45364',['b', 'c']
               'HD 9174', ['b']
               'HD 96167',['b']
               'HIP 74890', ['b']
               'HIP 67537', ['b']};

TargetList3 = {'47 UMa', ['b', 'c', 'd']};

TargetList4 = {'47 UMa', ['b', 'd']
               'HD 141399', ['b', 'c', 'd'] 
               '55 Cnc', ['b', 'c', 'f']
               'HD 27894',['b', 'c']};
TargetList5 = {'7 CMa', ['b']};

Norb = 80;

YearsSim = 1e7;

Ncores = 1;

Nexo = 1;

%% Run Simulation and Output

[StableOrbs, time] = Run_Sims(TargetList5, Nexo, Norb, YearsSim, Ncores);