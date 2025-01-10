cp TNT-icon-linux.png $HOME/gTNT 
echo cd /usr/share/applications > deskico.sh 
echo sudo touch TNT.desktop >> deskico.sh 
echo sudo desktop-file-edit \\>> deskico.sh 
echo    --set-name=\"TNT\" \\>> deskico.sh 
echo    --set-comment=\"TNT Version 1.6 with GUI\" \\>> deskico.sh 
echo    --set-icon=\"$HOME/gTNT/TNT-icon-linux.png\" \\>> deskico.sh 
echo    --add-category=\"GTK\"  \\>> deskico.sh 
echo    --set-key=\"Exec\" --set-value=\"/bin/bash $HOME/gTNT/gTNT-starter.sh\" \\>> deskico.sh 
echo    --set-key=\"Type\" --set-value=\"Application\" \\>> deskico.sh 
echo    TNT.desktop>> deskico.sh
chmod a+x deskico.sh
./deskico.sh
rm deskico.sh


