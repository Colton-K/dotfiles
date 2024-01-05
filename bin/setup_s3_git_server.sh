sudo dnf install -y git g++ fuse fuse-devel libcurl-devel libxml2-devel openssl-devel
sudo yum install -y autoconf automake

git clone https://github.com/s3fs-fuse/s3fs-fuse.git 
cd s3fs-fuse/

./autogen.sh
./configure
make
sudo make install

cd ~
mkdir git
echo "myawsstorage-colton /home/ec2-user/git fuse.s3fs _netdev,allow_other,passwd_file=/etc/passwd-s3fs,default_acl=public-read,uid=1001,gid=65534 0 0" | sudo tee -a /etc/fstab

sudo mount -a
