#!/bin/bash

for r in */ ; do
	echo Checking $r && \
	cd $r && \
	git pull && \
	cd .. ;
done
