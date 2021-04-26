#!/bin/bash
#
# Reference: http://superuser.com/questions/929566/sha256-ssh-fingerprint-given-by-the-client-but-only-md5-fingerprint-known-for-se
#

# standard sshd config path
SSHD_CONFIG=/etc/ssh/sshd_config

# helper functions
function tablize { 
        awk '{printf("| %-7s | %-7s | %-47s |\n", $1, $2, $3)}'
}
LINE="+---------+---------+-------------------------------------------------+"

# header
echo $LINE
echo "Cipher" "Algo" "Fingerprint" | tablize
echo $LINE

# fingerprints
for host_key in $(awk '/^HostKey/ {sub(/^HostKey\s+/,"");print $0".pub"};' $SSHD_CONFIG); do
        cipher=$(echo $host_key | sed -r 's/^.*ssh_host_([^_]+)_key\.pub$/\1/'| tr '[a-z]' '[A-Z]')
        if [[ -f "$host_key" ]]; then
                md5=$(ssh-keygen -l -f $host_key | awk '{print $2}')
                sha256=$(awk '{print $2}' $host_key | base64 -d | sha256sum -b | awk '{print $1}' | xxd -r -p | base64)

                echo $cipher MD5 $md5 | tablize
                echo $cipher SHA-256 $sha256 | tablize
                echo $LINE
        fi
done
