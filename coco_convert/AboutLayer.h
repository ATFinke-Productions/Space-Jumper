//
//  AboutLayer.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//

#import "AppDelegate.h"
#import "MenuWorldLayer.h"

@interface AboutLayer : CCLayerColor {

    CCLabelTTF *_label2;
    CCLabelTTF *label;
    CGPoint point;
}
@property (nonatomic, strong) CCLabelTTF *label2;

+(CCScene *) scene;

@end


@interface AboutScene : CCScene{
    AboutLayer *_layer;
}
@property (nonatomic, strong) AboutLayer *layer;
@end