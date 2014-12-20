//
//  IntroLayer.h
//  coco_convert
//
//  Created by Andrew on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
// HelloWorldLayer

@interface IntroLayer : CCLayer 
{
    CCLabelTTF *label;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
