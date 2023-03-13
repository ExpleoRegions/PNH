cmake_minimum_required(VERSION 3.5)

project(SequencerPNH VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

include_directories(../TestSoftwarePNH/)   # lbs

set(PROJECT_SOURCES
        main.cpp
        mainwindow.cpp
        mainwindow.h
        mainwindow.ui
        ctcpclient.cpp
        ctcpclient.h
        csequencer.h csequencer.cpp
        ../TestSoftwarePNH/cdatabasemanager.cpp
        ../TestSoftwarePNH/cdatabasemanager.h
        ../TestSoftwarePNH/crewardsystem.cpp
        ../TestSoftwarePNH/crewardsystem.h
        ../TestSoftwarePNH/csequencelist.cpp
        ../TestSoftwarePNH/csequencelist.h
        ../TestSoftwarePNH/ctest.cpp
        ../TestSoftwarePNH/ctest.h
        ../TestSoftwarePNH/ctestinfo.cpp
        ../TestSoftwarePNH/ctestinfo.h
        ../TestSoftwarePNH/ctestsequence.cpp
        ../TestSoftwarePNH/ctestsequence.h
        ../TestSoftwarePNH/common.h
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(SequencerPNH
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET SequencerPNH APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(SequencerPNH SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(SequencerPNH
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(SequencerPNH PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(SequencerPNH PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(SequencerPNH)
endif()

find_package(Qt6 REQUIRED COMPONENTS Sql)
target_link_libraries(SequencerPNH PRIVATE Qt6::Sql)

find_package(Qt6 REQUIRED COMPONENTS SerialPort)
target_link_libraries(SequencerPNH PRIVATE Qt6::SerialPort)

find_package(Qt6 COMPONENTS Multimedia REQUIRED)
target_link_libraries(SequencerPNH PRIVATE Qt6::Multimedia)

find_package(Qt6 REQUIRED COMPONENTS MultimediaWidgets)
target_link_libraries(SequencerPNH PRIVATE Qt6::MultimediaWidgets)

find_package(Qt6 REQUIRED COMPONENTS Charts)
target_link_libraries(SequencerPNH PRIVATE Qt6::Charts)
