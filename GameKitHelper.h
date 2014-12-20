//
//  GameKitHelper.h
//  MonkeyJump
//
//  Created by Fahim Farook on 18/8/12.
//
//

//   Include the GameKit framework
#import <GameKit/GameKit.h>

//   Protocol to notify external
//   objects when Game Center events occur or
//   when Game Center async tasks are completed
@protocol GameKitHelperProtocol<NSObject>
@optional
-(void) onAchievementsLoaded:(NSDictionary*)achievements;
-(void) onScoresSubmitted:(bool)success;
-(void) onAchievementReported:(GKAchievement*)achievement;
-(void) onScoresOfFriendsToChallengeListReceived:(NSArray*)scores;
-(void) onPlayerInfoReceived:(NSArray*)players;

@end


@interface GameKitHelper : NSObject

@property (nonatomic, assign) id<GameKitHelperProtocol> delegate;

// This property holds the last known error
// that occured while using the Game Center API's
@property (nonatomic, readonly) NSError* lastError;

// This property holds Game Center achievements
@property (nonatomic, readonly) NSMutableDictionary* achievements;
@property (nonatomic, readwrite) BOOL includeLocalPlayerScore;

+ (id) sharedGameKitHelper;

// Player authentication, info
-(void) authenticateLocalPlayer;
// Game Center UI
-(void) showGameCenterViewController;
// Scores
-(void) submitScore:(int64_t)score category:(NSString*)category;
-(void) reportAchievementWithID:(NSString*)identifier percentComplete:(float)percent;
-(void) shareScore:(int64_t)score catergory:(NSString*)category;
-(void) findScoresOfFriendsToChallenge;
-(void) getPlayerInfo:(NSArray*)playerList;
-(void) sendScoreChallengeToPlayers:(NSArray*)players withScore:(int64_t)score message:(NSString*)message;
-(void)showFriendsPickerViewControllerForScore:(int64_t)score;

@end