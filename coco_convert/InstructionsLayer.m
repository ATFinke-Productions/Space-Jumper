//
//  InstructionsLayer.m
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//


#import "InstructionsLayer.h"

@implementation InstructionsScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [InstructionsLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation InstructionsLayer
@synthesize label = _label;


-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        [Flurry logEvent:@"INSTRUCTIONS"];
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        
        if (winSize.width==480 || winSize.width==568 ) {
        [CCMenuItemFont setFontSize:30];
            self.label = [CCLabelTTF labelWithString:@"\n     When playing, you must jump from platform to platform to survive. You can jump three times in the air before falling back down to a platform. \n\n      The game ends if you fall off the bottom of the screen or collide with an incoming block." dimensions:CGSizeMake(winSize.width, winSize.height) hAlignment:NSTextAlignmentCenter fontName:@"MyriadPro-BoldCond" fontSize:25];
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
        }
        else{
            [CCMenuItemFont setFontSize:50];
            self.label = [CCLabelTTF labelWithString:@"\n     When playing, you must jump from platform to platform to survive. You can jump twice in the air before falling back down to a platform. \n\n      The game ends if you fall off the bottom of the screen or collide with an incoming block." dimensions:CGSizeMake(winSize.width, winSize.height) hAlignment:NSTextAlignmentCenter fontName:@"MyriadPro-BoldCond" fontSize:45];
        }
        
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_label];
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        
		
        CCMenuItemFont* backMenu = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menuBack)];
        
        backMenu.position = ccp(winSize.width/2,winSize.height*.078125);
        
        
        CCMenu *inMenu = [CCMenu menuWithItems:backMenu, nil];
        inMenu.position = CGPointZero;
        [self addChild:inMenu];
        
      
        
        
        CCParticleSystemQuad	*particles = [[CCParticleSystemManager sharedManager] particleWithFile:@"fire.plist"];
        [particles setPosition:ccp(winSize.width/2,winSize.height)];
        [self addChild:particles];
        
        
        
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [touches anyObject];
    point = [myTouch locationInView:[myTouch view]];
    point = [[CCDirector sharedDirector] convertToGL:point];
    
    [self scheduleOnce:@selector(makeTransition:) delay:0];
    
    
}
-(void) makeTransition:(ccTime)dt
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL enabled = [defaults boolForKey:@"enableFireworks"];
    BOOL soundenabled = [defaults boolForKey:@"enableFireworksSounds"];
    if (enabled) {
        CCParticleSystemQuad	*dont1 = [[CCParticleSystemManager sharedManager] particleWithFile:@"tap.plist"];
        [dont1 setPosition:ccp(point.x,point.y)];
        [self addChild:dont1];
        
    }
    if (enabled && soundenabled) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ff.mp3"];
        
    }
}
-(void)menuBack{
    [[CCDirector sharedDirector] replaceScene:[MenuWorldLayer scene]];
}




+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InstructionsLayer *layer = [InstructionsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


@end;