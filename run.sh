#! /bin/bash

echo "Copying initial conditions"
cp -r 0.orig 0
mkdir logs
echo "Generating initial mesh with blockMesh..."
blockMesh > logs/blockMesh.log
echo "Extracting features of the model with surfaceFeatureExtract..."
surfaceFeatureExtract > logs/surfaceFeatureExtract.log
echo "Creating model defined mesh with snappyHexMesh..."
snappyHexMesh -overwrite > logs/snappyHexMesh.log
echo "Running potentialFoam..."
potentialFoam > logs/potentialFoam.log
echo "Running simpleFoam..."
simpleFoam > logs/simpleFoam.log
echo "Done!"
