cmake_minimum_required(VERSION 3.16)

project(HardCut VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS
    Quick
    OpenGL
    Multimedia
    Core5Compat
)

qt_add_executable(HardCut
    main.cpp
)

qt_add_qml_module(HardCut
    URI HardCut
    VERSION 1.0
    
    QML_FILES 
        ./src/qml/main.qml 
        ./src/qml/FramelessTitleBar.qml 
        ./src/qml/Welcome.qml

    RESOURCES
        ./images/close.png
        ./images/minimize.png
        ./images/separate.png
        ./images/setting.png
)

# Comment only when Debugging
# set_target_properties(HardCut PROPERTIES
#     MACOSX_BUNDLE_GUI_IDENTIFIER liuyulvv.com
#     MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#     MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#     MACOSX_BUNDLE TRUE
#     WIN32_EXECUTABLE TRUE
# )

target_compile_definitions(HardCut
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(HardCut PRIVATE
    Qt6::Quick
    Qt6::Core5Compat
)
