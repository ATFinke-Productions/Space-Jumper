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
}


@end

@implementation GameOverLayer
@synthesize label = _label;
@synthesize gameCenterManager;
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
        
        if ([GameCenterManager isGameCenterAvailable]) {
            self.gameCenterManager = [[GameCenterManager alloc] init];
            [self.gameCenterManager setDelegate:self];
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
        score = [defaults integerForKey:@"lastScore"];
        bestScore =[defaults integerForKey:@"bestScore"];
        total = [defaults integerForKey:@"totalPlat"];
        coins = [defaults integerForKey:@"coins"];
        deathByCube = [defaults boolForKey:@"deathByCube"]; 
        [defaults setInteger:coins+score forKey:@"coins"];
        [defaults setInteger:0 forKey:@"currentScore"];
        [defaults setInteger:score+total forKey:@"totalPlat"];
        [defaults setBool:false forKey:@"play"];
        [defaults synchronize];
        shareDia = [NSString stringWithFormat:@"Check out this fun free game called Cube-Jumper for iPhone, and try to beat my highscore of %i. http://bit.ly/OMFSN0",bestScore];
        
        self.isTouchEnabled = YES;
        
        
        
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        [CCMenuItemFont setFontSize:30];
		
        CCMenuItemFont* restartIt = [CCMenuItemFont itemWithString:@"Restart" target:self selector:@selector(restart)];
		CCMenuItemFont* menuIt = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menu)];
        CCMenuItemFont* lead = [CCMenuItemFont itemWithString:@"Leaderboards" target:self selector:@selector(showLead)];
        CCMenuItemFont* tweet = [CCMenuItemFont itemWithString:@"Share Score" target:self selector:@selector(shareTweet)];
        CCMenuItemFont* store = [CCMenuItemFont itemWithString:@"Store" target:self selector:@selector(store)];
        
       
        lead.position = ccp(winSize.width/4, 60);
        tweet.position = ccp(winSize.width/4, 160);
        
        store.position = ccp(winSize.width*.75, 160);
        restartIt.position = ccp(winSize.width*.75, 110);
        menuIt.position = ccp(winSize.width*.75, 60);
        
        subTot = total + score;
        
        [self.gameCenterManager reportScore:subTot forCategory:@"com.atfinkeproductions.jumper.tot"];
        [self.gameCenterManager reportScore:bestScore forCategory:@"com.atfinkeproductions.jumper.2"];
                    if (score>1000) {
                        [self.gameCenterManager submitAchievement: k1000 percentComplete:100];
                    }
                    if (score>900){
                        [self.gameCenterManager submitAchievement: k900 percentComplete:100];
                    }
                    if (score>800){
                        [self.gameCenterManager submitAchievement: k800 percentComplete:100];
                    }
                    if (score>700){
                        [self.gameCenterManager submitAchievement: k700 percentComplete:100];
                    }
                    if (score>600){
                        [self.gameCenterManager submitAchievement: k600 percentComplete:100];
                    }
                    if (score>500){
                        [self.gameCenterManager submitAchievement: k500 percentComplete:100];
                    }
                    if (score>400){
                        [self.gameCenterManager submitAchievement: k400 percentComplete:100];
                    }
                    if (score>300){
                        [self.gameCenterManager submitAchievement: k300 percentComplete:100];
                    }
                    if (score>200){
                        [self.gameCenterManager submitAchievement: k200 percentComplete:100];
                    }
                    if (score>100){
                        [self.gameCenterManager submitAchievement: k100 percentComplete:100];
                    }
                    if (score>50){
                        [self.gameCenterManager submitAchievement: k50 percentComplete:100];
                    }
                    if (score>10){
                        [self.gameCenterManager submitAchievement: k10 percentComplete:100];
                    }
       
       CCMenu *starMenu = [CCMenu menuWithItems:restartIt,menuIt,lead,tweet,store, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        if (deathByCube == false) {
        
            if (score !=1) {
                self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platforms\n Before Falling Of The Screen",score] fontName:@"MyriadPro-BoldCond" fontSize:35];
            }
            else{
                self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platform\n Before Falling Of The Screen",score] fontName:@"MyriadPro-BoldCond" fontSize:35]; 
            }
        }
        else {
            self.label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Passed %i Platforms\n Before Colliding With A Cube",score] fontName:@"MyriadPro-BoldCond" fontSize:35];
        }
        
            
            
            
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, 260);
        [self addChild:_label];
        
        
        
        
    }
    return self;
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
- (void)menu {
    [[CCDirector sharedDirector] replaceScene:[MenuWorldLayer scene]];
}
- (void)store {
    [[CCDirector sharedDirector] replaceScene:[StoreLayer scene]];
}

-(void)showLead{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentModalViewController:leaderboardViewController animated:YES];
}




-(void)shareTweet{
    
    
    if (version >= 6.0) {
        UIActivityViewController *share = [[UIActivityViewController alloc]initWithActivityItems:@[shareDia] applicationActivities:nil];
        
        AppController *appShare = (AppController*) [[UIApplication sharedApplication] delegate];
        [[appShare navController] presentViewController:share animated:YES completion:nil];
        [FlurryAnalytics logEvent:@"SHARE"];
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