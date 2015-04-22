//
//  MotionDetection.cpp
//  Kinect
//
//  Created by Luiza Prata on 4/7/15.
//  Copyright (c) 2015 Luiza Prata. All rights reserved.
//

#include <opencv/cv.hpp>

#include "libfreenect.hpp"
#include <pthread.h>
#include <stdio.h>
#include <iostream>
#include <string.h>
#include <cmath>
#include <vector>

#if defined(__APPLE__)
#include <GLUT/glut.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#else
#include <GL/glut.h>
#include <GL/gl.h>
#include <GL/glu.h>
#endif



using namespace std;
using namespace cv;


int sensitivityValue = 20;
int blurSize = 10;


int theObject[2] = {0,0};
Rect objectBoundingRectangle = Rect(0,0,0,0);
Mat frame1;

int main(){

	Freenect::Freenect freenect;
	MyFreenectDevice* device;
	freenect_video_format requested_format(FREENECT_VIDEO_RGB);
	// VideoCapture capture;
	// capture.open("bouncingBall.avi");


	// Freenect::Freenect freenect;
    // MyFreenebrew install --with-cuda --with-ffmpeg --with-openni --with-tbb --HEAD opencvctDevice& device = freenect.createDevice<MyFreenectDevice>(0);
 
    // device.startVideo();
    // device.startDepth();

	

	// while(capture.get(CV_CAP_PROP_POS_FRAMES)<capture.get(CV_CAP_PROP_FRAME_COUNT)-1){
	// 	capture.read(frame1);
	// 	imshow("Frame1",frame1);

		
	// }

	cout << "end video" << endl;

	return 0;
}




