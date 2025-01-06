#! /bin/bash

cp -r 0.orig 0
blockMesh
surfaceFeatureExtract
snappyHexMesh -overwrite
potentialFoam
simpleFoam
