/*
 * Basics of Computer Graphics Exercise
 */
 
#include "assignment.h"
#include <math.h>
#include <unistd.h>
#include <GLFW/glfw3.h>

using namespace std;

#define PI 3.14159265

glm::mat4 scaling(float x_scale, float y_scale) {
    return glm::mat4( x_scale, 0.0, 0.0, 0.0,
                      0.0, y_scale, 0.0, 0.0,
                      0.0, 0.0, 1.0, 0.0,
                      0.0, 0.0, 0.0, 1.0);
}

glm::mat4 translating(float x_translate, float y_translate) {
    return glm::mat4( 1.0, 0.0, 0.0, 0.0,
                      0.0, 1.0, 0.0, 0.0,
                      0.0, 0.0, 1.0, 0.0,
                      x_translate, y_translate, 0.0, 1.0);
}

glm::mat4 rotatingZ(float angle) {
    return glm::mat4( cos(angle), -sin(angle), 0.0, 0.0,
                      sin(angle), cos(angle), 0.0, 0.0,
                      0.0, 0.0, 1.0, 0.0,
                      0.0, 0.0, 0.0, 1.0);
}

void drawRaceTrack() {
    drawCircle( glm::vec3(0.0f, 0.0f, 1.0f), scaling(0.8, 0.8));
    drawCircle( glm::vec3(0.3f, 0.3f, 0.3f), scaling(0.79, 0.79));
    drawCircle( glm::vec3(0.0f, 0.0f, 1.0f), scaling(0.6, 0.6));
    drawCircle( glm::vec3(0.0f, 0.0f, 0.0f), scaling(0.59, 0.59));
}

void drawSpetators() {
    drawCircle( glm::vec3(0.5f, 0.5f, 0.5f), translating(-0.9, 0.0) * scaling(0.08, 0.5));
}

void drawStartLine() {
    for(int i=0; i<9; i++) {
        drawCircle( glm::vec3(1.0f, 1.0f, 1.0f), translating(-0.61-0.02*i, 0.0) * scaling(0.008, 0.03));
    }
}

void drawDottedLine() {
    float numOfDot = 25.0;
    for(int i=0; i<numOfDot; i++) {
        drawCircle( glm::vec3(1.0f, 1.0f, 1.0f), translating(0.7*cos(2*i*PI/numOfDot), 0.7*sin(2*i*PI/numOfDot)) * rotatingZ(-2*i*PI/numOfDot) * scaling(0.01, 0.04));
    }
}

void drawRacingCars(float t) {
    drawCircle( glm::vec3(0.0f, 1.0f, 0.0f), translating(-0.75*cos(4*t*PI/360), -0.75*sin(4*t*PI/360)) * rotatingZ(-4*t*PI/360) * scaling(0.03, 0.1));
    drawCircle( glm::vec3(1.0f, 1.0f, 0.0f), translating(-0.65*cos(2*t*PI/360), -0.65*sin(2*t*PI/360)) * rotatingZ(-2*t*PI/360) * scaling(0.03, 0.1));
}

void drawScene(int scene, float runTime) {
    drawRaceTrack();
    drawSpetators();
    drawStartLine();
    drawDottedLine();
    drawRacingCars(runTime*10);
}

void initCustomResources()
{
}

void deleteCustomResources()
{
}

