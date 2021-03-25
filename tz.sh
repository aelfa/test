timezone() {
basefolder="/opt/appdata"
TZTEST=$($(command -v timedatectl) && echo true || echo false)
TZONE=$($(command -v timedatectl) | grep "Time zone:" | awk '{print $3}')
if [[ $TZTEST != "false" ]];then
   if [[ $TZONE != "" ]];then
      if [[ -f $basefolder/compose/.env ]];then sed -i '/TZ=/d' $basefolder/compose/.env;fi
          TZ=$TZONE 
          #echo "TZ=${TZ}" >> $basefolder/compose/.env
          grep -qE 'TZ=${TZ}' $basefolder/compose/.env || \
               echo "TZ=$TZONE" >> $basefolder/compose/.env
   fi
fi
}
timezone
