
OPERATION=$1
ARCHIVE=$2
REMOTE=$3

OPTIONSTAR="--warning=no-file-changed \
  --ignore-failed-read \
  --absolute-names \
  --warning=no-file-removed \
  --exclude-from=/backup_excludes \
  --use-compress-program=pigz"

OPERATION=${OPERATION}
ARCHIVE=${ARCHIVE}
ARCHIVETAR=${ARCHIVE}.tar.gz

   echo "RUN TAR for ${ARCHIVE}"
   cd /${OPERATION}/${ARCHIVE}
        for dir_tar in `find . -maxdepth 1 -type d | grep -v "^\.$" `; do
            tar ${OPTIONSTAR} -C ${ARCHIVE} -cvf ${ARCHIVETAR} ./
        done
