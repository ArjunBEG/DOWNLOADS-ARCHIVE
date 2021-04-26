
update_terraform() {
  version=$1

  echo "[+] updating terraform to $version"
  curl -# -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/$version/terraform_${version}_darwin_amd64.zip

  echo "[+] unzipping archive"
  unzip /tmp/terraform.zip -d /tmp/terraform

  current=$(dirname $(which terraform))
  echo "[+] installing to $current"
  cp -fr /tmp/terraform/* $current
  
  echo "[+] updated to $version"
}
