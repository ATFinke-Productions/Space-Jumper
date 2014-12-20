//
//  otherLayer.h
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "AppDelegate.h"

@interface otherLayer : CCLayerColor {
    CCLabelTTF *_label;
    int coins;
    int jumps;
    bool cubesDeAct;
    int itemOneCost;
    int itemTwoCost;
    int itemThreeCost;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

+(CCScene *) scene;

@end


@interface otherScene : CCScene{
    otherLayer *_layer;
}
@property (nonatomic, strong) otherLayer *layer;
@end