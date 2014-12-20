//
//  extraLivesLayer.m
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "extraLivesLayer.h"
#import "StoreLayer.h"

@implementation extraLivesScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [extraLivesLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation extraLivesLayer
@synthesize label = _label;


-(id) init
{
    if( (self=[super initWithColor:ccc4(10,180,185,255)] )) {

        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        itemOneCost = 500;
        itemTwoCost = 2000;
        itemThreeCost = 10000;
        
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        coins = [defaults integerForKey:@"coins"];
        
        
        _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i Coins",coins] fontName:@"MyriadPro-BoldCond" fontSize:55];
        
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, 265);
        [self addChild:_label];
        
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        [CCMenuItemFont setFontSize:20];
		
        CCMenuItemFont* backMenu = [CCMenuItemFont itemWithString:@"Back To Store Sections" target:self selector:@selector(menuBack)];
        backMenu.position = ccp(winSize.width/2, 35);
        
        CCMenuItemFont* item1 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"1 Extra Life\n %i Coins",itemOneCost ] target:self selector:@selector(item1)];
        item1.position = ccp(winSize.width/5, winSize.height/2);
        
        CCMenuItemFont* item2 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"2 Extra Lifes\n %i Coins",itemTwoCost ] target:self selector:@selector(item2)];
        item2.position = ccp(winSize.width/2, winSize.height/2);
        
        CCMenuItemFont* item3 = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"3 Extra Lifes\n %i Coins",itemThreeCost ] target:self selector:@selector(item3)];
        item3.position = ccp(winSize.width*.80, winSize.height/2);
        
        
        CCMenu *inMenu = [CCMenu menuWithItems:backMenu, item1, item2, item3, nil];
        inMenu.position = CGPointZero;
        [self addChild:inMenu];
        
    }
    return self;
}
-(void)menuBack{
    [[CCDirector sharedDirector] replaceScene:[StoreLayer scene]];
}


-(void)item1{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    extraLives = [defaults integerForKey:@"extraLives"];
    if (extraLives == 0) {
        if (coins >= itemOneCost) {
            coins=coins-itemOneCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:1 forKey:@"extraLives"];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
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
    
    extraLives = [defaults integerForKey:@"extraLives"];
    if (extraLives == 0) {
        if (coins >= itemTwoCost) {
            coins=coins-itemTwoCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:2 forKey:@"extraLives"];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
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
    
    extraLives = [defaults integerForKey:@"extraLives"];
    if (extraLives == 0) {
        if (coins >= itemThreeCost) {
            coins=coins-itemThreeCost;
            [defaults setInteger:coins forKey:@"coins"];
            [defaults setInteger:3 forKey:@"extraLives"];
            UIAlertView *alert;
            alert= [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
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
	extraLivesLayer *layer = [extraLivesLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
@end