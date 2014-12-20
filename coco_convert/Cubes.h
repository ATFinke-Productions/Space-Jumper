//
//  Cubes.h
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "cocos2d.h"

@interface Cubes : CCSprite {
    bool _scoreAdded;
    bool _alreadyPast;
    
    
}

@property (nonatomic, assign) bool scoreAdded;
@property (nonatomic, assign) bool alreadyPast;

@end
@interface normalCube : Cubes {
}
+(id)cube;

@end
