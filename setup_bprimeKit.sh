#!/bin/bash
echo "Beginning download and compilation of bprimeKit package"

GITHUB_PREFIX="https://github.com/"
INSTALL_HITFIT=false

#Allow for some command line arguments
while test $# -gt 0; do
	case $1 in
		--ssh)
			GITHUB_PREFIX="git@github.com:"
			echo "  Using SSH instead of HTTPS"
			shift
			;;
		--hitfit)
			INSTALL_HITFIT=true
			echo "  Include HitFit packages"
			shift
			;;
		*)
			echo >&2 "  Invalid argument: $1"
			;;
	esac
done

#########################################
# Actually get to work setting things up
#########################################

#Set up the CMSSW envirnoment
scram project CMSSW_5_3_14_patch2
cd CMSSW_5_3_14_patch2/src
cmsenv
git cms-addpkg FWCore/Version #This should change at some point to git cms-init 

#This is the center piece. Check out bprimeKit code
git clone ${GITHUB_PREFIX}ntuhep/bprimeKit.git MyAna/bprimeKit

#UserCode that is required
#We should evaluate whether we truly need this, if so, perhaps it should be in official CMSSW code
git clone ${GITHUB_PREFIX}ETHZ/sixie-Muon-MuonAnalysisTools.git UserCode/sixie/Muon/MuonAnalysisTools
git clone ${GITHUB_PREFIX}amarini/QuarkGluonTagger.git

#Add HitFit related code if requested
if $INSTALL_HITFIT; then
	git clone ${GITHUB_PREFIX}ntuhep/bpkHitFit.git MyAna/bpkHitFit
	git clone ${GITHUB_PREFIX}ntuhep/bpkHitFitAnalysis.git MyAna/bpkHitFitAnalysis
fi

#Compile everything
scramv1 b -j 20
