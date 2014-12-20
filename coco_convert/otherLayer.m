//
//  otherLayer.m
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "otherLayer.h"
#import "StoreLayer.h"
#import "MKStoreManager.h"
@implementation otherScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [otherLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation otherLayer
@synthesize label = _label;


-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        itemOneCost = 5000;
        itemTwoCost = 3000;
        itemThreeCost = 10000;
        
        
        
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
        
        CCMenuItemFont* item1 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"5 Jumps\n %i Coins",itemOneCost ] target:self selector:@selector(item1)];
        item1.position = ccp(winSize.width*.33333, winSize.height/2);
        
        CCMenuItemFont* item2 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"No Cubes\n %i Coins",itemTwoCost ] target:self selector:@selector(item2)];
        item2.position = ccp(winSize.width*.6666, winSize.height/2);
        
        CCMenuItemFont* item3 = [CCMenuItemFont itemWithString:@"Remove Ads\n $0.99" target:self selector:@selector(item3)];
        item3.position = ccp(winSize.width*.6, winSize.height/2);
        
        CCMenuItemFont* item4 = [CCMenuItemFont itemWithString:@"Restore Ads\n Purchase" target:self selector:@selector(item4)];
        item4.position = ccp(winSize.width*.8, winSize.height/2);
        
        CCMenuItemFont* item5 = [CCMenuItemFont itemWithString:@"Reset" target:self selector:@selector(item5)];
        item5.position = ccp(winSize.width*.5, winSize.height/4);
        
        
        
        CCMenu *inMenu = [CCMenu menuWithItems:backMenu, item1, item2, nil];
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
    
    jumps = [defaults integerForKey:@"jumps"];
    if (jumps <= 3 ) {
        if (coins >= itemOneCost) {
            coins=coins-itemOneCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:5 forKey:@"jumps"];
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
        alert= [[UIAlertView alloc]initWithTitle:@"Item Can't Be Purchased" message: @"You already have this item!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    [defaults setInteger:coins forKey:@"coins"];
    [defaults synchronize];
    _label.string = [NSString stringWithFormat:@"%i Coins", coins];
}
-(void)item2{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    cubesDeAct = [defaults boolForKey:@"cubesDeAct"];
    if (cubesDeAct == false) {
        if (coins >= itemTwoCost) {
            coins=coins-itemTwoCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setBool:true forKey:@"cubesDeAct"];
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
        alert= [[UIAlertView alloc]initWithTitle:@"Item Can't Be Purchased" message: @"You already have this item!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    [defaults setInteger:coins forKey:@"coins"];
    [defaults synchronize];
    _label.string = [NSString stringWithFormat:@"%i Coins", coins];
}
-(void)item3{
    UIAlertView *alertLoad;
    alertLoad= [[UIAlertView alloc]initWithTitle:@"Loading..." message:@"Please make sure you have an active internet connection." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertLoad show];
    
    
    [[MKStoreManager sharedManager] buyFeature:@"com.atfinkeproductions.jumper.ad"
                                    onComplete:^(NSString* purchasedFeature, NSData*data, NSArray*array)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setBool:TRUE forKey:@"NoAds"];
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
    
    
    if([SKPaymentQueue canMakePayments]) {
            [[MKStoreManager sharedManager] restorePreviousTransactionsOnComplete:^(void) {
                NSLog(@"Restored.");
                [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
                UIAlertView *alert;
                alert= [[UIAlertView alloc]initWithTitle:@"Restore Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:TRUE forKey:@"NoAds"];
                [defaults synchronize];
                
               
            }
                                                                          onError:^(NSError *error) {
                                                                              NSLog(@"Restore failed: %@", [error localizedDescription]);
                                                                              [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
                                                                              UIAlertView *alert;
                                                                              alert= [[UIAlertView alloc]initWithTitle:@"Restore Error" message: @"An error occured\n Please try again later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                              [alert show];
                                                                              
                                                                          }];
        }
        else
        {
            NSLog(@"Parental control enabled");
            [alertLoad dismissWithClickedButtonIndex:0 animated:YES];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Restore Error" message: @"Parental controls enabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    
}
- (void)item5 { //just for sandbox testing
    [[MKStoreManager sharedManager] removeAllKeychainData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"NoAds"];
    [defaults synchronize];
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	otherLayer *layer = [otherLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
@end