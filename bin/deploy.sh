APP_PATH="/home/test/app/core";
BUILD_PATH="/home/test/app/core-build"

echo "Deploy Started at" $(date);

#stop application
sudo service test stop
#git pull from bitbucket repository
cd $APP_PATH && git pull && meteor build $BUILD_PATH;
#bundle decompress and remove archive
cd $BUILD_PATH && tar -zxvf core.tar.gz && rm core.tar.gz; 
#NPM install packages
cd $BUILD_PATH && cd ./bundle/programs/server && npm install --unsafe-perm; 
#cd $APP_PATH && cd .backups/ && ./setup_db.sh -d test -u user -k password
#start application
sudo service test start

echo "Deploy Ended at" $(date);
