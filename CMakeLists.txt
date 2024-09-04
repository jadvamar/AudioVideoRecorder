cmake_minimum_required(VERSION 3.16)

project(AudioVideoRecorder VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(PortAudio_DIR "C:/portaudio/build")

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
find_package(PortAudio REQUIRED)

include_directories("C:/portaudio/include")

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appAudioVideoRecorder
    main.cpp
)

qt_add_qml_module(appAudioVideoRecorder
    URI AudioVideoRecorder
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES folders.h folders.cpp
        SOURCES audiorecorder.h audiorecorder.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAudioVideoRecorder PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAudioVideoRecorder
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAudioVideoRecorder
    PRIVATE Qt6::Quick
    ${PORTAUDIO_LIBRARIES} portaudio
)

include(GNUInstallDirs)
install(TARGETS appAudioVideoRecorder
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
