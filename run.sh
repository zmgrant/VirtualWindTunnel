#! /bin/bash

echo "Copying initial conditions"
cp -r 0.orig 0
echo "Decomposing for parallel simulation..."
foamJob -a -w -log-app decomposePar -force
echo "Running potentialFoam..."
foamJob -w -a -p -log-app potentialFoam
echo "Running simpleFoam..."
foamJob -w -a -p -log-app simpleFoam
echo "Reconstructing parallel sim..."
foamJob -w -a -log-app reconstructPar
echo "Done!"
