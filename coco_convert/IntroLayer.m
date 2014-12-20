//
//  IntroLayer.m
//  coco_convert
//
//  Created by Andrew on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(void) onEnter
{
	[super onEnter];
   
    
	// ask director for the window size
	CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"ATFinke Productions, Inc."] fontName:@"MyriadPro-BoldCond" fontSize:55];
    label.color = ccc3(255, 255, 255);
    label.position =  ccp( winSize.width/2 , winSize.height/2 );
    
    

    if (!TARGET_IPHONE_SIMULATOR) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"back2.mp3" loop:YES];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:.1];
        
    }
    CCParticleSystemQuad	*particles = [[CCParticleSystemManager sharedManager] particleWithFile:@"ATF Launch.plist"];
    [particles setPosition:ccp(winSize.width/2,winSize.height/2)];
    [self addChild:particles];
    [self addChild:label];
    
    
    /*if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"Default.png"];
		background.rotation = 90;
	} else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
    
	// add the label as a child to this Layer
	[self addChild: background];
	*/
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:2.5];
    self.isTouchEnabled = YES;
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:3 scene:[MenuWorldLayer scene] withColor:ccBLACK]];
}
@end
