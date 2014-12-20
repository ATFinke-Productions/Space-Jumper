//
//  PaueWorldLayer.m
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "PaueWorldLayer.h"

@implementation PaueWorldScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [PaueWorldLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation PaueWorldLayer
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
-(id) init
{
    if( (self=[super initWithColor:ccc4(10,180,185,255)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        currentScore =[defaults integerForKey:@"currentScore"];
        playing =[defaults boolForKey:@"play"];
        
        
        
        if (currentScore != 0) {
        label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Current Score: %i P",currentScore] fontName:@"MyriadPro-BoldCond" fontSize:25];
        [self addChild:label];
        }
        
        label.color = ccc3(255, 255, 255);
        
        
        if (playing == true) {
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        [CCMenuItemFont setFontSize:30];
        CCMenuItemFont* resumeItem = [CCMenuItemFont itemWithString:@"Resume" target:self selector:@selector(resume)];
        CCMenuItemFont* menuItem = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menu)];
            
        label.position =  ccp( winSize.width/2 , 250 );
        resumeItem.position = ccp(winSize.width/2, 160);
        menuItem.position = ccp(winSize.width/2, 80);
            
           
        CCMenu *pauseMenu = [CCMenu menuWithItems:resumeItem,menuItem, nil];
        pauseMenu.position = CGPointZero;
        [self addChild:pauseMenu];

        }
        
        else if (playing != true){
           [self scheduleOnce:@selector(resume) delay:.01];
            
        }
       
 
        
        self.isTouchEnabled = YES;
        
    }
    return self;
}
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PaueWorldLayer *layer = [PaueWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
- (void)resume {
    [[CCDirector sharedDirector] popScene];
}
- (void)menu {
    [[CCDirector sharedDirector] replaceScene:[MenuWorldLayer scene]];
}


@end