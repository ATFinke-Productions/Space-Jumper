//
//  headStartLayer.h
//  Cube-Jumper
//
//  Created by Andrew on 10/2/12.
//
//

#import "AppDelegate.h"

@interface headStartLayer : CCLayerColor <UIAlertViewDelegate>{
    CCLabelTTF *_label;
    int coins;
    int headStart;
    int itemOneCost;
    int itemTwoCost;
    int itemThreeCost;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

+(CCScene *) scene;

@end


@interface headStartScene : CCScene{
    headStartLayer *_layer;
}
@property (nonatomic, strong) headStartLayer *layer;
@end