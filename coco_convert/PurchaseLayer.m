//
//  PurchaseLayer.m
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "PurchaseLayer.h"
#import "StoreLayer.h"
#import "headStartLayer.h"
#import "MKStoreManager.h"
@implementation PurchaseScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [PurchaseLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation PurchaseLayer
@synthesize label = _label;


-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
       
        
       
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        coins = [defaults integerForKey:@"coins"];
        
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        
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
        _label.position = ccp(winSize.width/2,winSize.height*.828125);
        [self addChild:_label];
        
        
        CCMenuItemFont* back = [CCMenuItemFont itemWithString:@"Back To Store Sections" target:self selector:@selector(Back)];
        back.position = ccp(winSize.width/2,winSize.height*.109375);
        
        CCMenuItemFont* item1 = [CCMenuItemFont itemWithString:@"2500 Coins\n$0.99" target:self selector:@selector(item1)];
        item1.position = ccp(winSize.width*.2, winSize.height/2);
        
        CCMenuItemFont* item2 = [CCMenuItemFont itemWithString:@"5000 Coins\n$1.99" target:self selector:@selector(item2)];
        item2.position = ccp(winSize.width*.4, winSize.height/2);
        
        CCMenuItemFont* item3 = [CCMenuItemFont itemWithString:@"10000 Coins\n$2.99" target:self selector:@selector(item3)];
        item3.position = ccp(winSize.width*.6, winSize.height/2);
        
        CCMenuItemFont* item4 = [CCMenuItemFont itemWithString:@"20000 Coins\n$3.99" target:self selector:@selector(item4)];
        item4.position = ccp(winSize.width*.8, winSize.height/2);
        
        CCMenuItemFont* free = [CCMenuItemFont itemWithString:@"Free Coins" target:self selector:@selector(free)];
        free.position = ccp(winSize.width*.5, winSize.height*.25);
        
        
        CCMenu *inMenu = [CCMenu menuWithItems:back, item1, item2, item3, item4, nil];
        inMenu.position = CGPointZero;
        [self addChild:inMenu];
        

        
        
        
        CCParticleSystemQuad	*particles = [[CCParticleSystemManager sharedManager] particleWithFile:@"fire.plist"];
        [particles setPosition:ccp(winSize.width-80,winSize.height)];
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
    [[CCDirector sharedDirector] replaceScene:[StoreLayer scene]];
}


-(void)item1{
    
    UIAlertView *alertLoad;
    alertLoad= [[UIAlertView alloc]initWithTitle:@"Loading..." message:@"Please make sure you have an active internet connection." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertLoad show];
    
    
    [[MKStoreManager sharedManager] buyFeature:@"com.atfinkeproductions.jumper.1000"
                                    onComplete:^(NSString* purchasedFeature, NSData*data, NSArray*array)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         coins= coins+2500;
         _label.string = [NSString stringWithFormat:@"%i Coins", coins];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setInteger:coins forKey:@"coins"];
         [defaults synchronize];
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
         [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
     }
                                   onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Error" message: @"An error occured\n Please try again later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }];
    
}



-(void)item2{
    UIAlertView *alertLoad;
    alertLoad= [[UIAlertView alloc]initWithTitle:@"Loading..." message:@"Please make sure you have an active internet connection." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertLoad show];
    
    
    [[MKStoreManager sharedManager] buyFeature:@"com.atfinkeproductions.jumper.2500"
                                    onComplete:^(NSString* purchasedFeature, NSData*data, NSArray*array)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         coins= coins+5000;
         _label.string = [NSString stringWithFormat:@"%i Coins", coins];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setInteger:coins forKey:@"coins"];
         [defaults synchronize];
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }
                                   onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Error" message: @"An error occured\n Please try again later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }];
    
}
-(void)item3{
    UIAlertView *alertLoad;
    alertLoad= [[UIAlertView alloc]initWithTitle:@"Loading..." message:@"Please make sure you have an active internet connection." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertLoad show];
    
    
    [[MKStoreManager sharedManager] buyFeature:@"com.atfinkeproductions.jumper.5000"
                                    onComplete:^(NSString* purchasedFeature, NSData*data, NSArray*array)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         coins= coins+10000;
         _label.string = [NSString stringWithFormat:@"%i Coins", coins];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setInteger:coins forKey:@"coins"];
         [defaults synchronize];
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }
                                   onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Error" message: @"An error occured\n Please try again later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }];
    
}

-(void)item4{
    UIAlertView *alertLoad;
    alertLoad= [[UIAlertView alloc]initWithTitle:@"Loading..." message:@"Please make sure you have an active internet connection." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertLoad show];
    
    
    [[MKStoreManager sharedManager] buyFeature:@"com.atfinkeproductions.jumper.10000"
                                    onComplete:^(NSString* purchasedFeature, NSData*data, NSArray*array)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         coins= coins+20000;
         _label.string = [NSString stringWithFormat:@"%i Coins", coins];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setInteger:coins forKey:@"coins"];
         [defaults synchronize];
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [[SimpleAudioEngine sharedEngine] playEffect:@"store.mp3"];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }
                                   onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
         UIAlertView *alert;
         alert= [[UIAlertView alloc]initWithTitle:@"Purchase Error" message: @"An error occured\n Please try again later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
     }];
    
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
	PurchaseLayer *layer = [PurchaseLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


@end;
