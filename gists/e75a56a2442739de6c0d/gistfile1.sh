
PLAY [nship] ******************************************************************

GATHERING FACTS ***************************************************************
<127.0.0.1> ESTABLISH CONNECTION FOR USER: joemccann
<127.0.0.1> REMOTE_MODULE setup
<127.0.0.1> EXEC ['ssh', '-C', '-tt', '-vvv', '-o', 'ControlMaster=auto', '-o', 'ControlPersist=60s', '-o', 'ControlPath=/Users/joemccann/.ansible/cp/ansible-ssh-%h-%p-%r', '-o', 'StrictHostKeyChecking=no', '-o', 'Port=22', '-o', 'KbdInteractiveAuthentication=no', '-o', 'PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey', '-o', 'PasswordAuthentication=no', '-o', 'ConnectTimeout=10', '127.0.0.1', "/bin/sh -c 'mkdir -p $HOME/.ansible/tmp/ansible-tmp-1425681970.52-168315940879894 && chmod a+rx $HOME/.ansible/tmp/ansible-tmp-1425681970.52-168315940879894 && echo $HOME/.ansible/tmp/ansible-tmp-1425681970.52-168315940879894'"]
fatal: [joe-mac-air] => SSH encountered an unknown error. The output was:
OpenSSH_6.2p2, OSSLShim 0.9.8r 8 Dec 2011
debug1: Reading configuration data /Users/joemccann/.ssh/config
debug1: Reading configuration data /etc/ssh_config
debug1: /etc/ssh_config line 20: Applying options for *
debug1: auto-mux: Trying existing master
debug1: Control socket "/Users/joemccann/.ansible/cp/ansible-ssh-127.0.0.1-22-joemccann" does not exist
debug2: ssh_connect: needpriv 0
debug1: Connecting to 127.0.0.1 [127.0.0.1] port 22.
debug2: fd 3 setting O_NONBLOCK
debug1: fd 3 clearing O_NONBLOCK
debug1: Connection established.
debug3: timeout: 10000 ms remain after connect
debug3: Incorrect RSA1 identifier
debug3: Could not load "/Users/joemccann/.ssh/id_rsa" as a RSA1 public key
debug1: identity file /Users/joemccann/.ssh/id_rsa type 1
debug1: identity file /Users/joemccann/.ssh/id_rsa-cert type -1
debug1: identity file /Users/joemccann/.ssh/id_dsa type -1
debug1: identity file /Users/joemccann/.ssh/id_dsa-cert type -1
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_6.2
debug1: Remote protocol version 2.0, remote software version OpenSSH_6.2
debug1: match: OpenSSH_6.2 pat OpenSSH*
debug2: fd 3 setting O_NONBLOCK
debug3: load_hostkeys: loading entries for host "127.0.0.1" from file "/Users/joemccann/.ssh/known_hosts"
debug3: load_hostkeys: found key type RSA in file /Users/joemccann/.ssh/known_hosts:17
debug3: load_hostkeys: loaded 1 keys
debug3: order_hostkeyalgs: prefer hostkeyalgs: ssh-rsa-cert-v01@openssh.com,ssh-rsa-cert-v00@openssh.com,ssh-rsa
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug2: kex_parse_kexinit: diffie-hellman-group-exchange-sha256,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
debug2: kex_parse_kexinit: ssh-rsa-cert-v01@openssh.com,ssh-rsa-cert-v00@openssh.com,ssh-rsa,ssh-dss-cert-v01@openssh.com,ssh-dss-cert-v00@openssh.com,ssh-dss
debug2: kex_parse_kexinit: aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-cbc,3des-cbc,blowfish-cbc,cast128-cbc,aes192-cbc,aes256-cbc,arcfour,rijndael-cbc@lysator.liu.se
debug2: kex_parse_kexinit: aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-cbc,3des-cbc,blowfish-cbc,cast128-cbc,aes192-cbc,aes256-cbc,arcfour,rijndael-cbc@lysator.liu.se
debug2: kex_parse_kexinit: hmac-md5-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-ripemd160-etm@openssh.com,hmac-sha1-96-etm@openssh.com,hmac-md5-96-etm@openssh.com,hmac-md5,hmac-sha1,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-ripemd160@openssh.com,hmac-sha1-96,hmac-md5-96
debug2: kex_parse_kexinit: hmac-md5-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-ripemd160-etm@openssh.com,hmac-sha1-96-etm@openssh.com,hmac-md5-96-etm@openssh.com,hmac-md5,hmac-sha1,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-ripemd160@openssh.com,hmac-sha1-96,hmac-md5-96
debug2: kex_parse_kexinit: zlib@openssh.com,zlib,none
debug2: kex_parse_kexinit: zlib@openssh.com,zlib,none
debug2: kex_parse_kexinit:
debug2: kex_parse_kexinit:
debug2: kex_parse_kexinit: first_kex_follows 0
debug2: kex_parse_kexinit: reserved 0
debug2: kex_parse_kexinit: diffie-hellman-group-exchange-sha256,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
debug2: kex_parse_kexinit: ssh-rsa,ssh-dss
debug2: kex_parse_kexinit: aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-cbc,3des-cbc,blowfish-cbc,cast128-cbc,aes192-cbc,aes256-cbc,arcfour,rijndael-cbc@lysator.liu.se
debug2: kex_parse_kexinit: aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-cbc,3des-cbc,blowfish-cbc,cast128-cbc,aes192-cbc,aes256-cbc,arcfour,rijndael-cbc@lysator.liu.se
debug2: kex_parse_kexinit: hmac-md5-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-ripemd160-etm@openssh.com,hmac-sha1-96-etm@openssh.com,hmac-md5-96-etm@openssh.com,hmac-md5,hmac-sha1,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-ripemd160@openssh.com,hmac-sha1-96,hmac-md5-96
debug2: kex_parse_kexinit: hmac-md5-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-ripemd160-etm@openssh.com,hmac-sha1-96-etm@openssh.com,hmac-md5-96-etm@openssh.com,hmac-md5,hmac-sha1,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-ripemd160@openssh.com,hmac-sha1-96,hmac-md5-96
debug2: kex_parse_kexinit: none,zlib@openssh.com
debug2: kex_parse_kexinit: none,zlib@openssh.com
debug2: kex_parse_kexinit:
debug2: kex_parse_kexinit:
debug2: kex_parse_kexinit: first_kex_follows 0
debug2: kex_parse_kexinit: reserved 0
debug2: mac_setup: found hmac-md5-etm@openssh.com
debug1: kex: server->client aes128-ctr hmac-md5-etm@openssh.com zlib@openssh.com
debug2: mac_setup: found hmac-md5-etm@openssh.com
debug1: kex: client->server aes128-ctr hmac-md5-etm@openssh.com zlib@openssh.com
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<1024<8192) sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug2: dh_gen_key: priv key bits set: 128/256
debug2: bits set: 541/1024
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Server host key: RSA a2:1f:3c:ef:63:70:6e:60:28:2a:69:a9:c0:1d:31:ac
debug3: load_hostkeys: loading entries for host "127.0.0.1" from file "/Users/joemccann/.ssh/known_hosts"
debug3: load_hostkeys: found key type RSA in file /Users/joemccann/.ssh/known_hosts:17
debug3: load_hostkeys: loaded 1 keys
debug1: Host '127.0.0.1' is known and matches the RSA host key.
debug1: Found key in /Users/joemccann/.ssh/known_hosts:17
debug2: bits set: 496/1024
debug1: ssh_rsa_verify: signature correct
debug2: kex_derive_keys
debug2: set_newkeys: mode 1
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug2: set_newkeys: mode 0
debug1: SSH2_MSG_NEWKEYS received
debug1: Roaming not allowed by server
debug1: SSH2_MSG_SERVICE_REQUEST sent
debug2: service_accept: ssh-userauth
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug2: key: /Users/joemccann/.ssh/id_rsa (0x7fad6060a680),
debug2: key: /Users/joemccann/.ssh/id_dsa (0x0),
debug1: Authentications that can continue: publickey,keyboard-interactive
debug3: start over, passed a different list publickey,keyboard-interactive
debug3: preferred gssapi-with-mic,gssapi-keyex,hostbased,publickey
debug3: authmethod_lookup publickey
debug3: remaining preferred: ,gssapi-keyex,hostbased,publickey
debug3: authmethod_is_enabled publickey
debug1: Next authentication method: publickey
debug1: Offering RSA public key: /Users/joemccann/.ssh/id_rsa
debug3: send_pubkey_test
debug2: we sent a publickey packet, wait for reply
debug1: Authentications that can continue: publickey,keyboard-interactive
debug1: Trying private key: /Users/joemccann/.ssh/id_dsa
debug3: no such identity: /Users/joemccann/.ssh/id_dsa: No such file or directory
debug2: we did not send a packet, disable method
debug1: No more authentication methods to try.
Permission denied (publickey,keyboard-interactive).


TASK: [nodesource.node | Ensure the system can use the HTTPS transport for APT] ***
FATAL: no hosts matched or all hosts have already failed -- aborting


PLAY RECAP ********************************************************************
           to retry, use: --limit @/Users/joemccann/nship.retry

joe-mac-air                : ok=0    changed=0    unreachable=1    failed=0