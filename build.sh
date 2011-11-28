VER=$1
TARGET=$2
if test -z "$2"
then
  TARGET='uploadArchives'
else
  TARGET=$2
fi

rm -Rf injar
mkdir injar
cd injar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zk/$VER/zk-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zul/$VER/zul-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zkplus/$VER/zkplus-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zhtml/$VER/zhtml-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/common/zweb/$VER/zweb-$VER.jar
cd ..

#
# a hack to make java dir exists
#
mkdir -p src/main/java

mkdir dist
mkdir injar

rm dist/zk.jar
rm dist/zul.jar
rm dist/zkplus.jar
rm dist/zhtml.jar
rm dist/zweb.jar

for x in zweb zk zul zkplus zhtml
do
    cd $x
    mkdir -p src/main/java
    ../gradlew -Dgoogle.code.username=$GOOGLE_CODE_ACC -Dgoogle.code.password=$GOOGLE_CODE_PWD -DzkVersion=$VER clean $TARGET
    cd ..   
done
