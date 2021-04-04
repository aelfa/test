OPTIONSTAR="--warning=no-file-changed \
  --ignore-failed-read \
  --absolute-names \
  --warning=no-file-removed \
  --use-compress-program=pigz"

ARCHIVROOT="/opt/appdata/radarr"
ARCHIVE="radarr"
PASSWORDTAR=${ARCHIVE}.tar.gz.enc
PASSWORD="TEST"

cd ${ARCHIVEROOT}
tar ${OPTIONSTAR} -C ${ARCHIVE} -cf $PASSWORDTAR} ./ | openssl enc -aes-256-cbc -e -pass pass:${PASSWORD} > ${PASSWORDTAR}
