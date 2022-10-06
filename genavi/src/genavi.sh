#!/bin/bash
# genavi 0.0.1

main() {
    set -e -u -x -o pipefail

    # Mount the parent project using dxFUSE
    wget https://github.com/dnanexus/dxfuse/releases/download/v0.21/dxfuse-linux
    chmod +x dxfuse-linux
    source environment >& /dev/null
    FUSE_MOUNT=$HOME/projects
    mkdir -p $FUSE_MOUNT
    sudo -E ./dxfuse-linux -uid $(id -u) -gid $(id -g) -verbose 2 $FUSE_MOUNT $DX_PROJECT_CONTEXT_ID
    PROJ_NAME=$(dx describe $DX_PROJECT_CONTEXT_ID --name)
    PROJ_PATH=${FUSE_MOUNT}/${PROJ_NAME}
    echo "Project ${PROJ_NAME} mounted as ${PROJ_PATH}"
    
    # Load docker image
    docker load -i ${PROJ_PATH}/genavi.docker.gz
    # Run the docker image. 
    docker run --rm  --name genavi -p 443:3838 -v $PROJ_PATH:/srv/project scoughlan/genavi 

}
