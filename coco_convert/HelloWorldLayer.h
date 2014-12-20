//
//  HelloWorldLayer.h
//  coco_convert
//
//  Created by Andrew on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "Platforms.h"
#import "GameOverScene.h"
#import "PaueWorldLayer.h"
#import "Cubes.h"
#import "HelperMethods.h"
@class GameCenterManager;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    CCSprite *player;
    CCSprite *pointer;

    
    CCLabelTTF *label;
    
    int jumpsLeft;
    int maxJumps;
    int64_t score;
    int bestScore;
    int extraLifes;
    
    
    int total;
    int subTot;
    int coins;
    
    float platInter;
    float velocity;
   
    bool playing;
    bool gravityOn;
    bool collision;
    bool firstPlat;
    bool cubeDeAct;
    
    NSMutableArray *_targets;
    NSMutableArray *_cubes;

    
}


+(CCScene *) scene;
-(void)addTarget;

@end
