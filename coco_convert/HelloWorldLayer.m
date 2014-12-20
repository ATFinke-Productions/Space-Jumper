//
//  HelloWorldLayer.m
//  coco_convert
//
//  Created by Andrew on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "HelloWorldLayer.h"

#define KairTime 5.5;
#define KairTimeiPad 8.5;
#define Kgravity 0.15;
#define KgravityiPad 0.19;
#define KbeginGravity 0.03;
#define KbeginGravityiPad 0.05;

@implementation HelloWorldLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        self.isTouchEnabled = YES;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        score = [defaults integerForKey:@"headStart"];
        extraLifes = [defaults integerForKey:@"extraLives"];
        maxJumps = [defaults integerForKey:@"jumps"];
        cubeDeAct = [defaults boolForKey:@"cubesDeAct"];
        playing = true;
        [defaults setInteger:2 forKey:@"jumps"];
        [defaults setBool:false forKey:@"cubesDeAct"];
        [defaults setInteger:0 forKey:@"extraLives"];
        [defaults setInteger:0 forKey:@"headStart"];
        [defaults synchronize];
        [defaults setBool:playing forKey:@"play"];
        [defaults synchronize];
        
       
        if (maxJumps < 3) {
            maxJumps = 3;
        }
        
        
        _targets = [[NSMutableArray alloc] init];
        _cubes = [[NSMutableArray alloc] init];
        platInter = .7;
        jumpsLeft = maxJumps;
        gravityOn = true;
        firstPlat = false;
        
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        if (winSize.width==480 || winSize.width==568 ) {
        [CCMenuItemFont setFontSize:35];
            label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lli",score] fontName:@"MyriadPro-BoldCond" fontSize:40];
            label.color = ccc3(255, 255, 255);
            player = [CCSprite spriteWithFile:@"pl.png" rect:CGRectMake(0, 0, 20, 20)];
        }
        else{
            [CCMenuItemFont setFontSize:55];
            label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lli",score] fontName:@"MyriadPro-BoldCond" fontSize:60];
            label.color = ccc3(255, 255, 255);
            player = [CCSprite spriteWithFile:@"pl.png" rect:CGRectMake(0, 0, 40, 40)];
        }
        
		
        CCMenuItemFont* PauseItem = [CCMenuItemFont itemWithString:@"II" target:self selector:@selector(pause)];
        
        PauseItem.position = ccp(25,winSize.height*.91925);
        
        CCMenu *goPau = [CCMenu menuWithItems:PauseItem, nil];
        goPau.position = CGPointZero;
        [self addChild:goPau];
        
        
        
        player.position = ccp(70, winSize.height);
        
        
        
        
        
        
            label.position =  ccp( winSize.width*.92 , winSize.height*.90625 );
       
        
        
        [self schedule:@selector(update:)];
        [self schedule:@selector(gameLogic:) interval:1.2];
        [self schedule:@selector(gameLogic2:) interval:5];
        [self schedule:@selector(gravity:) interval:.01];
        [self addChild: player];
        [self addChild: label];
        
        
        
        
        BOOL enabled = [defaults boolForKey:@"enableHD"];
       
        if (enabled) {
            
        CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"new.plist"];
       [dont setPosition:ccp(winSize.width/2,4)];
        [self addChild:dont];
            CCParticleSystemQuad *particles = [[CCParticleSystemManager sharedManager] particleWithFile:@"fire2hdhd.plist"];
            [particles setPosition:ccp(winSize.width-80,winSize.height)];
            [self addChild:particles];
        }
        else{
            CCParticleSystemQuad *particles = [[CCParticleSystemManager sharedManager] particleWithFile:@"fire2.plist"];
            [particles setPosition:ccp(winSize.width/2,winSize.height)];
            [self addChild:particles];
        }
        
    }
    return self;
    
}
-(void)pause{
    PaueWorldScene *pause = [PaueWorldScene node];
    [[CCDirector sharedDirector] pushScene:pause];
}

// on "dealloc" you need to release all your retained objects
-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [_targets removeObject:sender];
    [self removeChild:sprite cleanup:YES];
}
-(void)spriteMoveFinished2:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [_cubes removeObject:sender];
    [self removeChild:sprite cleanup:YES];
}
-(void)gameLogic:(ccTime)dt {
    [self addTarget];
}
-(void)gameLogic2:(ccTime)dt {
    [self addCube];
}

-(void)addTarget {
    
    Platforms *target = nil;
    
    target = [smallPlat platform ];
    target.tag = 1;
    [_targets addObject:target];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minY = target.contentSize.height/2+20;
    int maxY = winSize.height - target.contentSize.height/2-50;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    target.position = ccp(winSize.width + (target.contentSize.width), actualY);
    [self addChild:target];
    
   
    if (platInter<=1.7) {
        
    id actionMove = [CCMoveTo actionWithDuration:3.2-platInter position:ccp(-target.contentSize.width/2, actualY)];
    
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    }
    
    else
    {
        id actionMove = [CCMoveTo actionWithDuration:1.5 position:ccp(-target.contentSize.width/2, actualY)];
        
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
        [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    }
    
}
-(void)addCube{
    if (cubeDeAct ==false) {
        
    Cubes *cube = nil;
    
    cube = [normalCube cube ];
    cube.tag = 1;
    [_cubes addObject:cube];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minY = cube.contentSize.height/2+20;
    int maxY = winSize.height - cube.contentSize.height/2-100;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    cube.position = ccp(winSize.width + (cube.contentSize.width), actualY);
    [self addChild:cube];
    
    [cube runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:2.0 angle:360]]];
        
        
    id actionMove = [CCMoveTo actionWithDuration:6 position:ccp(-cube.contentSize.width/2, actualY)];
        
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished2:)];
    [cube runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
}
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    gravityOn = true;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if (jumpsLeft > 0&& player.position.y< winSize.height){
       
        firstPlat = true;
        if (winSize.width==480 || winSize.width==568 ) {
        velocity = -KairTime;
        }
        else{
            velocity = -KairTimeiPad;
        }
        jumpsLeft --;
        [Flurry logEvent:@"JUMP"];
        
    }
    
}

-(void)gravity:(ccTime)dt{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if(gravityOn == true && firstPlat == true){
        player.position=ccp(player.position.x,player.position.y-velocity);
        if (winSize.width==480 || winSize.width==568 ) {
            velocity+=Kgravity;
        }
        else{
            velocity+=KgravityiPad;
        }
    }
    else if (firstPlat == false){
        player.position=ccp(player.position.x,player.position.y-velocity);
        if (winSize.width==480 || winSize.width==568 ) {
            velocity+=KbeginGravity;
        }
        else{
            velocity+=KbeginGravityiPad;
        }
    }
    
}

- (void)update:(ccTime)dt {
    
    
    
    if (player.position.y<-100 && extraLifes<=0) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:false forKey:@"deathByCube"];
        [defaults synchronize];
        
        [self scheduleOnce:@selector(gameOver) delay:0];
        
    }
    else if (player.position.y<-100 && extraLifes>0){
        extraLifes--;
        player.position = ccp(70, 280);
        velocity = -1;
        
    }
    
    
    
    for (CCSprite *myCubes in _cubes) {
        //Cubes *cubeholder = (Cubes*)myCubes;
        
        CGRect playerRect = CGRectMake(
                                       player.position.x - (player.contentSize.width/2),
                                       player.position.y - (player.contentSize.height/2),
                                       player.contentSize.width,
                                       player.contentSize.height);
        
        CGRect cubeRect = CGRectMake(
                                       myCubes.position.x - (myCubes.contentSize.width/2),
                                       myCubes.position.y - (myCubes.contentSize.height/2),
                                       myCubes.contentSize.width,
                                       myCubes.contentSize.height);
        
        
        if (CGRectIntersectsRect(playerRect, cubeRect)&& extraLifes<=0)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:true forKey:@"deathByCube"];
            [defaults synchronize];
            
            [self scheduleOnce:@selector(gameOver) delay:0];
            
        }
        else if (CGRectIntersectsRect(playerRect, cubeRect)&& extraLifes>0)
        {
            extraLifes--;
            player.position = ccp(70, 280);
            velocity = 0;
            
        }
    }
    for ( CCSprite * myPlats in _targets) {
        Platforms * platholder = (Platforms*)myPlats;
        
       if (myPlats.position.x <= player.position.x && platholder.scoreAdded==FALSE)
        {
            score ++;
            label.string = [NSString stringWithFormat:@"%lli", score];
            platholder.scoreAdded = TRUE;
            [Flurry logEvent:@"PLATFORMS"];
           
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:score forKey:@"currentScore"];
            [defaults synchronize];
        }
        
        
        
        CGRect playerRect = CGRectMake(
                                       player.position.x - (player.contentSize.width/2),
                                       player.position.y - (player.contentSize.height/2),
                                       player.contentSize.width,
                                       player.contentSize.height);
        
        CGRect targetRect = CGRectMake(
                                       myPlats.position.x - (myPlats.contentSize.width/2),
                                       myPlats.position.y - (myPlats.contentSize.height/2),
                                       myPlats.contentSize.width,
                                       myPlats.contentSize.height);
        
        
        if (CGRectIntersectsRect(playerRect, targetRect)&& velocity>=0)
        {
            pointer = platholder;
            velocity = 0;
            collision = TRUE;
            gravityOn = false;
            firstPlat = true;
            jumpsLeft =maxJumps;
            
            player.position=ccp(player.position.x,player.position.y+3);
            
        }
        if (CGRectIntersectsRect(playerRect, targetRect)&& velocity<=0)
        {
            firstPlat = true;
            jumpsLeft =maxJumps;
            
        }
        if (collision ==true && pointer.position.x+pointer.contentSize.width/2 < player.position.x) {
            gravityOn = true;
            collision = false;
            
        }
    }
}
-(void)gameOver{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bestScore = [defaults integerForKey:@"bestScore"];
    
    if (score>bestScore) {
        [defaults setInteger:score forKey:@"bestScore"];
    }
    
    total = [defaults integerForKey:@"totalPlat"];
    coins = [defaults integerForKey:@"coins"];
    
    subTot = total + score;
    
    [defaults setInteger:score forKey:@"lastScore"];
    [defaults setInteger:0 forKey:@"currentScore"];
    //Total Plats And Coins
    [defaults setInteger:subTot forKey:@"totalPlat"];
    [defaults setInteger:coins+score forKey:@"coins"];
    //Play Status
    [defaults setBool:false forKey:@"play"];
    //SYNC
    [defaults synchronize];

    [[GameKitHelper sharedGameKitHelper]submitScore:(int64_t)subTot category:kTotal];
    [[GameKitHelper sharedGameKitHelper]submitScore:(int64_t)score category:kGame];
    [HelperMethods reportAchievementsForDistance:(int64_t)score];
    [HelperMethods reportAchievementsForDistance:(int64_t)subTot];
    
    GameOverScene *gameOverScene = [GameOverScene node];
    [[CCDirector sharedDirector] replaceScene:gameOverScene];
    

}


@end