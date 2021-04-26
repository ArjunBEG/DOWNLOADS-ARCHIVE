# Git Signing with a GUI Application (e.g. Tower or Github)

## Manually Installed GPG

### Step 1: Modify ~/.gnupg/gpg-agent.conf

    use-standard-socket
    pinentry-program /usr/local/bin/pinentry-mac
    enable-ssh-support
    
### Step 2: Modify ~/.gnupg/gpg.conf

    use-agent
    no-tty

## Step 3: Copy startup-gpg-agent.sh to ~/bin/
Copy the .sh file in this gist to `~/bin/`.

## Step 4: Copy org.gnupg.gpg-agent.plist file to ~/Library/LaunchAgents/
Copy the the plist file in this Gist to `~/Library/LaunchAgents/`.

## Using Krypt.co

## Step 1: Copy startup-gpg-agent.sh to ~/bin/
Copy the .sh file in this gist to `~/bin/`.

## Step 2: Copy org.gnupg.gpg-agent.plist file to ~/Library/LaunchAgents/
Copy the the plist file in this Gist to `~/Library/LaunchAgents/`.