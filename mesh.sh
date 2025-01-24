#! /bin/bash

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