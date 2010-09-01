FILE=5.0.4
## wget http://downloads.sourceforge.net/project/zk1/ZK%20Freshly/zk-$FILE/zk-bin-$FILE.zip -c
## wget http://www.zkoss.org/download/freshly/zk-$FILE/zkee-bin-eval-$FILE.zip -c
rm dist/zk.jar
cd injar/.
rm -Rf zkee-bin-*
cd ..
unzip zkee-bin-eval-$FILE.zip zkee-bin-eval-$FILE/dist/lib/z*.jar -d injar/.
gradle -DzkFilename=zkee-bin-eval-$FILE clean compileJava
