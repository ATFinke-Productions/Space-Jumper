//
//  InstructionsLayer.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "AppDelegate.h"

@interface InstructionsLayer : CCLayerColor {
    CCLabelTTF *_label;
    CGPoint point;
}

@property (nonatomic, strong) CCLabelTTF *label;

+(CCScene *) scene;

@end


@interface InstructionsScene : CCScene{
    InstructionsLayer *_layer;
}
@property (nonatomic, strong) InstructionsLayer *layer;
@end