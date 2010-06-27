FILE=5.0.3-FL-2010-06-26
wget http://downloads.sourceforge.net/project/zk1/ZK%20Freshly/zk-$FILE/zk-bin-$FILE.zip -c
rm dist/zk.jar
cd injar/.
rm -Rf zk-bin-*
cd ..
unzip zk-bin-$FILE.zip zk-bin-$FILE/dist/lib/z*.jar -d injar/.
gradle -DzkFilename=zk-bin-$FILE clean compileJava
