#!/usr/bin/env bash
# author: deadc0de6 (https://github.com/deadc0de6)
# Copyright (c) 2017, deadc0de6
#
# test global ignore update
# returns 1 in case of error
#

# exit on first error
set -e

# all this crap to get current path
rl="readlink -f"
if ! ${rl} "${0}" >/dev/null 2>&1; then
  rl="realpath"

  if ! hash ${rl}; then
    echo "\"${rl}\" not found !" && exit 1
  fi
fi
cur=$(dirname "$(${rl} "${0}")")

#hash dotdrop >/dev/null 2>&1
#[ "$?" != "0" ] && echo "install dotdrop to run tests" && exit 1

#echo "called with ${1}"

# dotdrop path can be pass as argument
ddpath="${cur}/../"
[ "${1}" != "" ] && ddpath="${1}"
[ ! -d ${ddpath} ] && echo "ddpath \"${ddpath}\" is not a directory" && exit 1

export PYTHONPATH="${ddpath}:${PYTHONPATH}"
bin="python3 -m dotdrop.dotdrop"
hash coverage 2>/dev/null && bin="coverage run -a --source=dotdrop -m dotdrop.dotdrop" || true

echo "dotdrop path: ${ddpath}"
echo "pythonpath: ${PYTHONPATH}"

# get the helpers
source ${cur}/helpers

echo -e "$(tput setaf 6)==> RUNNING $(basename $BASH_SOURCE) <==$(tput sgr0)"

################################################################
# this is the test
################################################################

# dotdrop directory
tmps=`mktemp -d --suffix='-dotdrop-tests' || mktemp -d`
dt="${tmps}/dotfiles"
mkdir -p ${dt}
mkdir -p ${dt}/a/{b,c}
echo 'a' > ${dt}/a/b/abfile
echo 'a' > ${dt}/a/c/acfile

# fs dotfiles
tmpd=`mktemp -d --suffix='-dotdrop-tests' || mktemp -d`
cp -r ${dt}/a ${tmpd}/

clear_on_exit "${tmps}"
clear_on_exit "${tmpd}"

# create the config file
cfg="${tmps}/config.yaml"
cat > ${cfg} << _EOF
config:
  backup: false
  create: true
  dotpath: dotfiles
  upignore:
  - "*/cfile"
  - "*/newfile"
  - "*/newdir"
dotfiles:
  f_abc:
    dst: ${tmpd}/a
    src: a
profiles:
  p1:
    dotfiles:
    - f_abc
_EOF
#cat ${cfg}

#tree ${dt}

# edit/add files
echo "[+] edit/add files"
touch ${tmpd}/a/newfile
echo 'b' > ${tmpd}/a/c/acfile
mkdir -p ${tmpd}/a/newdir/b
touch ${tmpd}/a/newdir/b/c

#tree ${tmpd}/a

# update
echo "[+] update"
cd ${ddpath} | ${bin} update -f -c ${cfg} --verbose --profile=p1 --key f_abc

#tree ${dt}

# check files haven't been updated
[ ! -e ${dt}/a/c/acfile ] && echo "acfile not found" && exit 1
set +e
grep 'b' ${dt}/a/c/acfile || (echo "acfile not updated" && exit 1)
set -e
[ -e ${dt}/a/newfile ] && echo "newfile found" && exit 1

echo "OK"
exit 0
