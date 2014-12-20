//
//  Platforms.m
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "Platforms.h"

@implementation Platforms

@synthesize scoreAdded =  _scoreAdded;
@synthesize alreadyPast =  _alreadyPast;

@end

@implementation smallPlat

+ (id)platform {
    
    smallPlat *platform = nil;
    
    /*int plat = arc4random() %28;
    
    if ((platform = [[super alloc] initWithFile:[NSString stringWithFormat:@"platforms%i.png",plat]])) {
        
    }*/
    if ((platform = [[super alloc] initWithFile:@"plat.png"])) {
        
    }
    
    return platform;
    
    
    
}
@end

