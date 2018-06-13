


  set(ENV{PKG_CONFIG_PATH} "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/")
  INCLUDE(FindPkgConfig)

  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message("Add deps info for: ${PARTITION} - ${MODULES}" )
  message("architecture: ${CMAKE_LIBRARY_ARCHITECTURE}")
  message("system_prefix: ${CMAKE_SYSTEM_PREFIX_PATH}")

  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)

  #set(CMAKE_SYSTEM_PREFIX_PATH /usr/local;/usr;/;/usr;/root/esrocos_workspace/install)
  #set(CMAKE_LIBRARY_ARCHITECTURE x86_64-linux-gnu)

  set(LOCAL_LIBS_WO "${PARTITION}:")
  set(LOCAL_INCL_WO "${PARTITION}:")
 
  string(REPLACE " " ";" MODULES ${MODULES})
  string(REPLACE " " ";" CMAKE_SYSTEM_PREFIX_PATH ${CMAKE_SYSTEM_PREFIX_PATH})

  foreach(MODULE ${MODULES}) 
    
    pkg_check_modules(${MODULE}_INFO REQUIRED ${MODULE})

    foreach(LIB ${${MODULE}_INFO_STATIC_LIBRARIES})
    
    set(NOT_INCLUDED 1)
      
      foreach(DIR ${${MODULE}_INFO_STATIC_LIBRARY_DIRS})
        if(EXISTS "${DIR}/lib${LIB}.a") 
          set(LOCAL_LIBS_WO "${LOCAL_LIBS_WO}\n- ${DIR}/lib${LIB}.a")
	  set(NOT_INCLUDED 0)
        elseif(EXISTS "${DIR}/lib${LIB}.so") 
          set(LOCAL_LIBS_WO "${LOCAL_LIBS_WO}\n- ${DIR}/lib${LIB}.so")
	  set(NOT_INCLUDED 0)
        endif()   
      endforeach(DIR)

      if(${NOT_INCLUDED})
        message("library ${LIB} not found, try in standard locations")
	find_library(FOUND ${LIB})
	message("found ${LIB}: ${FOUND}")
        if(EXISTS ${FOUND})
          set(LOCAL_LIBS_WO "${LOCAL_LIBS_WO}\n- ${FOUND}" )
        endif()
        unset (FOUND CACHE)
      endif()

    endforeach(LIB)
    
    foreach(DIR ${${MODULE}_INFO_INCLUDE_DIRS})
      set(LOCAL_INCL_WO "${LOCAL_INCL_WO}\n- ${DIR}")
    endforeach(DIR)

  endforeach(MODULE)

  set(LOCAL_LIBS_WO "${LOCAL_LIBS_WO}\n" )
  set(LOCAL_INCL_WO "${LOCAL_INCL_WO}\n" )

  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(${LOCAL_INCL_WO})
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(${LOCAL_LIBS_WO})
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)
  message(%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%)

  file(APPEND ${CMAKE_BINARY_DIR}/includes.yml ${LOCAL_INCL_WO})
  file(APPEND ${CMAKE_BINARY_DIR}/linkings.yml ${LOCAL_LIBS_WO})


