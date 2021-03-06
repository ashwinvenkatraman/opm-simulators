#!/bin/bash

OPM_DATA_ROOT=$1

# Copy results from a test run to refence dir
# $1 = source directory to copy data from
# $2 = destination directory to copy data to
# $3 = base file name for files to copy
# $4...$@ = file types to copy
copyToReferenceDir () {
  SRC_DIR=$1
  DST_DIR=$2;
  STEM=$3;
  FILETYPES=${@:4};
  mkdir -p $DST_DIR

  for filetype in $FILETYPES; do
    cp "$WORKSPACE/$SRC_DIR$STEM.$filetype" $DST_DIR
  done
}

tests=${@:2}
test -z "$tests" && tests="spe11 spe12 spe12p spe1oilgas spe1nowells spe3 spe5 spe9 norne_init msw_2d_h msw_3d_hfa polymer2d spe9group polymer_oilwater"
if grep -q -i "norne " <<< $ghprbCommentBody
then
  if test -d $WORKSPACE/deps/opm-data/norne/flow
  then
    tests="$tests norne_full"
  fi
fi

echo $tests

for test_name in ${tests}; do
  if grep -q "spe11" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow_sequential+spe1/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow_sequential \
      SPE1CASE1 \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe12" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow_legacy+spe1/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow_legacy \
      SPE1CASE2 \
      EGRID INIT SMSPEC UNRST UNSMRY

    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe1/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow \
      SPE1CASE2 \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe12p" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe1_2p/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow \
      SPE1CASE2_2P \
      EGRID INIT SMSPEC UNRST UNSMRY

    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow_legacy+spe1_2p/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow_legacy \
      SPE1CASE2_2P \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe1oilgas" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe1_oilgas/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow \
      SPE1CASE2_OILGAS \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe1nowells" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe1_nowells/ \
      $OPM_DATA_ROOT/spe1/opm-simulation-reference/flow \
      SPE1CASE2_NOWELLS \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "msw_2d_h" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+msw_2d_h/ \
      $OPM_DATA_ROOT/msw_2d_h/opm-simulation-reference/flow \
      2D_H__ \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "msw_3d_hfa" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+msw_3d_hfa/ \
      $OPM_DATA_ROOT/msw_3d_hfa/opm-simulation-reference/flow \
      3D_MSW \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "polymer_oilwater" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+polymer_oilwater/ \
      $OPM_DATA_ROOT/polymer_oilwater/opm-simulation-reference/flow \
      2D_OILWATER_POLYMER \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "polymer2d" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+polymer_simple2D/ \
      $OPM_DATA_ROOT/polymer_simple2D/opm-simulation-reference/flow \
      2D_THREEPHASE_POLY_HETER    \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe3" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow_legacy+spe3/ \
      $OPM_DATA_ROOT/spe3/opm-simulation-reference/flow_legacy \
      SPE3CASE1 \
      EGRID INIT PRT SMSPEC UNRST UNSMRY

    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe3/ \
      $OPM_DATA_ROOT/spe3/opm-simulation-reference/flow \
      SPE3CASE1 \
      EGRID INIT PRT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe5" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe5/ \
      $OPM_DATA_ROOT/spe5/opm-simulation-reference/flow \
      SPE5CASE1    \
      EGRID INIT SMSPEC UNRST UNSMRY
  fi

  if grep -q "spe9group" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe9group/ \
      $OPM_DATA_ROOT/spe9group/opm-simulation-reference/flow \
      SPE9_CP_GROUP \
      EGRID INIT PRT SMSPEC UNRST UNSMRY
  elif grep -q "spe9" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow+spe9/ \
      $OPM_DATA_ROOT/spe9/opm-simulation-reference/flow \
      SPE9_CP_SHORT \
      EGRID INIT PRT SMSPEC UNRST UNSMRY

      copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/flow_legacy+spe9/ \
      $OPM_DATA_ROOT/spe9/opm-simulation-reference/flow_legacy \
      SPE9_CP_SHORT \
      EGRID INIT PRT SMSPEC UNRST UNSMRY
  fi

  if grep -q "norne_init" <<< $test_name
  then
    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/init/flow+norne/ \
      $OPM_DATA_ROOT/norne/opm-simulation-reference/flow \
      NORNE_ATW2013 \
      EGRID INIT

    copyToReferenceDir \
      $configuration/build-opm-simulators/tests/results/init/flow_legacy+norne/ \
      $OPM_DATA_ROOT/norne/opm-simulation-reference/flow_legacy \
      NORNE_ATW2013 \
      EGRID INIT
  fi

  if grep -q "norne_full" <<< $test_name
  then
    copyToReferenceDir \
      deps/opm-data/norne/flow/ \
      $OPM_DATA_ROOT/norne/opm-simulation-reference/flow \
      NORNE_ATW2013 \
      UNSMRY

    copyToReferenceDir \
      deps/opm-data/norne/flow_legacy/ \
      $OPM_DATA_ROOT/norne/opm-simulation-reference/flow_legacy \
      NORNE_ATW2013 \
      UNSMRY
  fi
done

if [ -z "${@:2}" ]
then
  # User did not specify tests to update, probe
  pushd $OPM_DATA_ROOT > /dev/null
  tests=""
  git status | grep "SPE1CASE1" && tests="spe11"
  git status | grep "SPE1CASE2" && tests="$tests spe12"
  git status | grep "SPE3CASE1" && tests="$tests spe3"
  git status | grep "SPE1CASE2_2P" && tests="$tests spe1-2p"
  git status | grep "SPE1CASE2_OILGAS" && tests="$tests spe1oilgas"
  git status | grep "SPE5CASE1" && tests="$tests spe5"
  git status | grep "SPE9_CP" && tests="$tests spe9"
  git status | grep "SPE9_CP_GROUP" && tests="$tests spe9group"
  git status | grep "2D_H__" && tests="$tests msw_2d_h"
  git status | grep "3D_MSW" && tests="$tests msw_3d_hfa"
  git status | grep "2D_THREEPHASE_POLY_HETER" && tests="$tests simple2d"
  git status | grep "NORNE_ATW2013.INIT" && tests="$tests norne_init"
  git status | grep "NORNE_ATW2013.UNSMRY" && tests="$tests norne_full"
  popd > /dev/null
fi

echo -e "update reference data for $tests\n" > /tmp/cmsg
if [ -z "$REASON" ]
then
  echo -e "Reason: fill in this\n" >> /tmp/cmsg
else
  echo -e "Reason: $REASON\n" >> /tmp/cmsg
fi
for dep in libecl opm-common opm-grid opm-material ewoms
do
  pushd $WORKSPACE/deps/$dep > /dev/null
  name=`printf "%-14s" $dep`
  rev=`git rev-parse HEAD`
  echo -e "$name = $rev" >> /tmp/cmsg
  popd > /dev/null
done
echo -e "opm-simulators = `git rev-parse HEAD`" >> /tmp/cmsg

cd $OPM_DATA_ROOT
if [ -n "$BRANCH_NAME" ]
then
  git checkout -b $BRANCH_NAME origin/master
fi

# Add potential new files
untracked=`git status | sed '1,/Untracked files/d' | tail -n +3 | head -n -2`
if [ -n "$untracked" ]
then
  git add $untracked
fi

if [ -z "$REASON" ]
then
  git commit -a -t /tmp/cmsg
else
  git commit -a -F /tmp/cmsg
fi
