cmake_minimum_required(VERSION 3.4)

project("Trench2D")

find_package(ViennaLS REQUIRED)
find_package(ViennaRay REQUIRED)

add_executable(${PROJECT_NAME} ${PROJECT_NAME}.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC "${VIENNARAY_INCLUDE_DIRS}")
target_link_libraries(${PROJECT_NAME} PRIVATE ${VIENNARAY_LIBRARIES})
configure_file(trenchGrid2D.dat ${CMAKE_CURRENT_BINARY_DIR}/trenchGrid2D.dat COPYONLY)
configure_file(run.sh ${CMAKE_CURRENT_BINARY_DIR}/run.sh COPYONLY)
