#! /bin/bash

# used to prep slate build's for hosting on ipfs
# example
# ./slate_ipfs.sh bilbobaggins 192.168.0.1 /home/solidity/go/src/github.com/RTradeLtd/temporal-api-documentation
# after uploading, you'll want to untar the file, and add it with `ipfs add -r -w <directory>`

REMOTE_USER="$1"
REMOTE_HOST="$2"
SLATE_REPO="$3"
REMOTE_IPFS_PATH="$4"
REMOTE_IPFS_CLUSTER_PATH="$5"

if [[ "$REMOTE_HOST" == "" ]]; then
	echo "first argument must be remote host to upload files to"
	exit 1
fi

if [[ "$REMOTE_USER" == "" ]]; then
	echo "second argument must be remote user of the remote host"
	exit 1
fi

if [[ "$SLATE_REPO" == "" ]]; then
    echo "third argument must be the absolute path to the slate repository"
    exit 1
fi

if [[ "$REMOTE_IPFS_PATH" == "" ]]; then
	echo "fourth argument must be the absolute path to the remote IPFS_PATH"
	exit 1
fi

if [[ "$REMOTE_IPFS_CLUSTER_PATH" == "" ]]; then
	echo "fifth argument must be the absolute path to the remote IPFS_CLUSTER_PATH"
	exit 1
fi

# change directory to slate repository
cd "$SLATE_REPO" || exit

# clean up old files
rm -rf build build.tar

# used to build slate to serve as static files
bundle exec middleman build --clean

# change to build directory, exiting if a failure is detected
cd build || exit

# updates hrefs to work with ipfs and not redirect to an actual web url
# for example if using non-prepped slate static files with an href like
# href="/account.html" on a domain gateway.temporal.cloud, this will redirect
# to gateway.temporal.cloud/account.html
# by trimming the leading / it will be redirected to the ipfs link instead
find . -type f -name "*.html" -exec sed -i 's/href="\//href="/g' {} \;
# do the same as the above for css files
find . -type f -name "*.css" -exec sed -i 's/url("\//url("/g' {} \;
# do the same for content links
find . -type f -name "*.html" -exec sed -i 's/content="\//content="/g' {} \;
# do the same for css fonts
find . -type f -name "*.css" -exec sed -i 's/url("fonts/url("..\/fonts/g' {} \;

# change back to parent directory
cd .. || exit

# tarball the file
tar cvf build.tar build

# upload tarballed file to remote host
scp build.tar "$REMOTE_USER"@"$REMOTE_HOST":~/

# run ansible to auto add to ipfs and ipfs-cluster
echo "please run the following command after the shell script exits"
echo ansible-playbook slate_ipfs.yml --extra-vars \"hosts=$REMOTE_HOST user=$REMOTE_USER ipfs_path=$REMOTE_IPFS_PATH ipfs_cluster_path=$REMOTE_IPFS_CLUSTER_PATH\"
