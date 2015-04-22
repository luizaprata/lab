cmake_minimum_required(VERSION 2.8)
project(freenect-cppview)

find_package( OpenCV )
find_package( libfreenect )
find_package(libusb-1.0)


set(THREADS_USE_PTHREADS_WIN32 true)	 
find_package(Threads REQUIRED)
find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)


include_directories(. ${THREADS_PTHREADS_INCLUDE_DIR} ${OPENGL_INCLUDE_DIR} ${GLUT_INCLUDE_DIR} ${LIBFREENECT_INCLUDE_DIR} ${OpenCV_INCLUDE_DIRS} ${LIBUSB_1_INCLUDE_DIRS})


target_link_libraries(freenect-cppview freenect ${OPENGL_LIBRARIES} ${GLUT_LIBRARY} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIB})
target_link_libraries(freenect-cpp_pcview freenect ${OPENGL_LIBRARIES} ${GLUT_LIBRARY} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIB})
target_link_libraries(BlurImage ${OpenCV_LIBS} )

install(TARGETS freenect-cppview freenect-cpp_pcview
      DESTINATION bin)

add_executable(freenect-cppview cppview.cpp)
add_executable(freenect-cpp_pcview cpp_pc_view.cpp)



