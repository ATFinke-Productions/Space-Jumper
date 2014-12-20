//
//  GameOverScene.m
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "GameOverScene.h"

@implementation GameOverScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [GameOverLayer node];
        [self addChild:_layer];
        
    }
    return self;
}@end


@implementation GameOverLayer
@synthesize label = _label;



-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
    
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
        score = [defaults integerForKey:@"lastScore"];
        bestScore =[defaults integerForKey:@"bestScore"];
        deathByCube = [defaults boolForKey:@"deathByCube"]; 
        
        
        shareDia = [NSString stringWithFormat:@"Check out this game Space Jumper on the App Store, and try to beat my highscore of %i.",bestScore];
        
        self.isTouchEnabled = YES;
    
        if ([defaults boolForKey:@"NoAds"]!= TRUE) {
           // [TapjoyConnect getFeaturedApp];
        }
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        
        
        
        
        if (winSize.width==480 || winSize.width==568 ) {
            
            if (deathByCube == false) {
                
                if (score !=1) {
                    self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platforms\n Before Falling Off The Screen",score] fontName:@"MyriadPro-BoldCond" fontSize:35];
                }
                else{
                    self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platform\n Before Falling Off The Screen",score] fontName:@"MyriadPro-BoldCond" fontSize:35];
                }
            }
            else {
                self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platforms\n Before Colliding With A Cube",score] fontName:@"MyriadPro-BoldCond" fontSize:35];
            }
            
            
            
            [CCMenuItemFont setFontSize:25];
            _label.color = ccc3(255,255,255);
            _label.position = ccp(winSize.width/2, winSize.height*.8125);
            [self addChild:_label];
            
            if (bestScore == score) {
                label2 = [CCLabelTTF labelWithString:@"For A New Highscore!" fontName:@"MyriadPro-BoldCond" fontSize:25];
                label2.color = ccc3(255,255,255);
                label2.position = ccp(winSize.width/2, winSize.height*.609375);
                [self addChild:label2];
            }
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
        }
        else{
            
            if (deathByCube == false) {
                
                if (score !=1) {
                    self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platforms\n Before Falling Off The Screen",score] fontName:@"MyriadPro-BoldCond" fontSize:55];
                }
                else{
                    self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platform\n Before Falling Off The Screen",score] fontName:@"MyriadPro-BoldCond" fontSize:55];
                }
            }
            else {
                self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platforms\n Before Colliding With A Cube",score] fontName:@"MyriadPro-BoldCond" fontSize:55];
            }
            
            
            [CCMenuItemFont setFontSize:45];
            _label.color = ccc3(255,255,255);
            _label.position = ccp(winSize.width/2, winSize.height*.8125);
            [self addChild:_label];
            
            if (bestScore == score) {
                label2 = [CCLabelTTF labelWithString:@"For A New Highscore!" fontName:@"MyriadPro-BoldCond" fontSize:45];
                label2.color = ccc3(255,255,255);
                label2.position = ccp(winSize.width/2, winSize.height*.609375);
                [self addChild:label2];
            }
		}
        
        CCMenuItemFont* restartIt = [CCMenuItemFont itemWithString:@"Restart" target:self selector:@selector(restart)];
		CCMenuItemFont* menuIt = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menu)];
        CCMenuItemFont* lead = [CCMenuItemFont itemWithString:@"Leaderboards" target:self selector:@selector(showLead)];
        CCMenuItemFont* tweet = [CCMenuItemFont itemWithString:@"Share Score" target:self selector:@selector(shareTweet)];
        CCMenuItemFont* store = [CCMenuItemFont itemWithString:@"Store" target:self selector:@selector(store)];
        CCMenuItemFont* challenge = [CCMenuItemFont itemWithString:@"Challenge Friends" target:self selector:@selector(challenge)];
        
        
       
       
        lead.position = ccp(winSize.width/4, winSize.height*.28125);
        tweet.position = ccp(winSize.width/4, winSize.height*.4375);
        challenge.position = ccp(winSize.width/4, winSize.height*.125);
        
        store.position = ccp(winSize.width*.75, winSize.height*.4375);
        restartIt.position = ccp(winSize.width*.75, winSize.height*.28125);
        menuIt.position = ccp(winSize.width*.75, winSize.height*.125);
        
      
       
       CCMenu *starMenu = [CCMenu menuWithItems:restartIt,menuIt,lead,tweet,store,challenge, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
    
            
            
        
           
            BOOL enabled = [defaults boolForKey:@"enableHD"];
            
            if (enabled) {

            CCParticleSystemQuad	*win = [[CCParticleSystemManager sharedManager] particleWithFile:@"firework.plist"];
            [win setPosition:ccp(winSize.width/2,335)];
            [self addChild:win];
            }
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
	GameOverLayer *layer = [GameOverLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
- (void)restart {
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}
- (void)challenge {
    [[GameKitHelper sharedGameKitHelper] showFriendsPickerViewControllerForScore:score];
}
- (void)menu {
    [[CCDirector sharedDirector] replaceScene:[MenuWorldLayer scene]];
}
- (void)store {
    [[CCDirector sharedDirector] pushScene:[StoreLayer scene]];
}

-(void)showLead{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentViewController:leaderboardViewController animated:YES completion:nil];
}



-(void)shareTweet{
    
    
    if (version >= 6.0) {
        UIActivityViewController *share = [[UIActivityViewController alloc]initWithActivityItems:@[shareDia] applicationActivities:nil];
        
        AppController *appShare = (AppController*) [[UIApplication sharedApplication] delegate];
        [[appShare navController] presentViewController:share animated:YES completion:nil];
        [Flurry logEvent:@"SHARE"];
    }
    else{
        UIAlertView *alert;
        alert= [[UIAlertView alloc]initWithTitle:@"Sharing Not Available" message:@"Please Update To iOS 6 For This Feature" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma dismiss stuff


-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *appLead = (AppController*) [[UIApplication sharedApplication] delegate];
	[[appLead navController] dismissViewControllerAnimated:YES completion:nil];
}
@end