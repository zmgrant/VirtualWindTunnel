# VirtualWindTunnel
Easy configuration for running a virtual wind tunnel on a vehicle model using OpenFOAM

# Requirements
Software:
- OpenFOAM version: ESI V2406 (https://www.openfoam.com/news/main-news/openfoam-v2406)

Vehicle Model:
- Properly sized and oriented *.stl file of vehicle to test
- Orientation should be -x towards front of car, z is up with the car centerline along the xz-plane, the nose close to the yz-plane, and the wheels just touching the xy-plane
- Units of the stl file should be in meters

# Instructions
1) Make copy of repository to use as your working directory
2) Rename your vehicle model to `model.stl` and place it in `constant/triSurface/`
3) Run the `run.sh` bash script
4) Once that finishes, open the `foam.foam` file with ParaView to analyze the results

# Details
The `run.sh` script does the following steps automatically:
1) Runs `blockMesh` using the `system/blockMeshDict` file to define the overall space and constrains of the virtual wind tunnel
2) Runs `surfaceFeatureExtract` on the `model.stl` file to create the necessary features
3) Runs `snappyHexMesh -overwrite` on the `model.stl` file to create a dynamically sized mesh around the model
4) Runs `potentialFoam` to help refine the initial states of velocity potentials and potentially speed up the simulation
5) Runs `simpleFoam` for 500s as defined in `system/controlDict` and logs the results at 100s intervals

The `clean.sh` script removes all generated files and gets the case directory back to a clean state for running another simulation. It does NOT remove the `model.stl`
