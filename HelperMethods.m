//
//  HelperMethods.m
//  MonkeyJump
//
//  Created by Fahim Farook on 18/8/12.
//
//

#import "HelperMethods.h"
#import "GameConstants.h"

@implementation HelperMethods

+(void)reportAchievementsForDistance:(int64_t)distance {
    
    // 1
    NSString *rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 	 NSUserDomainMask, YES)[0];
    
    NSString *plistPath =
	[rootPath
	 stringByAppendingPathComponent:
	 kAchievementsFileName];
    
    if (![[NSFileManager defaultManager]
          fileExistsAtPath:plistPath]) {
        
        plistPath =
		[[NSBundle mainBundle]
		 pathForResource:kAchievementsResourceName
		 ofType:@"plist"];
    }
    
    // 2
    NSArray *achievements =
	[NSArray arrayWithContentsOfFile:plistPath];
    
    // 3
    if (achievements == nil) {
        CCLOG(@"Error reading plist: %@",
              kAchievementsFileName);
        return;
    }
    
    // 4
    for (NSDictionary *achievementDetail
		 in achievements) {
        
        NSString *achievementId =
		achievementDetail[@"achievementId"];
        
        NSString *distanceToRun =
		achievementDetail[@"distanceToRun"];
        
        float percentComplete =
		(distance * 1.0f/[distanceToRun intValue])
		* 100;
        
        if (percentComplete > 100)
            percentComplete = 100;
        
        [[GameKitHelper sharedGameKitHelper] reportAchievementWithID:achievementId 		 percentComplete:percentComplete];
    }
}

@end
