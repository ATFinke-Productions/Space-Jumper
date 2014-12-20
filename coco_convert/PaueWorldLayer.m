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

-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,0)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        currentScore =[defaults integerForKey:@"currentScore"];
        playing =[defaults boolForKey:@"play"];
        
        
        
        if (winSize.width==480 || winSize.width==568 ) {
            if (playing == true) {
                label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Current Score: %i",currentScore] fontName:@"MyriadPro-BoldCond" fontSize:25];
                [self addChild:label];
                label.color = ccc3(255, 255, 255);
                [CCMenuItemFont setFontSize:30];
                CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
                [dont setPosition:ccp(winSize.width/2,4)];
                [self addChild:dont];
            }
            else if (playing != true){
                [self scheduleOnce:@selector(resume) delay:.001];
                
            }
            
        }
        else{
            if (playing == true) {
                label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Current Score: %i",currentScore] fontName:@"MyriadPro-BoldCond" fontSize:45];
                [self addChild:label];
                label.color = ccc3(255, 255, 255);
                [CCMenuItemFont setFontSize:50];
            }
            else if (playing != true){
                [self scheduleOnce:@selector(resume) delay:.001];
                
            }
        }
        
        
        
            
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        
        CCMenuItemFont* resumeItem = [CCMenuItemFont itemWithString:@"Resume" target:self selector:@selector(resume)];
        CCMenuItemFont* menuItem = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menu)];
            
        label.position =  ccp( winSize.width/2 , winSize.height*.78125 );
        resumeItem.position = ccp(winSize.width/2, winSize.height*.5);
        menuItem.position = ccp(winSize.width/2, winSize.height*.25);
            
           
        CCMenu *pauseMenu = [CCMenu menuWithItems:resumeItem,menuItem, nil];
        pauseMenu.position = CGPointZero;
        [self addChild:pauseMenu];

        
        
        
        
        CCParticleSystemQuad	*pause = [[CCParticleSystemManager sharedManager] particleWithFile:@"pause.plist"];
        [pause setPosition:ccp(0,0)];
        [self addChild:pause];
        
        
        
        self.isTouchEnabled = YES;
        
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