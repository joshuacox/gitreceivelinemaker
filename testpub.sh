#!/bin/bash
# test pub file for sanity
ISPUBGOOD=$(ssh-keygen -l -f id_ecdsa.pub|grep "id_ecdsa.pub is not a public key file")
if [[ -f "id_ecdsa.pub" && -z "$ISPUBGOOD" ]] ; then echo "GOOD"; else echo "You must supply an id_ecdsa.pub in this directory Exiting." ; fi ;
