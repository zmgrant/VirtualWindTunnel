#! /bin/bash

echo "Copying initial conditions"
cp -r 0.orig 0
echo "Generating initial mesh with blockMesh..."
foamJob -a -w -log-app blockMesh
echo "Extracting features of the model with surfaceFeatureExtract..."
foamJob -a -w -log-app surfaceFeatureExtract
echo "Decomposing for parallel mesh generation..."
foamJob -a -w -log-app decomposePar
echo "Creating model defined mesh with snappyHexMesh..."
foamJob -w -a -p -log-app snappyHexMesh -overwrite
echo "Reconstruction mesh from parallel results..."
foamJob -w -a -log-app reconstructParMesh -constant
echo "Verifying reconstructed mesh..."
foamJob -w -a -log-app checkMesh
echo "Decomposing for parallel simulation..."
foamJob -a -w -log-app decomposePar -force
echo "Running potentialFoam..."
foamJob -w -a -p -log-app potentialFoam
echo "Running simpleFoam..."
foamJob -w -a -p -log-app simpleFoam
echo "Reconstructing parallel sim..."
foamJob -w -a -log-app reconstructPar
echo "Done!"
