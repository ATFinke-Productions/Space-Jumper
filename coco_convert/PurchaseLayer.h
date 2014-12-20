//
//  PurchaseLayer.h
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "AppDelegate.h"
//#import "TapJoyViewController.h"
@interface PurchaseLayer : CCLayerColor {
    CCLabelTTF *_label;
    int coins;
    int other;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

+(CCScene *) scene;

@end


@interface PurchaseScene : CCScene{
    PurchaseLayer *_layer;
}
@property (nonatomic, strong) PurchaseLayer *layer;
@end