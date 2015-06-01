client-install:
	ssh-keygen -f $HOME/.ssh/pi_backup_rsa -t rsa -N '' && ssh-add $HOME/.ssh/pi_backup_rsa
	cp --no-clobber sample-config config
