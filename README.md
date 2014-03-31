setup
=====

Setup scripts

To set up bprimeKit:
	In whatever directory you want to install do:
		. setup_bprimeKit.sh [options]
	Options include 
		"--ssh" to clone repositories using SSH rather than HTTPS. 
			Mostly useful if you'll be contributing code. 
			May want to use ssh-agent so you don't have to keep entering your key password.
		"--hitfit" to include HitFit related packages.