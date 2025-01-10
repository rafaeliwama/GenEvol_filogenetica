#!/bin/bash

# KEEP INITIAL DIRECTORY IN CASE WE WANT TO RETURN HERE -- THIS SHOULD BE ./TNT-files!!!
SRCDIR=$PWD

# CHECK THE OS
if [[ $OSTYPE == darwin* ]] ; then 
    export OSYS=DARWIN ; 
elif [[ $OSTYPE == linux* ]] ; then 
    export OSYS=LINUX64 ;
else  
    echo \ ;
    echo \  This installer only works for ;
    echo \  MacOS and Linux. Cannot do an ;
    echo \  installation for \"$OSTYPE\". ;
    echo \ ; 
    echo \  So sorry. ;
    echo \ ;
    read NOTHING;
    exit ; 
fi 

# CHECK THE SHELL
MYSHELL=NOTOK;
if [[ $SHELL == /bin/bash ]] ; then MYSHELL=OK; fi 
if [[ $SHELL == /bin/zsh ]] ; then MYSHELL=OK; fi 
if [[ $MYSHELL != OK ]] ; then
    echo \ ;
    echo \  This installer only works with shells ;
    echo \  \"bash\" or \"zsh\". Your machine uses ;
    echo \  shell \"$SHELL\". If you have \"bash\" or;
    echo \  \"zsh\" in your system, run the script ;
    echo \  with either of them.; 
    echo \ ; 
    echo \  The installer will now exit.
    echo \ ;
    echo \  So sorry ;
    echo \ ;
    read NOTHING ;
    exit ; 
fi

# FIRST, CHECK FOR SANITY OF .TNT_GUISTORY FILE (it must have 85 bytes!)
cd $HOME ;
GUISTORYSIZE=$(wc -c .tnt_guistory);
if [[ -f .tnt_guistory ]] ; then 
  if (( ${GUISTORYSIZE:0: -13} != 85 )) ; then
      echo \ ;
      echo \  Please note\! ;
      echo \ ; 
      echo \  Installing this update will reset most ;
      echo \  program values \(i.e. the file ;
      echo \  \".tnt_guistory\" is obsolete\; new;
      echo \  versions use a different format\);
      echo \ ;
      echo \  \(press \<enter\> to continue\);
      read NOTHING;
      rm .tnt_guistory ; 
   fi 
fi

# BACK TO SOURCE DIRECTORY    
cd $SRCDIR 
    
# TWO UTILITY FUNCTIONS
function rectang() {
	 echo \ ; 
	 echo \   -------------------- ; 
	 echo \ \| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| ; 
	 echo \   -------------------- ; 
	 echo \ ;
}
function getanswer() {
    clear ; 
    echo \ ;
    echo \  Drag the folder for which you want to create ;
    echo \  a shortcut onto the square below, and then ; 
    echo \  type \<enter\>:; 
    rectang ; 
    read INTMD;
    if [[ ${INTMD: -1} == \' ]] ; then
        SHORTGT=${INTMD:1: -1};
    else SHORTGT=$INTMD; fi 
    echo \ ;
    echo \  Now, type the name you want to give the shortcut ;
    echo \  \(e.g. TNT_FILES\), then press \<enter\>:
    echo \ ;
    read SHORNAME;
    clear ; 
} 

# CREATING DIRS, IF NEEDED 
echo \ ; 
if [ -d $HOME/pvm3 ] ; then
    echo \  PVM directory is created already ;
    echo \ ; 
else
    echo Creating PVM directory \(and subdirectories\) ; 
    echo \ ; 
    mkdir $HOME/pvm3 ;
    mkdir $HOME/pvm3/bin ; 
    mkdir $HOME/pvm3/lib ;
    mkdir $HOME/pvm3/bin/$OSYS;
    mkdir $HOME/pvm3/lib/$OSYS;
fi 
mkdir $HOME/gTNT ; 

# REMOVE FILES FIRST, MACOS DOESN'T LIKE OVERWRITTEN BINARIES
rm $HOME/gTNT/gTNT ;
rm $HOME/gTNT/tnt ;
rm $HOME/pvm3/bin/$OSYS/tnt ;
rm $HOME/pvm3/lib/$OSYS/pvm ;
rm $HOME/pvm3/lib/$OSYS/pvmd3 ;
rm $HOME/gTNT/gTNT-starter.sh ;
rm $HOME/gTNT/cTNT-starter.sh ;

# NEEDED FOR THE GNOME DESKTOP ICON TO RUN GTNT PROPERLY
if [[ $OSTYPE == linux* ]] ; then 
    echo export PVM_ROOT=$HOME/pvm3>gTNT-starter.sh ;
    cat gTNT-starter.bas >> gTNT-starter.sh ;
else
    cp gTNT-starter.bas gTNT-starter.sh ;
fi

# MAKE SURE THE SCRIPTS ARE EXECUTABLE (BIN FILES THEMSELVES SHOULD BE)
chmod a+x gTNT-starter.sh
chmod a+x cTNT-starter.sh
if [[ $OSTYPE == darwin* ]] ; then 
    chmod a+x gTNT.command ; 
    chmod a+x cTNT.command ;
fi 

# NOW, COPY THE NEW FILES
echo ----------------------- ; 
echo From $PWD ; 
cp ../TNT-bin/gTNT $HOME/gTNT ;
cp ../TNT-bin/tnt $HOME/gTNT ;
cp ../TNT-bin/tnt $HOME/pvm3/bin/$OSYS ;
cp ../TNT-bin/pvm $HOME/pvm3/lib/$OSYS ;
cp ../TNT-bin/pvmd3 $HOME/pvm3/lib/$OSYS ;
cp ./gTNT-starter.sh $HOME/gTNT ;
cp ./cTNT-starter.sh $HOME/gTNT ;

if [[ $OSTYPE == linux* ]] ; then 
    cp ../TNT-bin/libncurses.so.5 $HOME/gTNT ;
    cp ../TNT-bin/libreadline.so.7 $HOME/gTNT ;
    cp ../TNT-bin/libtinfo.so.5 $HOME/gTNT ;
    cp ../TNT-bin/libncurses.so.5 $HOME/pvm3/bin/$OSYS ;
    cp ../TNT-bin/libreadline.so.7 $HOME/pvm3/bin/$OSYS ;
    cp ../TNT-bin/libtinfo.so.5 $HOME/pvm3/bin/$OSYS ;
fi 
    
if [[ $OSTYPE == darwin* ]] ; then 
    rm $HOME/gTNT/gTNT.command ;
    cp ./gTNT.command $HOME/gTNT ;
    rm $HOME/gTNT/cTNT.command ;
    cp ./cTNT.command $HOME/gTNT ;
    if [[ -d $HOME/Desktop ]] ; then
	cp ./gTNT.command $HOME/Desktop/RUNTNT ;
    else
	echo \  ------------------------------- ; 
	echo \  Can\'t create desktop icon: ;
	echo \  \  \  No path to \"Desktop\" ;
	echo \ ; 
    fi 
else
    echo \ ;
    echo \  -------------------------------------------;
    echo \  The binary files for TNT are in the folder:
    echo \ ; 
    echo \  \  \  \ $HOME/gTNT ;
    echo \ ;
    echo \  You can start the GUI TNT with the ;
    echo \  script \"gTNT-starter\", which also ;
    echo \  launches the PVM daemon, if needed.;
    echo \  The script \"cTNT-starter\" starts the;
    echo \  command-driven version of TNT instead,;
    echo \  also starting the PVM daemon automatically; 
    echo \ ;
    echo \ \(type \<enter\> to continue\>\); 
    read NOTHING; 
fi

# MESSAGING 
echo \ ;
echo \  -------------------------------------------;
echo \  The installer creates aliases, \"runTNT\" and ;
echo \  \"runtnt\" \(for the GUI and command-driven ;
echo \  versions, respectively\). These refer to the ;
echo \  TNT scripts in $HOME/gTNT, and also ;
echo \  take care of automatically initiating the PVM;
echo \  system if it\'s not running. If you open a;
echo \  terminal, you can run TNT from anywhere with;
echo \  these aliases.
echo \ ; 
echo \ \(press \<enter\> to continue\); 
read NOTHING; 
echo \ ; 
echo \  The installer also creates an alias for ;
echo \  easier handling of PVM, called \"PVM\".;
echo \  You can run it with options \"init\", \"halt\",;
echo \  and \"reset\" \(kills TNT processes, leaves ;
echo \  PVM daemon still running\). 
echo \ ; 
echo \ \(press \<enter\> to continue\); 
read NOTHING; 

# COPY DOCUMENTATION AND DATASETS
cd ..
echo \ ; 
echo \  ---------------------------------------- ; 
echo \  Some more copying... from $PWD ;
echo \ ; 
mkdir $HOME/gTNT/Datasets ; 
cp ./TNT-Docs_n_Datasets/* $HOME/gTNT/Datasets ; 
# DEFAULT SYMLINK FOR EASIER ACCESS TO $HOME/gTNT/Datasets 
if [[ ! -f $HOME/TNT_DATASETS ]] ; then 
   ln -s $HOME/gTNT/Datasets $HOME/TNT_DATASETS ; 
echo \ ; 
fi

# WARN ABOUT THE NEED TO GIVE PERMISSION
echo \  ------------------------------------------ ;
echo \  Some of the operations to perform require ; 
echo \  root permission. The TNT installer will ;
echo \  query you for the root password if needed.;
echo \ ;
echo \  \(type \<enter\> to continue\); 

# DESKTOP ICON FOR GNOME
if [[ $OSTYPE == linux* ]] ; then
   cd $SRCDIR ; 
   ./prepdeskico.sh ; 
fi 

# SET MAN PAGE
echo \  ;
echo \  ----------------------------------------------- ;
echo \  Do you wish to install the \"TNT\" man page? ;
echo \  This provides info on usage, files, etc. ; 
echo \  ;
echo \  If you wish to install the \"TNT\" man page, ;
echo \  enter \"y\".;
echo \  \(any other response skips installation\):
echo \ ;
read WANTS; 
if [[ $WANTS == [yY] ]] ; then 
  cd $SRCDIR ;
  if [[ $OSTYPE == darwin* ]] ; then
     sudo mkdir /usr/local/share 2> /dev/null ; 
     sudo mkdir /usr/local/share/man 2> /dev/null ;  
     sudo mkdir /usr/local/share/man/man1 2> /dev/null ;  
     sudo rm /usr/local/share/man/man1/TNT.1.gz 2> /dev/null ;  
     sudo install -g 0 -o 0 -m 0644 TNT.1 /usr/local/share/man/man1; 
     sudo gzip /usr/local/share/man/man1/TNT.1; 
  else
     sudo mkdir /usr/local/man 2> /dev/null ;
     sudo mkdir /usr/local/man/man1 2> /dev/null ; 
     sudo rm /usr/local/man/man1/TNT.1.gz 2> /dev/null ;  
     sudo install -g 0 -o 0 -m 0644 TNT.1 /usr/local/man/man1 2> /dev/null ;  
     sudo gzip /usr/local/man/man1/TNT.1;
  fi
fi 

# USER-PERSONALIZED SYMLINKS
echo \ ; 
echo \  ------------------------------------------------------ ; 
echo \  The installer has created a \"TNT_DATASET\" shortcut ; 
echo \  in your HOME directory \(\"$HOME\"\).
echo \ ;
echo \  This shortcut makes it easier for the TNT GUI ;
echo \  to access the folder \"$HOME/gTNT/Datasets\",
echo \  which contains example datasets \(and other docs\).
echo \ ;     
echo \  You can also create more shortcuts to other folders ;
echo \  where you keep your own datasets. If you wish to create ;
echo \  more shortcuts, enter \"y\":; 
echo \ ; 
read MORESHORS; 

cd $HOME ;
while [[ $MORESHORS == [yY] ]] ; do
    getanswer ;
    if [[ -d $SHORTGT ]] ; then 
       echo \ ; 
       echo \  Please confirm\! ;
       echo \ ; 
       echo \  You will create a shortcut \(\"symlink\"\) named:;
       echo \  ;
       echo \  \  \  \  $SHORNAME ;
       echo \  ;
       echo \  for easily accessing the folder\:;
       echo \  ;
       echo \  \  \  \  $SHORTGT ;
       echo \  ;
       echo \ If this looks correct, enter \"y\":;
       read ISOKA;
       if [[ $ISOKA == [yY] ]] ; then
           unlink $SHORNAME 2> /dev/null ; 
	   ln -s $SHORTGT $SHORNAME ;
       fi
       clear ;
    else 
	echo \ ;
	echo \  $SHORTGT is not a directory\! ;
	echo \  You cannot create shortcuts to files ;
	echo \  or non existing directories... ;
	echo \ ;
	echo \ \(\<enter\> to continue\);
	read NOTHING;
	clear; 
    fi 
    echo \ ; 
    echo \  Do you wish to create another shortcut? ;
    echo \ ; 
    echo \  \(enter \"y\" or \"n\"\);
    echo \ ; 
    read MORESHORS;
done

# BASH OR ZSHELL ??  
GOESIN=$HOME/.bashrc
if [[ $SHELL == /bin/zsh ]] ; then GOESIN=$HOME/.zshrc; fi
TNT_IS_INSTALLED=no; 
if grep GTNT_IS_INSTALLED $GOESIN > /dev/null ; then TNT_IS_INSTALLED=yes; fi
echo \ ; 
echo \  -------------------------------------------------------------; 
if [[ $TNT_IS_INSTALLED == yes ]] ; then 
    echo \  Environment variables for TNT are set already ;
    echo \  \(no need to modify your environment\);
else
    echo \  N.B. The TNT installer needs to add definition of some ;
    echo \  environment variables to your $GOESIN file ;
    if [[ $SHELL == /bin/zsh ]] ; then
	echo \  and your $HOME/.zprofile file ;
    fi
    echo \ ; 
    echo \  These changes will be marked, in case you want to undo them;
    echo \ ;
    echo \  \(type \<enter\> to continue\);
    read NOTHING;
    cd $SRCDIR ;     
    cat .defines >> $GOESIN ;
    if [[ $SHELL == /bin/zsh ]] ; then
	cat .defines >> $HOME/.zprofile ;
    fi
fi

if [[ $OSTYPE == darwin* ]] ; then
    cd $SRCDIR ; 
    $SHELL autochk_init.sh ;
    if [[ -f init_file_failed ]] ; then 
       cd $SRCDIR;     
       echo \ ;
       echo \  ------------------------------------------------------ ; 
       echo \  Please note: it seems that the initialization file ;
       echo \  for the Terminal is not being parsed on startup. ;
       echo \  This is needed for TNT to work properly. ;
       echo \ ;
       echo \  You can change the settings so that Terminal is ;
       echo \  initialized automatically. For this, you need to ;
       echo \  modify the options for \"Terminal\". Open a terminal,;
       echo \  go to \"Preferences\", then \"Profiles\", and \"Shell\".;
       if [[ $SHELL == /bin/bash ]] ; then 
            echo \  In \"Startup\" \> \"Run command\", type \"source .bashrc\".;
       else echo \  In \"Startup\" \> \"Run command\", type \"source .zprofile\".; fi 
       echo \ ;
       echo \  \  \  \(you can check the figure that ;
       echo \  \  \   opens after pressing \<enter\>\) ;
       read NOTHING;
       chmod a+x mostratruco.sh ; 
       ./mostratruco.sh ;
    fi 
fi 

if [[ $OSTYPE == darwin* ]] ; then  
    FONTDIR=/Library/Fonts;  
else FONTDIR=/usr/share/fonts; fi 
echo \ ;
echo \  ------------------------------------------------------ ; 
if [[ -f $FONTDIR/Tred.ttf ]] ; then 
    echo \  The font \"Tred\" is installed already... ;
    echo \ ; 
else
    echo \  The installer needs to copy the \"Tred\" font to the ;
    echo \  system fonts directory \($FONTDIR\). ;
    echo \ ; 
    echo \  You will need to give permission for this, and the ; 
    echo \  font database will need to be updated \(which may ;
    echo \  take a minute or so\);
    echo \ ; 
    echo \  Press \<enter\> to continue... ; 
    read NOTHING; 
    cd $SRCDIR ; 
    sudo cp ../TNT-Docs_n_Datasets/Tred.ttf $FONTDIR ;
    sudo chmod 664  $FONTDIR/Tred.ttf ; 
    fc-cache -f -v 
fi 
    
echo \ ; 
echo \  -------------------------------------------------; 
echo \  Installation of the new version is now complete\!;
echo \ ;
if [[ $OSTYPE == linux* ]] ; then
    echo \ ;
    echo \  You should have a \"TNT\" icon in your Desktop ;
    echo \ ;  
fi
echo \  N.B. you may need to restart your computer for ;
echo \  \  \  \ all changes to take place systemwide. ;
echo \ ;
echo \  \(press \<enter\> to finish, and then close;
echo \  this terminal if it doesn\t close by itself\);
read NOTHING ;
