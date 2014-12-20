//
//  StoreLayer.h
//  Cube-Jumper
//
//  Created by Andrew on 10/1/12.
//
//

#import "AppDelegate.h"

@interface StoreLayer : CCLayerColor {
    CCLabelTTF *_label;
    CCLabelTTF *label2;
    CCLabelTTF *label3;
    int coins;
    bool extraLife;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

+(CCScene *) scene;

@end


@interface StoreScene : CCScene{
    StoreLayer *_layer;
}
@property (nonatomic, strong) StoreLayer *layer;
@end