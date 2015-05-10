all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  Add your key to the basedir ./id_ecdsa.pub
	@echo "   1. make key       - build the gitreceivelinemaker image and upload the id_ecdsa.pub you have placed in this folder, will prompt for username"

testrun: testpub name repo continue replacename replacerepo catdockerfile resetrepo resetname

key: testpub name repo continue replacename replacerepo builddocker rundocker resetname resetrepo rm

continue:
	@echo ""
	@while [ -z "$$CONTINUE" ]; do \
			read -r -p "I am about to add the key id_ecdsa.pub with the username `cat name` to the webhosting.coop repository Type anything but Y or y to exit. [y/N]: " CONTINUE; \
	done ; \
	[ $$CONTINUE = "y" ] || [ $$CONTINUE = "Y" ] || (echo "Exiting."; exit 1;)
	@echo "..building image and uploading keys.."

testpub:
	@if [ -f "id_ecdsa.pub" ] ; then echo "found id_ecdsa.pub testing to ensure proper format...."; else echo "You must supply an id_ecdsa.pub in this directory Exiting." ; exit 1; fi ;
	@[ "$(shell bash testpub.sh)" = "GOOD" ] || (echo "id_ecdsa.pub is not a working pubfile. You must supply a working id_ecdsa.pub Exiting."; exit 1;)
	@echo "id_ecdsa.pub appears to be good"

# will skip over this step if the name file is left from previous run 'make clean' to remove
name:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the username you wish to associate with the id_ecdsa.pub [USERNAME]: " NAME; echo "$$NAME">>name; cat name; \
	done ;

repo:
	@while [ -z "$$REPO" ]; do \
		read -r -p "Enter the repo you wish to upload the id_ecdsa.pub [https://github.com/YOURTEAM_HERE/keys.git]: " REPO; echo "$$REPO">>repo; cat repo; \
	done ;

proxy:
		@while [ -z "$$PROXY" ]; do \
			read -r -p "Enter the address of the debian proxy you wish to use: [PROXY_HOSTNAME]" PROXY; echo "$$PROXY">>proxy; cat proxy; \
		done ;

proxyport:
		@while [ -z "$$PROXYPORT" ]; do \
			read -r -p "Enter the port of the debian proxy you wish to use [3142]: " PROXYPORT; echo "$$PROXYPORT">>proxyport; cat proxyport; \
		done ;

catdockerfile:
	cat Dockerfile
	cat proxytest

replacename:
	@sed -i "s/ENV\ TARGETUSER\ ENTER_YOUR_USERNAME_HERE/ENV\ TARGETUSER\ `cat name`/" Dockerfile

resetname:
	@sed -i "s/ENV\ TARGETUSER\ `cat name`/ENV\ TARGETUSER\ ENTER_YOUR_USERNAME_HERE/" Dockerfile

replacerepo:
	@sed -i "s/ENV\ TARGETREPO\ ENTER_YOUR_REPO_HERE/ENV\ TARGETREPO\ $(shell cat repo|sed 's/\//\\\//g')/" Dockerfile

resetrepo:
	@sed -i "s/ENV\ TARGETREPO\ $(shell cat repo|sed 's/\//\\\//g'|sed 's/\./\\./g')/ENV\ TARGETREPO\ ENTER_YOUR_REPO_HERE/" Dockerfile

replaceproxy:
	@sed -i "s/PROXY_HOST/$(shell cat proxy)/" proxytest
	@sed -i "s/PROXY_PORT/$(shell cat proxyport)/" proxytest

resetproxy:
	@sed -i "s/$(shell cat proxy)/PROXY_HOST/" proxytest
	@sed -i "s/$(shell cat proxyport)/PROXY_PORT/" proxytest

build: builddocker beep

run: rundocker beep

rundocker:
	@docker run --name=gitreceivelinemaker \
	-v ~/.ssh:/tmp/.ssh \
	--cidfile="cid" \
	-v ~/.gitconfig:/root/.gitconfig \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t gitreceivelinemaker

builddocker:
	/usr/bin/time -v docker build -t gitreceivelinemaker .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-name:
	rm  name

rm-image:
	@docker rm `cat cid`
	@rm cid

cleanfiles:
	rm name
	rm repo
	rm proxy
	rm proxyport

rm: kill rm-image

clean: cleanfiles rm

enter:
	docker exec -i -t `cat cid` /bin/bash
