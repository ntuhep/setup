#!/bin/bash

#Set up the CMSSW envirnoment
scram project CMSSW_5_3_14_patch2
cd CMSSW_5_3_14_patch2/src
cmsenv
git cms-addpkg FWCore/Version #This should change at some point to git cms-init 

#This is the center piece. Check out bprimeKit code
git clone https://github.com/ntuhep/bprimeKit.git MyAna/bprimeKit

#UserCode that is required
#We should evaluate whether we truly need this, if so, perhaps it should be in official CMSSW code
git clone https://github.com/ETHZ/sixie-Muon-MuonAnalysisTools.git UserCode/sixie/Muon/MuonAnalysisTools
git clone https://github.com/amarini/QuarkGluonTagger.git

#Compile everything
scramv1 b -j 20