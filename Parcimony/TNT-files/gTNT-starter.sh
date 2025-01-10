TOREAD=$1 
OSYS=LINUX64;
if [[ $OSTYPE == darwin* ]] ; then
    OSYS=DARWIN; 
    if [ z$1 != zxaty76743qw ] ; then
      echo THIS SCRIPT IS NOT TO BE RUN DIRECTLY ;
      echo \(ONLY VIA gTNT.command\) ;
      echo \ ;
      echo ...press enter to continue... ;
      read NOTHING ;
      clear ; 
      exit ; fi
    TOREAD=$2 ;
fi  
echo -n X> $HOME/.tmpa ; 
pgrep pvmd3 >> $HOME/.tmpa ; 
read ZUL<$HOME/.tmpa ; 
rm $HOME/.tmpa ; 
if [[ $ZUL == X ]] ; then  
   echo > $HOME/.nothing ; echo >> $HOME/.nothing ;
   rm /tmp/pvml.$EUID ;
   echo INITIATING PVM DAEMON ;
   $PVM_ROOT/lib/$OSYS/pvmd3 $PVM_HOSTLIST 2> /dev/null < $HOME/.nothing &
   rm $HOME/.nothing ;
else echo PVM DAEMON IS RUNNING ALREADY ; fi
$HOME/gTNT/gTNT $TOREAD 
