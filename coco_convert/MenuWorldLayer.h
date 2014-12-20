//
//  MenuWorldLayer.h
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//


#import <SystemConfiguration/SystemConfiguration.h>
#import <GameKit/GameKit.h>
#import "StoreLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "AboutLayer.h"
#import "InstructionsLayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MusicTableViewController.h"
//#import "TapjoyConnect.h"


@interface MenuWorldLayer : CCLayerColor <GKAchievementViewControllerDelegate,UIAlertViewDelegate, GKLeaderboardViewControllerDelegate, MPMediaPickerControllerDelegate, MusicTableViewControllerDelegate>{
    
    float version;
    NSString *shareDia;
    int bestScore;
    CCLabelTTF *label;
    CCLabelTTF *label2;
    BOOL						playing ;
    CGPoint point;
    
    MPMusicPlayerController		*musicPlayer;
    MPMediaItemCollection		*userMediaItemCollection;

}


@property (readwrite)			BOOL					playedMusicOnce;
@property (nonatomic, retain)	MPMediaItemCollection	*userMediaItemCollection;
@property (nonatomic, retain)	MPMusicPlayerController	*musicPlayer;
@property (readwrite)			BOOL					playing;



+(CCScene *) scene;
@end
@interface MenuWorldScene : CCScene{
    MenuWorldLayer *_layer;
}
@property (nonatomic, strong) MenuWorldLayer *layer;
@end