// added
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "curand_kernel.h"


#include <GL/glut.h>
#include <vector>
#include <random>    // For std::shuffle and std::mt19937
#include <algorithm> // For std::shuffle
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define N 1000               // Grid size
#define BURN_DURATION 5000   // Tree burning duration in milliseconds (5 seconds)
#define FIRE_START_COUNT 1000 // Initial number of fire locations

// Using vectors to manage memory
std::vector<int> forest(N* N, 0);
std::vector<int> burnTime(N* N, 0);

int* kForest, * kBurnTime;

// init seed for cuRAND inside kernel function
unsigned long seed = rand();

int simulationDuration = 60000; // Simulation duration (60 seconds)
int startTime = 0;              // Start time in milliseconds
int elapsedTime = 0;            // Elapsed time
float spreadProbability = 0.9f; // Probability that fire spreads to a neighboring tree

bool isPaused = false;  // Pause indicator
int pauseStartTime = 0; // Start time of pause

float zoomLevel = 1.0f;               // Zoom level
float offsetX = 0.0f, offsetY = 0.0f; // Horizontal and vertical offset for movement
float moveSpeed = 0.05f;              // View movement speed

bool dragging = false;      // Mouse drag indicator
int lastMouseX, lastMouseY; // Last mouse position when clicked

__global__ void updateForestKernel(int* kForest, int* kBurnTime, float kSpreadProbability, unsigned long kseed)
{
    // find thread x and y id
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int idy = blockIdx.y * blockDim.y + threadIdx.y;

    // set up cuRAND state
    curandState state;
    curand_init(kseed, idx * N + idy, 0, &state);

    // get equivalent 1d array index
    int index = idx * N + idy;

    if (kForest[index] == 2)
    {                          // If the tree is on fire
        kBurnTime[index] -= 200; // Reduce the burning time

        // Check if the fire is out
        if (kBurnTime[index] <= 0)
        {
            kForest[index] = 3; // Mark the tree as burned
        }
        else
        {
            // Propagation of fire to neighbors
            if (idx > 0 && kForest[index - N] == 1 && curand_uniform(&state) < kSpreadProbability)
            {
                kForest[index - N] = 2;
                kBurnTime[index - N] = BURN_DURATION;
            }
            if (idx < N - 1 && kForest[index + N] == 1 && curand_uniform(&state) < kSpreadProbability)
            {
                kForest[index + N] = 2;
                kBurnTime[index + N] = BURN_DURATION;
            }
            if (idy > 0 && kForest[index - 1] == 1 && curand_uniform(&state) < kSpreadProbability)
            {
                kForest[index - 1] = 2;
                kBurnTime[index - 1] = BURN_DURATION;
            }
            if (idy < N - 1 && kForest[index + 1] == 1 && curand_uniform(&state) < kSpreadProbability)
            {
                kForest[index + 1] = 2;
                kBurnTime[index + 1] = BURN_DURATION;
            }
        }
    }
}

// Function to initialize the forest
void initializeForest()
{
    // Initializing the forest with 50% trees
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            forest[i * N + j] = rand() % 2; // 50% trees (1), 50% empty space (0)
            burnTime[i * N + j] = 0;        // No tree is burning at the start
        }
    }

    // List of available positions to start fires
    std::vector<std::pair<int, int>> availablePositions;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            if (forest[i * N + j] == 1)
            { // Add positions with trees to the list
                availablePositions.push_back({ i, j });
            }
        }
    }

    /// Shuffle the available positions for a more uniform distribution
    std::random_device rd; // Random number generator based on system implementation
    std::mt19937 g(rd());  // Mersenne Twister-based pseudo-random number generator
    std::shuffle(availablePositions.begin(), availablePositions.end(), g);

    // Ignite fires uniformly across the grid
    for (int fire = 0; fire < FIRE_START_COUNT && !availablePositions.empty(); fire++)
    {
        int fireX = availablePositions[fire].first;
        int fireY = availablePositions[fire].second;

        forest[fireX * N + fireY] = 2;               // Ignite the tree
        burnTime[fireX * N + fireY] = BURN_DURATION; // Set the burn duration
    }

    startTime = glutGet(GLUT_ELAPSED_TIME); // Reset start time
    elapsedTime = 0;                        // Reset elapsed time
    isPaused = false;                       // End of pause

    cudaMalloc((void**)&kForest, N * N * sizeof(int));
    cudaMalloc((void**)&kBurnTime, N * N * sizeof(int));

    cudaMemcpy(kForest, forest.data(), N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(kBurnTime, burnTime.data(), N * N * sizeof(int), cudaMemcpyHostToDevice);
}

// OpenGL initialization function
void initGL()
{
    glClearColor(1.0, 1.0, 1.0, 1.0); // White background color
    glEnable(GL_DEPTH_TEST);          // Enable depth test
}

// Function to draw the grid
void drawForest()
{
    float cellSize = 2.0f / N; // Adjusted cell size based on grid size N

    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            // Set color based on the state of the cell
            if (forest[i * N + j] == 0 && burnTime[i * N + j] == 0)
            {
                glColor3f(0.8f, 0.8f, 0.8f); // Empty space (gray)
            }
            else if (forest[i * N + j] == 1)
            {
                glColor3f(0.0f, 1.0f, 0.0f); // Tree (green)
            }
            else if (forest[i * N + j] == 2)
            {
                glColor3f(1.0f, 0.0f, 0.0f); // Tree on fire (red)
            }
            else if (forest[i * N + j] == 3)
            {
                glColor3f(0.0f, 0.0f, 0.0f); // Burned tree (black)
            }

            // Draw the cell
            float x = -1.0f + j * cellSize;
            float y = -1.0f + i * cellSize;
            glBegin(GL_QUADS);
            glVertex2f(x, y);
            glVertex2f(x + cellSize, y);
            glVertex2f(x + cellSize, y + cellSize);
            glVertex2f(x, y + cellSize);
            glEnd();
        }
    }
}

// Function to update the forest and fire propagation
void updateForest()
{

    // kernel call --------------------- int *forest, int *newForest, int *burntime 
    dim3 threadsPerBlock(16, 16); // Or any other reasonable block size
    dim3 numBlocks((N + threadsPerBlock.x - 1) / threadsPerBlock.x,
        (N + threadsPerBlock.y - 1) / threadsPerBlock.y);
    updateForestKernel << <numBlocks, threadsPerBlock >> > (kForest, kBurnTime, spreadProbability, seed);
    cudaDeviceSynchronize();    //sync device

    // CUDAmemcopy back newforest into forest
    cudaMemcpy(forest.data(), kForest, N * N * sizeof(int), cudaMemcpyDeviceToHost);
    cudaMemcpy(burnTime.data(), kBurnTime, N * N * sizeof(int), cudaMemcpyDeviceToHost);
}

// Display function
void display()
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // Clear color and depth buffer
    glLoadIdentity();                                   // Reset the model-view matrix
    glTranslatef(offsetX, offsetY, 0.0f);               // Apply translation offset
    glScalef(zoomLevel, zoomLevel, 1.0f);               // Apply zoom
    drawForest();                                       // Draw the forest
    glutSwapBuffers();                                  // Swap buffers to display the image
}

// Function to animate the simulation
void update(int value)
{
    updateForest();                // Update the forest at each cycle
    glutPostRedisplay();           // Request a new rendering
    glutTimerFunc(200, update, 0); // Schedule the next update in 200 ms
}

// Keyboard handling for zooming and resetting
void keyboard(unsigned char key, int x, int y)
{
    switch (key)
    {
    case '+':
        zoomLevel *= 1.1f; // Increase zoom level
        break;
    case '-':
        zoomLevel /= 1.1f; // Decrease zoom level
        if (zoomLevel < 0.1f)
            zoomLevel = 0.1f;
        break;
    case 'r':             // Reset key
        zoomLevel = 1.0f; // Reset zoom and offset
        offsetX = 0.0f;
        offsetY = 0.0f;
        break;
    case 27: // Escape key to quit
        exit(0);
    }
    glutPostRedisplay(); // Redraw the scene
}

// Arrow keys handling for moving the view
void specialKeys(int key, int x, int y)
{
    switch (key)
    {
    case GLUT_KEY_UP:
        offsetY += moveSpeed / zoomLevel; // Move the view up
        break;
    case GLUT_KEY_DOWN:
        offsetY -= moveSpeed / zoomLevel; // Move the view down
        break;
    case GLUT_KEY_LEFT:
        offsetX += moveSpeed / zoomLevel; // Move the view left
        break;
    case GLUT_KEY_RIGHT:
        offsetX -= moveSpeed / zoomLevel; // Move the view right
        break;
    }
    glutPostRedisplay(); // Redraw the scene
}

// Mouse handling for moving the view
void mouseMotion(int x, int y)
{
    if (dragging)
    {
        offsetX += (x - lastMouseX) * moveSpeed / zoomLevel; // Update horizontal offset
        offsetY -= (y - lastMouseY) * moveSpeed / zoomLevel; // Update vertical offset
        lastMouseX = x;
        lastMouseY = y;
        glutPostRedisplay(); // Redraw the scene
    }
}

// Function to handle mouse clicks
void mouse(int button, int state, int x, int y)
{
    if (button == GLUT_LEFT_BUTTON)
    { // If the left mouse button is pressed
        if (state == GLUT_DOWN)
        {
            dragging = true;
            lastMouseX = x;
            lastMouseY = y;
        }
        else
        {
            dragging = false;
        }
    }
}

// Main function
int main(int argc, char** argv)
{
    srand(static_cast<unsigned>(time(NULL))); // Initialize random number generator
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800, 800);
    glutCreateWindow("Simulation de feux de forest/Forest Fire Simulation"); // Create the OpenGL window

    initGL();
    initializeForest();

    glutDisplayFunc(display);
    glutKeyboardFunc(keyboard);
    glutSpecialFunc(specialKeys);
    glutMouseFunc(mouse);
    glutMotionFunc(mouseMotion);
    glutTimerFunc(200, update, 0);

    glutMainLoop();
    return 0;
}