//
//  extraLivesLayer.h
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//
#import "AppDelegate.h"

@interface extraLivesLayer : CCLayerColor {
    CCLabelTTF *_label;
    int coins;
    int extraLives;
    int itemOneCost;
    int itemTwoCost;
    int itemThreeCost;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

+(CCScene *) scene;

@end


@interface extraLivesScene : CCScene{
    extraLivesLayer *_layer;
}
@property (nonatomic, strong) extraLivesLayer *layer;
@end