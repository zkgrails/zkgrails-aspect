FILE=5.0.5-FL-2010-10-20
wget http://downloads.sourceforge.net/project/zk1/ZK%20Freshly/zk-$FILE/zk-bin-$FILE.zip -c
mkdir dist
mkdir injar
rm dist/zk.jar
cd injar/.
rm -Rf zk-bin-*
cd ..
unzip zk-bin-$FILE.zip zk-bin-$FILE/dist/lib/z*.jar -d injar/.
./gradlew -DzkFilename=zk-bin-$FILE clean compileJava
