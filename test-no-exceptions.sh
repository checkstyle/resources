#!/usr/bin/bash

VERSION=6.2

CHECKSTYLE_REPO=~/java/git-others/checkstyle/checkstyle
JAR_ALL=$CHECKSTYLE_REPO/target/checkstyle-$VERSION-SNAPSHOT-all.jar

cd /var/tmp/
rm -rf checkstyle
rm -rf guava-libraries
rm -rf jdk

git clone https://github.com/checkstyle/checkstyle.git
git clone https://code.google.com/p/guava-libraries/
hg clone http://hg.openjdk.java.net/jdk7/jdk7/jdk/

java -jar $JAR_ALL \
     -c /google_checks.xml  \
     -o checkstyle-report-checkstyle.txt -r checkstyle

java -jar $JAR_ALL \
    -c /google_checks.xml  \
    -o checkstyle-report-guava.txt -r guava-libraries

java -jar $JAR_ALL \
    -c /sun_checks.xml  \
    -o checkstyle-report-jdk.txt -r jdk/src/share/classes

echo "Grep for Exception:"

grep "Got an exception" checkstyle-report-guava.txt
grep "Got an exception" checkstyle-report-checkstyle.txt
grep "Got an exception" checkstyle-report-jdk.txt

echo "Done."