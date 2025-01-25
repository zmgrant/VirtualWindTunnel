# VirtualWindTunnel
Easy configuration for running a virtual wind tunnel on a vehicle model using OpenFOAM

# Requirements
Software:
- OpenFOAM version: ESI V2406 (https://www.openfoam.com/news/main-news/openfoam-v2406)
 - Install instructions for Ubuntu (works in WSL as well) can be found here: https://develop.openfoam.com/Development/openfoam/-/wikis/precompiled/debian
- ParaView
 - Download: https://www.paraview.org/download/
 - Can be run in Windows if using WSL (usual configuration)

Vehicle Model:
- Properly sized and oriented *.stl file of vehicle to test
- Orientation should be -x towards front of car, z is up with the car centerline along the xz-plane, the nose close to the yz-plane, and the wheels just touching the xy-plane
- Units of the stl file should be in meters

# Instructions
1) Make copy of repository to use as your working directory
2) Rename your vehicle model to `model.stl` and place it in `constant/triSurface/`
3) Run the `mesh.sh` to create the mesh to simulate
3) Run the `run.sh` bash script
4) Once that finishes, open the `foam.foam` file with ParaView to analyze the results

# Details
Scripts are as follows:
1) `mesh.sh` - Consumes the model given and meshes it for simulation (must be run before your first time running `run.sh`, or anytime you have updated the model)
2) `run.sh` - Runs the solver on the generated mesh and produces the results
3) `clean.sh` - Removes all generated files and gets the case directory back to a clean state for a complete running of another simulation. It does NOT remove the `model.stl`

OpenFOAM Utilities used:
`blockMesh` - uses the `system/blockMeshDict` file to define the overall space and constrains of the virtual wind tunnel
`surfaceFeatureExtract` - uses the `model.stl` file to create the necessary features
`snappyHexMesh -overwrite` uses the `model.stl` file to create a dynamically sized mesh around the model
`potentialFoam` - helps refine the initial states of velocity potentials and potentially speed up the simulation
`simpleFoam` - executes the simulation for 500s as defined in `system/controlDict` and logs the results at 100s intervals
`decomposePar` - decomposes the job into chunks that can then be processed in parallel, the `-force` attribute forces it to overwrite previous decompositions
`reconstructParMesh` - reconstructs the mesh that was computed in parallel into a single mesh
`checkMesh` - verifies integrity of the mesh
`reconstructPar` - reconstructs the results generated during parallel simulation into a single result ready to be viewed in ParaView

# Notes
- The script is set up to perform parallel processing in 8 chunks, this requires the processor this runs on to have at least 8 physical cores. If this is an issue, the number of chunks that are used can be changed in the `system/decomposeParDict` file, see documentation: https://www.openfoam.com/documentation/guides/latest/doc/openfoam-guide-parallel.html
