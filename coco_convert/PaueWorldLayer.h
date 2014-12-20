//
//  PaueWorldLayer.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "AppDelegate.h"

@interface PaueWorldLayer : CCLayerColor {
    int currentScore;
    CCLabelTTF *label;
    bool playing;
    CGPoint point;
}


@end
@interface PaueWorldScene : CCScene{
    PaueWorldLayer *_layer;
}
@property (nonatomic, strong) PaueWorldLayer *layer;
@end