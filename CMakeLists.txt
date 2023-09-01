cmake_minimum_required(VERSION 3.16)

project(CableTester VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT_HOST_PATH "~/Qt/6.4.3/gcc_64")
set(QT_HOST_PATH_CMAKE_DIR "~/Qt/6.4.3/gcc_64/lib/cmake")
set(QML_IMPORT_PATH "$(CMAKE_SOURCE_DIR)/mybackend")

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appCableTester
    main.cpp
)

qt_add_qml_module(appCableTester
    URI CableTester
    VERSION 1.0
    QML_FILES Main.qml
    SOURCES mythread.h
    SOURCES mytcpserver.h
    SOURCES mytcpserver.cpp
    SOURCES mythread.cpp
    SOURCES mybackend.cpp mybackend.h
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCableTester PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCableTester
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCableTester
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appCableTester
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
