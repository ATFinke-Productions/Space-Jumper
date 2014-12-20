//
//  GameOverScene.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import <Twitter/Twitter.h>
//#import "TapjoyConnect.h"
#import "StoreLayer.h"

@interface GameOverLayer : CCLayerColor <GKLeaderboardViewControllerDelegate>{
    CCLabelTTF *_label;
    CCLabelTTF *label2;
    int score;
    int bestScore;
    int total;
    int subTot;
    int coins;
    bool deathByCube;
    NSString *shareDia;
    float version;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

@end

@interface GameOverScene : CCScene{
    GameOverLayer *_layer;
}
@property (nonatomic, strong) GameOverLayer *layer;

@end

