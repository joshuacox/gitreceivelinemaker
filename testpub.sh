#!/bin/bash
# test pub file for sanity
ISPUBGOOD=$(ssh-keygen -l -f id_rsa.pub|grep "id_rsa.pub is not a public key file")
if [[ -f "id_rsa.pub" && -z "$ISPUBGOOD" ]] ; then echo "GOOD"; else echo "You must supply an id_rsa.pub in this directory Exiting." ; fi ;
