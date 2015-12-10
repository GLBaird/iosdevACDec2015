//
//  main.c
//  C Playground
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

#include <stdio.h>

typedef float CGFloat;

typedef struct {
    CGFloat x;
    CGFloat y;
} CGPoint;

typedef struct {
    CGFloat width;
    CGFloat height;
} CGSize;

typedef struct{
    CGPoint origin;
    CGSize size;
} CGRect;

typedef enum {
    NSTextAlignmentLeft,
    NSTextAlignmentRight,
    NSTextAlignmentCenter,
    NSTextAlignmentJustified
} NSTextAlignment;

CGPoint makeCGPoint(CGFloat x, CGFloat y) {
    CGPoint newPoint =  {
        .x = x,
        .y = y
    };
    
    return  newPoint;
}

int main(int argc, const char * argv[]) {
    // insert code here...
    
    CGPoint mPosition = {
        .x = 100,
        .y = 50
    };
    
    printf("Position in x is %d\n", mPosition.x);
    
    int myInt;
    
    char letter = 'a';
    
    int numbers[] = {10, 20, 30, 40};
    
    int numberOfRecords = sizeof(numbers) / sizeof(int);
    
    char myString[] = "Hello There";
    
    printf("Number of records: %d and my String is: %s\n", numberOfRecords, myString);
    
    int origial = 42;
    
    printf("Memory addes is %p\n", &origial);
    
    int *myPtr = &origial;
    
    printf("What is the pointer: %p\n", myPtr);
    
    *myPtr = 100;
    
    printf("What is the original: %d\n", origial);
    
    typedef int QTY;
    
    QTY myOrderSize = 560;
    
    NSTextAlignment myAlignmenty = NSTextAlignmentLeft;
    
    char *myStringAgain = "Hi there";
    
    
    return 0;
}
