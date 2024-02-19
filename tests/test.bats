setup() {
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/beanstalk-testdir
  export PROJNAME=testbeanstalkd
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  mkdir "${TESTDIR}" && cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y
}

teardown() {
  cd ${TESTDIR}
  ddev delete -Oy ${DDEV_SITENAME}
  rm -rf ${TESTDIR}
}

@test "check basic installation" {
  cd ${TESTDIR}
  echo "# doing ddev get ${DIR} in ${TESTDIR} ($(pwd))" >&3

  ddev get ${DIR}
  echo "# doing restart -y in ${TESTDIR} ($(pwd))" >&3

  ddev restart -y
  echo "# doing ddev exec printf in ${TESTDIR} ($(pwd))" >&3

  res=$(ddev exec 'echo "list-tubes" | nc -C -q 1 beanstalkd 11300')
  [[ "${res}" = OK* ]]
  echo "# done with test" >&3

}
