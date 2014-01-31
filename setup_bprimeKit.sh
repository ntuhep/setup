#!/bin/bash

scram project CMSSW_5_3_14_patch2
cd CMSSW_5_3_14_patch2/src
cmsenv
git cms-addpkg FWCore/Version
git clone https://github.com/ntuhep/bprimeKit.git MyAna/bprimeKit

# git cms-addpkg EgammaAnalysis/ElectronTools
# cd EgammaAnalysis/ElectronTools/data/
# cat download.url | xargs wget
# cd -

git clone https://github.com/ETHZ/sixie-Muon-MuonAnalysisTools.git UserCode/sixie/Muon/MuonAnalysisTools

git clone https://github.com/ntuhep/bpkHitFit.git MyAna/bpkHitFit

git clone https://github.com/amarini/QuarkGluonTagger.git

scramv1 b -j 20