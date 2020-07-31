#!/bin/sh
if [ $# -lt 1 ]
then
	echo "Usage: $0 <Sonar Login Token>"
	exit 1
fi

SONAR_BRANCH=""
if [ $# -gt 1 ]
then
	SONAR_BRANCH="-Dsonar.branch.name=$2"
fi

docker build -t libdoipbuild .
docker run --rm -v "$(pwd):/proj" -w /proj libdoipbuild build-wrapper-linux-x86-64 --out-dir bw-output make clean all
docker run --rm -v "$(pwd):/proj" -w /proj libdoipbuild sonar-scanner -Dsonar.login="$1" $SONAR_BRANCH

