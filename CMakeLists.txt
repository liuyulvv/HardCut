cmake_minimum_required(VERSION 3.16)

project(HardCut VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS
    Quick
    Core5Compat
    Multimedia
)

qt_add_executable(HardCut
    ./src/cpp/main.cpp
    resources.qrc
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
    Qt6::Multimedia
)
