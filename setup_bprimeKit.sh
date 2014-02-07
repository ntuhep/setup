#!/bin/bash
echo "Beginning download and compilation of bprimeKit package"

installHitFit=false

#Allow for some command line arguments
while test $# -gt 0; do
	case $1 in
		--hitfit)
			installHitFit=true
			echo "  Include HitFit packages"
			shift
			;;
		*)
			echo >&2 "  Invalid argument: $1"
			;;
	esac
	shift
done

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

#Add HitFit related code if requested
if $installHitFit; then
	git clone https://github.com/ntuhep/bpkHitFit.git MyAna/bpkHitFit
	git clone https://github.com/ntuhep/bpkHitFitAnalysis.git MyAna/bpkHitFitAnalysis
fi

#Compile everything
scramv1 b -j 20