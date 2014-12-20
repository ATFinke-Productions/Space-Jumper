//
//  AboutLayer.m
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "AboutLayer.h"
@implementation AboutScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [AboutLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation AboutLayer

@synthesize label2 = _label2;

-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        [Flurry logEvent:@"ABOUT"];
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if (winSize.width==480 || winSize.width==568 ) {
        [CCMenuItemFont setFontSize:30];
            self.label2 = [CCLabelTTF labelWithString:@"    If we need testers for new projects, should we ask you?\n Tap the beta button above if your answer is yes." dimensions:CGSizeMake(winSize.width*.875, winSize.height*.84375) hAlignment:NSTextAlignmentCenter fontName:@"MyriadPro-BoldCond" fontSize:15];
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
        }
        else{
         [CCMenuItemFont setFontSize:50];
            self.label2 = [CCLabelTTF labelWithString:@"    If we need testers for new projects, should we ask you?\n Tap the beta button above if your answer is yes." dimensions:CGSizeMake(winSize.width*.875, winSize.height*.84375) hAlignment:NSTextAlignmentCenter fontName:@"MyriadPro-BoldCond" fontSize:35];
        }
        
        
        _label2.color = ccc3(255,255,255);
        _label2.position = ccp(winSize.width/2, -20);
      //  [self addChild:_label2];
        label = [CCLabelTTF labelWithString:@"Created By Andrew Finke" fontName:@"MyriadPro-BoldCond" fontSize:15];
        label.position = ccp(winSize.width*.85,winSize.height*.015625);
        [self addChild:label];
        
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        
		
        CCMenuItemFont* backMenu = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menuBack)];
		CCMenuItemFont* website = [CCMenuItemFont itemWithString:@"Website" target:self selector:@selector(web)];
        CCMenuItemFont* fb = [CCMenuItemFont itemWithString:@"Facebook" target:self selector:@selector(face)];
        CCMenuItemFont* appstore = [CCMenuItemFont itemWithString:@"More Apps" target:self selector:@selector(apps)];
        CCMenuItemFont* beta = [CCMenuItemFont itemWithString:@"Beta Sign-Up" target:self selector:@selector(beta)];
        
        backMenu.position = ccp(winSize.width/2, winSize.height*.078125);
        website.position = ccp(20+winSize.width/4, winSize.height*.515625); 
        fb.position = ccp(-20+winSize.width*.75, winSize.height*.765625);
        appstore.position = ccp(20+winSize.width/4, winSize.height*.765625); 
        beta.position = ccp(-20+winSize.width*.75, winSize.height*.515625);
        
        
        CCMenu *inMenu = [CCMenu menuWithItems:backMenu,website,appstore,fb, nil];
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
-(void)beta{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://atfinkeproductions.com/beta-testers.html"]];
    
}
-(void)apps{
    //[ATFinke show];
    /*UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MoreAppsViewController" bundle:nil];
    UIViewController* MoreAppsView = [storyboard instantiateInitialViewController];
    
    MoreAppsView.modalPresentationStyle = UIModalPresentationFormSheet;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentViewController:MoreAppsView animated:YES completion:nil];*/
    
}
-(void)web{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.atfinkeproductions.com"]];
    
}
-(void)face{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/Cube-Jumper/331489490275748"]];
    
}


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AboutLayer *layer = [AboutLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


@end;