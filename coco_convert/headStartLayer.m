//
//  headStartLayer.m
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "headStartLayer.h"
#import "StoreLayer.h"

@implementation headStartScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [headStartLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation headStartLayer
@synthesize label = _label;


-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        itemOneCost = 250;
        itemTwoCost = 1000;
        itemThreeCost = 5000;
        
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        coins = [defaults integerForKey:@"coins"];
        
        
        if (winSize.width==480 || winSize.width==568 ) {
            [CCMenuItemFont setFontSize:20];
            _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i Coins",coins] fontName:@"MyriadPro-BoldCond" fontSize:55];
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
        }
        else{
            [CCMenuItemFont setFontSize:40];
            _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i Coins",coins] fontName:@"MyriadPro-BoldCond" fontSize:75];
        }
		
        
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, winSize.height*.828125);
        [self addChild:_label];
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];

		
        CCMenuItemFont* backMenu = [CCMenuItemFont itemWithString:@"Back To Store Sections" target:self selector:@selector(menuBack)];
        backMenu.position = ccp(winSize.width/2, winSize.height*.109375);
        
        CCMenuItemFont* item1 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"50 Point\n Head Start\n %i Coins",itemOneCost ] target:self selector:@selector(item1)];
        item1.position = ccp(winSize.width/5, winSize.height/2);
        
        CCMenuItemFont* item2 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"100 Point\n Head Start\n %i Coins",itemTwoCost ] target:self selector:@selector(item2)];
        item2.position = ccp(winSize.width/2, winSize.height/2);
        
        CCMenuItemFont* item3 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"175 Point\n Head Start\n %i Coins",itemThreeCost ] target:self selector:@selector(item3)];
        item3.position = ccp(winSize.width*.80, winSize.height/2);
        
        
        CCMenu *inMenu = [CCMenu menuWithItems:backMenu, item1, item2, item3, nil];
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
    [[CCDirector sharedDirector] replaceScene:[StoreLayer scene]];
}


-(void)item1{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    headStart = [defaults integerForKey:@"headStart"];
    if (headStart == 0) {
        if (coins >= itemOneCost) {
            coins=coins-itemOneCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:50 forKey:@"headStart"];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
        }
        else{
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Not Enough Coins" message:[NSString stringWithFormat:@"You need %i more coins for this item. Keep playing or buy more coins in the store!",itemOneCost-coins] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else{
        UIAlertView *alert;
        alert= [[UIAlertView alloc]initWithTitle:@"Item Can't Be Purchased" message: @"You already have an item from this section of the store!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    [defaults setInteger:coins forKey:@"coins"];
    [defaults synchronize];
    _label.string = [NSString stringWithFormat:@"%i Coins", coins];
}
-(void)item2{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    headStart = [defaults integerForKey:@"headStart"];
    if (headStart == 0) {
        if (coins >= itemTwoCost) {
            coins=coins-itemTwoCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:100 forKey:@"headStart"];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
        }
        else{
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Not Enough Coins" message:[NSString stringWithFormat:@"You need %i more coins for this item. Keep playing or buy more coins in the store!",itemTwoCost-coins] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else{
        UIAlertView *alert;
        alert= [[UIAlertView alloc]initWithTitle:@"Item Can't Be Purchased" message: @"You already have an item from this section of the store!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    [defaults setInteger:coins forKey:@"coins"];
    [defaults synchronize];
    _label.string = [NSString stringWithFormat:@"%i Coins", coins];
}
-(void)item3{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    headStart = [defaults integerForKey:@"headStart"];
    if (headStart == 0) {
        if (coins >= itemThreeCost) {
            coins=coins-itemThreeCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:175 forKey:@"headStart"];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
        }
        else{
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Not Enough Coins" message:[NSString stringWithFormat:@"You need %i more coins for this item. Keep playing or buy more coins in the store!",itemThreeCost-coins] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else{
        UIAlertView *alert;
        alert= [[UIAlertView alloc]initWithTitle:@"Item Can't Be Purchased" message: @"You already have an item from this section of the store!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    [defaults setInteger:coins forKey:@"coins"];
    [defaults synchronize];
    _label.string = [NSString stringWithFormat:@"%i Coins", coins];
}



+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	headStartLayer *layer = [headStartLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
@end
