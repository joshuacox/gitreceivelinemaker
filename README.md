gitreceivelinemaker
===================

###REQUIREMENTS
docker >1.3.1

older versions of docker might work, unknown YMMV

###USAGE

Install gitreceive and make the proper key receive line for a keys repo associated with an octohost

clone this repo

place your id_ecdsa.pub in the root directory of this repo

`make key`

you will be prompted for everything else, as this is a makefile many steps will be cached by outputting a file into the current directory, remove/edit this files at will

if you have write access to our github account you will be automatically added

### notes
This is intended to be used with the keys repo for an octohost

http://octohost.io/

here is my key repo as an example:

https://github.com/WebHostingCoopTeam/keys

notice the addus.sh and octoaddus.sh scripts which might be of use to someone
