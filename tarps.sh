OPTIONSTAR="--warning=no-file-changed \
  --ignore-failed-read \
  --absolute-names \
  --warning=no-file-removed"

ARCHIVEROOT="/opt/appdata/"
ARCHIVE="radarr"
PASSWORDTAR=${ARCHIVE}.tar.gz.enc
PASSWORD="TEST"

cd ${ARCHIVEROOT}
tar ${OPTIONSTAR} -cz ${ARCHIVE}/ | openssl enc -aes-256-cbc -e -pass pass:${PASSWORD} > ${ARCHIVEROOT}/${PASSWORDTAR}
