#! /bin/bash
################################################################################
# Auditory pathway processing pipline 
################################################################################

if [ $# -ne 1 ]; then
  "usage: $(basename $0) subject_dir"
  exit 1
fi

workflow=$(cd $(dirname ${0}); cd ..; pwd -P)
subject=$1

qitdiff \
  --subject ${subject} \
  --make ${workflow}/data/Makefile \
  $(cat ${workflow}/data/targets.txt)

################################################################################
# END
################################################################################
