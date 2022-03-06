cmake_minimum_required(VERSION 3.1)

project(cimnodes)

set (CMAKE_CXX_STANDARD 11)


#general settings
file(GLOB IMNODES_SOURCES
    cimnodes.cpp
    imnodes/imnodes.cpp
	"imnodes/dependencies/imgui-1.84.2/imgui_tables.cpp"
)

add_library(cimnodes SHARED ${IMNODES_SOURCES})

if (WIN32)
    target_compile_definitions(cimnodes PUBLIC IMNODES_IMPL_API=extern\t\"C\"\t__declspec\(dllexport\))
    list(APPEND IMNODES_LIBRARIES imm32)
else (WIN32)
    target_compile_definitions(cimnodes PUBLIC IMNODES_IMPL_API=extern\t\"C\"\t)
endif (WIN32)

add_definitions(-DIMNODES_NAMESPACE=imnodes)
target_include_directories(cimnodes PUBLIC 
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/imnodes
	${CMAKE_CURRENT_SOURCE_DIR}/../cimgui
	${CMAKE_CURRENT_SOURCE_DIR}/../cimgui/imgui)

target_link_libraries(cimnodes ${IMNODES_LIBRARIES})

#install
install(TARGETS cimnodes
    RUNTIME DESTINATION  .
    LIBRARY DESTINATION  .
    ARCHIVE DESTINATION  .
)

