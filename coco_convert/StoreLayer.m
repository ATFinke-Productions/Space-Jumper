//
//  StoreLayer.m
//  Cube-Jumper
//
//  Created by Andrew on 10/1/12.
//
//

#import "StoreLayer.h"
#import "PurchaseLayer.h"
#import "headStartLayer.h"
#import "extraLivesLayer.h"
#import "otherLayer.h"
@implementation StoreScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [StoreLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation StoreLayer
@synthesize label = _label;


-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        [Flurry logEvent:@"STORE"];
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        coins = [defaults integerForKey:@"coins"];
        
        if (winSize.width==480) {
            [CCMenuItemFont setFontSize:20];
            _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Have %i Coins",coins] fontName:@"MyriadPro-BoldCond" fontSize:25];
            label3 = [CCLabelTTF labelWithString:@"Note: All Items Last Only One Game" fontName:@"MyriadPro-BoldCond" fontSize:20];
            label2 = [CCLabelTTF labelWithString:@"Please Select A Store Section" fontName:@"MyriadPro-BoldCond" fontSize:35];
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
        }
        else if (winSize.width == 568){
            [CCMenuItemFont setFontSize:23];
            _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Have %i Coins",coins] fontName:@"MyriadPro-BoldCond" fontSize:25];
            label3 = [CCLabelTTF labelWithString:@"Note: All Items Last Only One Game" fontName:@"MyriadPro-BoldCond" fontSize:20];
            label2 = [CCLabelTTF labelWithString:@"Please Select A Store Section" fontName:@"MyriadPro-BoldCond" fontSize:35];
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
        }
        else{
            [CCMenuItemFont setFontSize:43];
            _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Have %i Coins",coins] fontName:@"MyriadPro-BoldCond" fontSize:45];
            label3 = [CCLabelTTF labelWithString:@"Note: All Items Last Only One Game" fontName:@"MyriadPro-BoldCond" fontSize:40];
            label2 = [CCLabelTTF labelWithString:@"Please Select A Store Section" fontName:@"MyriadPro-BoldCond" fontSize:55];
        }
        
        
        label3.color = ccc3(255,255,255);
        label3.position = ccp(winSize.width/2, winSize.height*.046875); 
        [self addChild:label3];
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, winSize.height*.765625);
        [self addChild:_label];
        label2.color = ccc3(255,255,255);
        label2.position = ccp(winSize.width/2, winSize.height*.890625);
        [self addChild:label2];
        
        
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        
		
        CCMenuItemFont* backMenu = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(Back)];
        backMenu.position = ccp(winSize.width/2, winSize.height*.140625); 
        
        CCMenuItemFont* item1 = [CCMenuItemFont itemWithString:@"Head Starts" target:self selector:@selector(item1)];
        item1.position = ccp(winSize.width*.15, winSize.height/2);
        
        CCMenuItemFont* item2 = [CCMenuItemFont itemWithString:@"Extra Lifes" target:self selector:@selector(item2)];
        item2.position = ccp(winSize.width*.35, winSize.height/2);
        
        CCMenuItemFont* item3 = [CCMenuItemFont itemWithString:@"Other Items" target:self selector:@selector(item3)];
        item3.position = ccp(winSize.width*.55, winSize.height/2);
        
        CCMenuItemFont* buy = [CCMenuItemFont itemWithString:@"Get More Coins" target:self selector:@selector(buy)];
        buy.position = ccp(winSize.width*.8, winSize.height/2);
        
        CCMenuItemFont* free = [CCMenuItemFont itemWithString:@"Free Coins" target:self selector:@selector(free)];
        free.position = ccp(winSize.width*.5, winSize.height*.3);
        
        CCMenu *inMenu = [CCMenu menuWithItems:backMenu, item1, item2, buy, item3, nil];
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
-(void)Back{
    [[CCDirector sharedDirector] popScene];
}
-(void)buy{
    [[CCDirector sharedDirector] replaceScene:[PurchaseLayer scene]];
}
-(void)item1{
    [[CCDirector sharedDirector] replaceScene:[headStartLayer scene]];
}
-(void)item2{
    [[CCDirector sharedDirector] replaceScene:[extraLivesLayer scene]];
}
-(void)item3{
    [[CCDirector sharedDirector] replaceScene:[otherLayer scene]];
}
/*-(void)free{
    TapJoyViewController *controller = [[TapJoyViewController alloc] initWithNibName: @"TapJoyViewController" bundle: nil];
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentViewController:controller animated:NO completion:nil];
}*/


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StoreLayer *layer = [StoreLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


@end;
