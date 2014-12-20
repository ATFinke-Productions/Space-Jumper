//
//  AppDelegate.h
//  coco_convert
//
//  Created by Andrew on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroLayer.h"
#import "MyRootViewController.h"
#import <GameKit/GameKit.h>
#import "GameKitHelper.h"

@class GameCenterManager;
@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	CCDirectorIOS	*__unsafe_unretained director_;
    bool orien;
    UIAlertView *alert2;
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;


@end
