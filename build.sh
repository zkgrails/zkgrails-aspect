FILE=$1
## wget http://downloads.sourceforge.net/project/zk1/ZK%20Freshly/zk-$FILE/zk-bin-$FILE.zip -c
## wget http://www.zkoss.org/download/freshly/zk-$FILE/zkee-bin-eval-$FILE.zip -c

#
# a hack to make java dir exists
#
mkdir -p src/main/java

mkdir dist
mkdir injar

rm dist/zk.jar
rm dist/zul.jar

cd injar/.
rm -Rf zkee-bin-*
cd ..
unzip zkee-bin-eval-$FILE.zip zkee-bin-eval-$FILE/dist/lib/z*.jar -d injar/.

./gradlew -b build-zk.gradle  -DzkFilename=zkee-bin-eval-$FILE clean compileJava
./gradlew -b build-zul.gradle -DzkFilename=zkee-bin-eval-$FILE clean compileJava

