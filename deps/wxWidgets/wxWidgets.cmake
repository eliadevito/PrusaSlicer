set(_wx_toolkit "")
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(_gtk_ver 2)
    if (DEP_WX_GTK3)
        set(_gtk_ver 3)
    endif ()
    set(_wx_toolkit "-DwxBUILD_TOOLKIT=gtk${_gtk_ver}")
endif()

set(_unicode_utf8 OFF)
if (UNIX AND NOT APPLE) # wxWidgets will not use char as the underlying type for wxString unless its forced to.
    set (_unicode_utf8 ON)
endif()

prusaslicer_add_cmake_project(wxWidgets
    URL https://github.com/eliadevito/wxWidgets/archive/9160ac2beb8fe1a91a0085128a4e088c28e865c4.zip
    URL_HASH SHA256=97c5e38b58feeaf886739adece7e1d6a812f03ca6f6487f1f3186923ba790b2f
    DEPENDS ${PNG_PKG} ${ZLIB_PKG} ${EXPAT_PKG} dep_TIFF dep_JPEG dep_NanoSVG
    CMAKE_ARGS
        -DwxBUILD_PRECOMP=ON
        ${_wx_toolkit}
        "-DCMAKE_DEBUG_POSTFIX:STRING="
        -DwxBUILD_DEBUG_LEVEL=0
        -DwxUSE_MEDIACTRL=OFF
        -DwxUSE_DETECT_SM=OFF
        -DwxUSE_UNICODE=ON
        -DwxUSE_UNICODE_UTF8=${_unicode_utf8}
        -DwxUSE_OPENGL=ON
        -DwxUSE_LIBPNG=sys
        -DwxUSE_ZLIB=sys
        -DwxUSE_NANOSVG=sys
        -DwxUSE_NANOSVG_EXTERNAL=ON
        -DwxUSE_REGEX=OFF
        -DwxUSE_LIBXPM=builtin
        -DwxUSE_LIBJPEG=sys
        -DwxUSE_LIBTIFF=sys
        -DwxUSE_EXPAT=sys
        -DwxUSE_LIBSDL=OFF
        -DwxUSE_XTEST=OFF
        -DwxUSE_GLCANVAS_EGL=OFF
        -DwxUSE_WEBREQUEST=OFF
)

if (MSVC)
    add_debug_dep(dep_wxWidgets)
endif ()