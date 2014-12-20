//
//  Cubes.m
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//
#import "Cubes.h"

@implementation Cubes

@synthesize scoreAdded =  _scoreAdded;
@synthesize alreadyPast =  _alreadyPast;

@end

@implementation normalCube

+ (id)cube {
    
    Cubes *cube = nil;
    
    if ((cube = [[super alloc] initWithFile:@"pl.png"])) {
        
    }
    
    return cube;
    
    
    
}
@end

