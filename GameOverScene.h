//
//  GameOverScene.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import <Twitter/Twitter.h>
#import "GameCenterManager.h"

#import "StoreLayer.h"

@interface GameOverLayer : CCLayerColor <GKLeaderboardViewControllerDelegate,GameCenterManagerDelegate>{
    CCLabelTTF *_label;
    int score;
    int bestScore;
    int total;
    int subTot;
    int coins;
    bool deathByCube;
    NSString *shareDia;
    float version;
    GameCenterManager *gameCenterManager;
}
@property (nonatomic, strong) CCLabelTTF *label;
@property (nonatomic, strong) GameCenterManager *gameCenterManager;
- (BOOL)connected ;
@end

@interface GameOverScene : CCScene{
    GameOverLayer *_layer;
}
@property (nonatomic, strong) GameOverLayer *layer;
@end

