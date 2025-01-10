#!/bin/bash
BIN="gTNT"
DEST="$HOME/gTNT"

export PAZ=$0 ;
if [[ $OSTYPE == darwin* ]] ; then
   let chk=${#PAZ} ;
   ISOK=yes;  
   if (( $chk < 22 )) ; then ISOK=no ; fi 
   let chk=${#PAZ}-22 ;
   if [[ $ISOK == yes ]] ; then 
       if [ ${PAZ:$chk} != /TNT_installer.command ] ; then ISOK=no ; fi
       fi 
   if [[ $ISOK == no ]] ; then 
      echo Sorry, you cannot rename the installation file ;
      echo It must be named as \"TNT_installer.command\"\! ;
      read NOTHING;
      exit ; fi
   if [[ $SHELL == /bin/bash ]]; then
       echo \  -------------------------------------- ; 
       echo \  Please Note\!\!;
       echo \  The installer may need to install or ;
       echo \  update some programs \(brew, GTK\).;
       echo \  This may take a LONG time in your ;
       echo \  operating system \(hours\!\). If you ;
       echo \  really want to install now, enter ;
       echo \  \"y\" \(if you want to just leave the;
       echo \  installation for later, \<enter\> will;
       echo \  suffice, exitting the installer\).;
       echo \  -------------------------------------- ; 
       echo \ ;
       read CONFIRM;
       if [[ $CONFIRM != [yY] ]] ; then return ; fi
       fi 
else
   let chk=${#PAZ};
   ISOK=yes;  
   if (( $chk < 17 )) ; then ISOK=no ; fi 
   let chk=${#PAZ}-17 ;
   if [[ $ISOK == yes ]] ; then 
       if [ ${PAZ:$chk} != /TNT_installer.sh ] ; then ISOK=no ; fi
       fi
   if [ $ISOK == no ] ; then
      echo Sorry, you cannot rename the installation file ;
      echo It must be named as \"TNT_installer.sh\"\! ;
      read NOTHING;
      exit ; fi
   fi

chomp() {
    printf "%s" "${1/"$'\n'"/}"
}

# string formatters
if [[ -t 1 ]]
then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_yellow="$(tty_mkbold 33)"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_reset="$(tty_escape 0)"

# Search for the given executable in PATH (avoids a dependency on the `which` command)
which() {
  # Alias to Bash built-in command `type -P`
  type -P "$@"
}

abort() {
    printf "${tty_red}%s${tty_reset}\n" "$@" >&2
    exit 1
}
warn() {
    printf "${tty_yellow}Warning${tty_reset}: %s\n" "$(chomp "$1")"
}

msg() {
    printf "${tty_blue}%s${tty_reset} %s\n" "$(chomp "$1")"
}

brewPath(){
	if [[ -n "${ON_MACOS-}" ]]
	then
	  UNAME_MACHINE="$(/usr/bin/uname -m)"

	  if [[ "${UNAME_MACHINE}" == "arm64" ]]
	  then
	    # On ARM macOS
	    HOMEBREW_PREFIX="/opt/homebrew"
	  else
	    # On Intel macOS
	    HOMEBREW_PREFIX="/usr/local"
	  fi
	else
	  # On Linux
	  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
	fi
	case "${SHELL}" in
	  */bash*)
	    if [[ -r "${HOME}/.bash_profile" ]]
	    then
	      shell_profile="${HOME}/.bash_profile"
	    else
	      shell_profile="${HOME}/.profile"
	    fi
	    ;;
	  */zsh*)
	    shell_profile="${HOME}/.zprofile"
	    ;;
	  *)
	    shell_profile="${HOME}/.profile"
	    ;;
	esac
	# `which` is a shell function defined above.
	# shellcheck disable=SC2230
	if [[ "$(which brew)" != "${HOMEBREW_PREFIX}/bin/brew" ]]
	then
	    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ${shell_profile}
            echo "export PATH=\"${HOMEBREW_PREFIX}/bin/:$PATH\"" >> ${shell_profile}
            export PATH="${HOMEBREW_PREFIX}/bin/:$PATH"
	fi
}

copyFiles(){
if [[ $OSTYPE == darwin* ]] ; then
   let val=${#PAZ}-22 ;
else
   let val=${#PAZ}-17 ;
fi
cd ${PAZ:0:$val} ;
cd TNT-files
echo \ ;
echo \  Now entering directory $PWD ;
echo \  to copy actual TNT files...;
echo \ ;
echo \ \(press \<enter\> to continue\) ;
read NOTHING; 
./proceed.sh ;
}

if [ -z "${BASH_VERSION:-}" ]
then
    abort "Bash is required to run this script."
fi

[[ "${EUID:-${UID}}" != "0" ]] || abort "Please, don't run this installer as root."

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
    ON_LINUX=1
elif [[ "${OS}" == "Darwin" ]]
then
    ON_MACOS=1
else
    abort "Homebrew is only supported on macOS and Linux."
fi

#udpate?
if [ -f "$DEST/$BIN" ]
then
    echo "Updating TNT..."
    UPDATE=1
else 
    echo "Installing TNT..."
    INSTALL=1
fi

if [ $UPDATE ]
then
    copyFiles
    exit 1
fi

#install?
if [[ $ON_LINUX && $INSTALL ]]
then
    echo "OS: Linux"
    if /sbin/ldconfig -p | grep libgtk-3 &> /dev/null
    then 
        echo "GTK+3 is already installed"
        copyFiles
        exit 1
    else
        echo "GTK+3 is not installed"
    fi
else
    echo "OS: MacOS"
fi

if ! command -v brew &> /dev/null
then
    warn "Brew could not be found. Installing it..."
    if ! command -v curl &> /dev/null
    then
        if [[ $ON_LINUX ]]
        then
            warn "Curl could not be found. Trying to install it..."
            if ! sudo apt-get -y install curl
            then
                abort "Cannot install curl"
            fi
        else
            abort "Sorry, you have to install curl"
        fi
    else
        echo "Curl is already installed."
    fi
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    then
        abort "Cannot install Brew"
    fi
else
    echo "Brew is already installed!"
fi

#include brew into PATH if needed
brewPath

echo "Installing TNT dependencies..."
brew install gtk+3 adwaita-icon-theme
if ! brew list gtk+3 &>/dev/null
then
    abort "Cannot install gtk+3. Please, try again."
else
    msg "TNT dependencies OK!"
    copyFiles		
fi

