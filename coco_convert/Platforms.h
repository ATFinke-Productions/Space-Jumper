//
//  Platforms.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//


#import "cocos2d.h"

@interface Platforms : CCSprite {
    bool _scoreAdded;
    bool _alreadyPast;

    
}

@property (nonatomic, assign) bool scoreAdded;
@property (nonatomic, assign) bool alreadyPast;

@end
@interface smallPlat : Platforms {
}
+(id)platform;

@end
