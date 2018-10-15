# check linux
function shlibCheckLinux() {
  if [ "$(uname)" != "Linux" ]; then
      echo "this script supports linux only"
      exit
  fi
}

# sw_vers -productVersion
function shlibGetDistName() {
  return "";
}

function shlibGetDistVer() {
  return "";
}

# check ubuntu 14/16
function shlibCheckUbuntu_14_16() {
  SYSTEM_VERSION_STR=$(cat /etc/issue)
  if [$SYSTEM_VERSION_STR == ""]; then
    echo "this script supports ubuntu 14/16 only"
    exit
  fi
  if [ "$(echo ${SYSTEM_VERSION_STR:0:9})" == "Ubuntu 14" ]; then
    echo "Ubuntu 14 found"
  elif [ "$(echo ${SYSTEM_VERSION_STR:0:9})" == "Ubuntu 16" ]; then
    echo "Ubuntu 16 found"
  else
    echo "this script supports ubuntu 14/16 only"
    exit
  fi
}

function shlibCheckRoot() {
  if [ `id -u` -ne 0 ]; then
    echo "need root, try with sudo again"
    exit
  fi
}
