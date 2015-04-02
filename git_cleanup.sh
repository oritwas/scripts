SRC=${1:-"."}

cd $SRC
git clean -fdx
git submodule foreach 'git clean -fdx'
git submodule sync --recursive
git submodule update --force --init --recursive

