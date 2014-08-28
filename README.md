setup
=====

Setup scripts

To set up bprimeKit:

	In whatever directory you want to install do:

		. setup_bprimeKit.sh [options]

	Options include:

	    CMSSW version to use, just put CMSSW_7_1_0 for example.

		"--ssh" to clone repositories using SSH rather than HTTPS. 
			Mostly useful if you'll be contributing code. 
			May want to use ssh-agent so you don't have to keep entering your key password.

		"--hitfit" to include HitFit related packages.

		"--no-compile" to not immediately compile the code