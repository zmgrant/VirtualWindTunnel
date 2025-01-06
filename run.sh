#! /bin/bash

blockMesh
surfaceFeatureExtract
snappyHexMesh -overwrite
potentialFoam
simpleFoam
