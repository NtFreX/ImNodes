cmake_minimum_required(VERSION 3.1)

project(cimnodes)

set (CMAKE_CXX_STANDARD 11)

if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/imnodes/imnodes_tables.cpp)
	set(TABLES_SOURCE "imnodes/imnodes_tables.cpp")
else()
	set(TABLES_SOURCE "")
endif()


#general settings
file(GLOB IMGUI_SOURCES
    cimnodes.cpp
    imnodes/imnodes.cpp
	${TABLES_SOURCE}
)

set(CMAKE_CXX_FLAGS "-Wall -I./cimgui/ -I./cimgui/imgui/ -DIMNODES_NAMESPACE='imnodes'")
set(IMNODES_STATIC "no" CACHE STRING "Build as a static library")
set(IMNODES_FREETYPE "no" CACHE STRING "Build with freetype library")
set(IMNODES_LIBRARIES )

if(IMNODES_FREETYPE)
	FIND_PACKAGE(freetype REQUIRED PATHS ${FREETYPE_PATH})
	list(APPEND IMNODES_LIBRARIES freetype)
	list(APPEND IMNODES_SOURCES imgui/misc/freetype/imnodes_freetype.cpp)
	add_definitions("-DCIMGUI_FREETYPE=1")
endif(IMNODES_FREETYPE)

#add library and link
if (IMNODES_STATIC)
    add_library(cimnodes STATIC ${IMGUI_SOURCES})
else (IMNODES_STATIC)
    add_library(cimnodes SHARED ${IMGUI_SOURCES})
endif (IMNODES_STATIC)

target_compile_definitions(cimnodes PUBLIC IMNODES_DISABLE_OBSOLETE_FUNCTIONS=1)
if (WIN32)
    target_compile_definitions(cimnodes PUBLIC IMNODES_IMPL_API=extern\t\"C\"\t__declspec\(dllexport\))
    list(APPEND IMNODES_LIBRARIES imm32)
else (WIN32)
    target_compile_definitions(cimnodes PUBLIC IMNODES_IMPL_API=extern\t\"C\"\t)
endif (WIN32)

target_include_directories(cimnodes PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(cimnodes PUBLIC 
	${CMAKE_CURRENT_SOURCE_DIR}/imnodes
	${CMAKE_CURRENT_SOURCE_DIR}/../cimgui
	${CMAKE_CURRENT_SOURCE_DIR}/../cimgui/imgui)
set_target_properties(cimnodes PROPERTIES PREFIX "")
target_link_libraries(cimnodes ${IMNODES_LIBRARIES})

#install
install(TARGETS cimnodes
    RUNTIME DESTINATION  .
    LIBRARY DESTINATION  .
    ARCHIVE DESTINATION  .
)

#test
set(CIMNODES_TEST "no" CACHE STRING "Enable compilation of a test unit based on imgui null")

if (CIMNODES_TEST)
  add_subdirectory(test)
endif ()
