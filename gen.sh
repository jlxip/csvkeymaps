#!/bin/sh -eux

# Get kbd
if [ ! -d kbd ]; then
	git clone https://github.com/legionus/kbd
fi

# Get kbd2csv
if [ ! -d kbd2csv ]; then
	git clone https://github.com/jlxip/kbd2csv
fi

# Compile kbd2csv
if [ ! -f kbd2csv/target/release/kbd2csv ]; then
	cd kbd2csv && cargo build --release && cd ..
fi

# Build directory hierarchy
cd kbd/data/keymaps
find . -type d -exec mkdir -p ../../../res/{} \;

# Convert
find . -type f -name '*.map' -exec ../../../kbd2csv/target/release/kbd2csv {} ../../../res/{} \;

# Archive
cd ../../../
tar acvf res.tar.xz res

# Cleanup
rm -rf ./kbd/ ./kbd2csv/ ./res/
