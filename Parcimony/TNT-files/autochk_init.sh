###### Make sure the init file is parsed ############
#    (this needs to be done on a separate file      #
#     to be loaded on a new bash or zsh instance)   #
touch init_file_failed ; 
if [[ $GTNT_IS_INSTALLED == yes ]] ; then
    rm init_file_failed ; 
fi

