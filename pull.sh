#!/bin/bash -ex
PACKAGE="openssl"
PACKAGE_FIRST_CHAR=$(printf "%s" "$PACKAGE" | cut -c1)
VERSION=3.0.9
REVISION=1


wget http://deb.debian.org/debian/pool/main/$PACKAGE_FIRST_CHAR/$PACKAGE/${PACKAGE}_$VERSION-$REVISION.debian.tar.xz
tar xf ${PACKAGE}_$VERSION-$REVISION.debian.tar.xz
rm ${PACKAGE}_$VERSION-$REVISION.debian.tar.xz

wget http://deb.debian.org/debian/pool/main/$PACKAGE_FIRST_CHAR/$PACKAGE/${PACKAGE}_$VERSION.orig.tar.gz
tar xf ${PACKAGE}_$VERSION.orig.tar.gz --strip 1
rm ${PACKAGE}_$VERSION.orig.tar.gz

sed -i '/CONFARGS *=/ s/$/ enable-fips/' debian/rules
sed -i 's/enable-unit-test/no-tests/g' debian/rules
echo "usr/lib/ssl/fipsmodule.cnf" >> debian/openssl.install
