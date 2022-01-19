setup() {
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=$(mktemp -d -t testbeanstalkd-XXXXXXXXXX)
  export PROJNAME=testbeanstalkd
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME} --project-type=drupal9 --docroot=web --create-docroot
  ddev start
}

teardown() {
  cd ${TESTDIR}
  ddev delete -Oy ${DDEV_SITENAME}
  rm -rf ${TESTDIR}
}

@test "check basic installation" {
  cd ${TESTDIR}
  ddev get ${DIR}
  ddev restart
  res=$(ddev exec 'printf "list-tubes\nquit\n" | nc -C beanstalkd 11300')
  [[ "${res}" = OK* ]]
}
