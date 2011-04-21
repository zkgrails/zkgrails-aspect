FILE=$1
## wget http://downloads.sourceforge.net/project/zk1/ZK%20Freshly/zk-$FILE/zk-bin-$FILE.zip -c
# wget http://www.zkoss.org/download/freshly/zk-$FILE/zkee-bin-eval-$FILE.zip -c
mkdir dist
mkdir injar
rm dist/zk.jar
cd injar/.
rm -Rf zkee-bin-*
cd ..
unzip zkee-bin-eval-$FILE.zip zkee-bin-eval-$FILE/dist/lib/z*.jar -d injar/.
./gradlew -DzkFilename=zkee-bin-eval-$FILE clean compileJava
