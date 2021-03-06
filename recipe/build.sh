platform='unknown'
unamestr="$(uname)"
machine="$(uname -m)"

if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
fi

# Note you may need to enable RH devtoolset-2 if building on an
# old RH or CentOS system

# Use CMake-based build procedure
mkdir build
cd build
if [ "$platform" == 'linux' -a "$machine" != 'armv7l' ]; then
    USE_OPROFILE="ON"
else
    USE_OPROFILE="OFF"
fi

cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_TARGETS_TO_BUILD=host \
      -DLLVM_ENABLE_RTTI=ON \
      -DLLVM_INCLUDE_TESTS=OFF \
      -DLLVM_INCLUDE_UTILS=OFF \
      -DLLVM_INCLUDE_DOCS=OFF \
      -DLLVM_INCLUDE_EXAMPLES=OFF \
      -DLLVM_ENABLE_TERMINFO=OFF \
      -DLLVM_USE_OPROFILE=$USE_OPROFILE \
      ..

make -j 8
make install
