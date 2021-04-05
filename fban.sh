while true; do
     f2ban=$($(command -v systemctl) is-active fail2ban | grep -qE 'active' && echo true || echo false)
     if [[ $f2ban != 'true' ]];then echo "Waiting for fail2ban to start" && sleep 1 && continue;else break;fi
done
