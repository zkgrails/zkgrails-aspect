VER=$1

rm -Rf injar
mkdir injar
cd injar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zk/$VER/zk-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zul/$VER/zul-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zkplus/$VER/zkplus-$VER.jar
wget http://203.158.7.11/artifactory/repo/org/zkoss/zk/zhtml/$VER/zhtml-$VER.jar
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

cd zk
mkdir -p src/main/java
../gradlew -Dgoogle.code.username=$GOOGLE_CODE_ACC -Dgoogle.code.password=$GOOGLE_CODE_PWD -DzkVersion=$VER clean uploadArchives
cd ..

cd zul
mkdir -p src/main/java
../gradlew -Dgoogle.code.username=$GOOGLE_CODE_ACC -Dgoogle.code.password=$GOOGLE_CODE_PWD -DzkVersion=$VER clean uploadArchives
cd ..

cd zkplus
mkdir -p src/main/java
../gradlew -Dgoogle.code.username=$GOOGLE_CODE_ACC -Dgoogle.code.password=$GOOGLE_CODE_PWD -DzkVersion=$VER clean uploadArchives
cd ..

cd zhtml
mkdir -p src/main/java
../gradlew -Dgoogle.code.username=$GOOGLE_CODE_ACC -Dgoogle.code.password=$GOOGLE_CODE_PWD -DzkVersion=$VER clean uploadArchives
cd ..
