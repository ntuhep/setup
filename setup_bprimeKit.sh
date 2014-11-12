#!/bin/bash
echo "Beginning download and compilation of bprimeKit package"

CMSSW_VERSION="CMSSW_5_3_14_patch2"
GITHUB_PREFIX="https://github.com/"
INSTALL_HITFIT=false
COMPILE=true

#Allow for some command line arguments
while test $# -gt 0; do
	case $1 in
		CMSSW*)
			CMSSW_VERSION=$1
			echo "  Using $CMSSW_VERSION"
			shift
			;;
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
		--no-compile)
			COMPILE=false
			echo "  do not compile"
			shift
			;;
		autolist) #seems to happen when no argument given
			shift
			;;
		*)
			echo >&2 "  Invalid argument: $1"
			echo >&2 "    QUITTING"
			shift
			return
			;;
	esac
done

#########################################
# Actually get to work setting things up
#########################################

#Set up the CMSSW envirnoment
scram project $CMSSW_VERSION
cd $CMSSW_VERSION/src
eval `scramv1 runtime -sh` #cmsenv

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
	git cms-addpkg TopQuarkAnalysis/TopHitFit
fi

#Compile everything
if $COMPILE; then
	scramv1 b -j 20
fi

cd -