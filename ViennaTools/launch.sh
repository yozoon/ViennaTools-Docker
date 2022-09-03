#!bin/bash

# Exit if any command fails
set -e

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

if [[ -f "/mnt/project/CMakeLists.txt" ]]; then
    echo -e "${BLUE}================================"
    echo -e "Step 1: Configuring project"
    echo -e "================================${NC}"
    cmake /mnt/project
    echo -e "${BLUE}================================"
    echo -e "Step 2: Building project"
    echo -e "================================${NC}"
    make -j $(nproc)
else
    echo -e "${RED}[ERROR] The provided project directory does not contain a CMakeLists.txt file.${NC}"
    exit 1
fi

if [[ -f "run.sh" ]]; then
    echo -e "${BLUE}================================"
    echo -e "Step 3: Executing run.sh script"
    echo -e "================================${NC}"
    bash run.sh
else
    echo -e "${RED}[ERROR] No run.sh script provided in the output directory."
    echo -e "  Did you tell CMake to copy it to the CMAKE_CURRENT_BINARY_DIR?"
    echo -e "  Example:  configure_file(run.sh \${CMAKE_CURRENT_BINARY_DIR}/run.sh COPYONLY)${NC}"
    exit 1
fi
