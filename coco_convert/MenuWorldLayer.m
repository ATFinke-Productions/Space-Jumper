//
//  MenuWorldLayer.m
//  coco_convert
//
//  Created by Andrew on 8/7/12.
//
//
#import "MenuWorldLayer.h"

@implementation MenuWorldScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [MenuWorldLayer node];
        [self addChild:_layer];
        
    }
    return self;
}


@end

@implementation MenuWorldLayer
@synthesize userMediaItemCollection;	// the media item collection created by the user, using the media item picker
@synthesize musicPlayer;				// the music player, which plays media items from the iPod library
@synthesize playedMusicOnce;
@synthesize playing;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuWorldLayer *layer = [MenuWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation); /* auto rotate always */
}
-(id) init
{
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        
        version = [[[UIDevice currentDevice] systemVersion] floatValue];


        bestScore =[defaults integerForKey:@"bestScore"];
        [defaults setBool:false forKey:@"play"];
        
        [defaults synchronize];
        
        
        


        shareDia = [NSString stringWithFormat:@"Check out this game Space Jumper on the App Store, and try to beat my highscore of %i.",bestScore];
       
        [CCMenuItemFont setFontName:@"MyriadPro-BoldCond"];
        if (winSize.width==480 || winSize.width==568 ) {
            [CCMenuItemFont setFontSize:25];
            label2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Space Jumper"] fontName:@"MyriadPro-BoldCond" fontSize:25];
            label2.color = ccc3(255, 255, 255);
            label2.position =  ccp( winSize.width/2 ,winSize.height*.859375 );
            [self addChild:label2];
            CCParticleSystemQuad	*dont = [[CCParticleSystemManager sharedManager] particleWithFile:@"infonove.plist"];
            [dont setPosition:ccp(winSize.width/2,4)];
            [self addChild:dont];
            label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Personal Best: %i    Coins: %i",bestScore,[defaults integerForKey:@"coins"]] fontName:@"MyriadPro-BoldCond" fontSize:20];
            label.color = ccc3(255, 255, 255);
            label.position =  ccp( winSize.width/2 ,winSize.height*.046875);
            
            [self addChild:label];
        }
        else{
        [CCMenuItemFont setFontSize:45];
            label2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Space Jumper"] fontName:@"MyriadPro-BoldCond" fontSize:65];
            label2.color = ccc3(255, 255, 255);
            label2.position =  ccp( winSize.width/2 ,winSize.height*.859375 );
            
            [self addChild:label2];
            label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Personal Best: %i    Coins: %i",bestScore,[defaults integerForKey:@"coins"]] fontName:@"MyriadPro-BoldCond" fontSize:40];
            label.color = ccc3(255, 255, 255);
            label.position =  ccp( winSize.width/2 ,winSize.height*.046875);
            
            [self addChild:label];
		}
        CCMenuItemFont* starMenuItem = [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(play)];
		CCMenuItemFont* ach = [CCMenuItemFont itemWithString:@"Achievements" target:self selector:@selector(showAch)];
        CCMenuItemFont* lead = [CCMenuItemFont itemWithString:@"Leaderboards" target:self selector:@selector(showLead)];
        CCMenuItemFont* mus = [CCMenuItemFont itemWithString:@"iPod Access" target:self selector:@selector(music)];
        
        CCMenuItemFont* about = [CCMenuItemFont itemWithString:@"About" target:self selector:@selector(about)];
        CCMenuItemFont* instruc = [CCMenuItemFont itemWithString:@"Instructions" target:self selector:@selector(instuc)];
        CCMenuItemFont* tweet = [CCMenuItemFont itemWithString:@"Share" target:self selector:@selector(shareTweet)];
        CCMenuItemFont* store = [CCMenuItemFont itemWithString:@"Store" target:self selector:@selector(store)];
        
        starMenuItem.position = ccp(winSize.width/4, winSize.height*.671875);
        ach.position = ccp(winSize.width/4, winSize.height*.359375);
        lead.position = ccp(winSize.width/4, winSize.height*.203125);
        mus.position = ccp(winSize.width*.75, winSize.height*.671875);
        about.position = ccp(winSize.width*.75, winSize.height*.515625);
        instruc.position = ccp(winSize.width*.75, winSize.height*.359375);
        tweet.position = ccp(winSize.width*.75, winSize.height*.203125);
        store.position = ccp(winSize.width/4, winSize.height*.515625);

        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem,ach,lead,tweet,instruc,about,mus,store, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        self.isTouchEnabled = YES;
        
        [self setMusicPlayer: [MPMusicPlayerController iPodMusicPlayer]];
        
        [self setPlayedMusicOnce: NO];
        
        
        
        
        CCParticleSystemQuad	*particles = [[CCParticleSystemManager sharedManager] particleWithFile:@"fire.plist"];
        [particles setPosition:ccp(winSize.width/2,winSize.height)];
        [self addChild:particles];
        [self scheduleOnce:@selector(Ad:) delay:1];
        
        
        
    }
    return self;
}




-(void) Ad:(ccTime)dt
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"NoAds"]!= TRUE) {
        //[TapjoyConnect getFeaturedApp];
        
    }
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [touches anyObject];
    point = [myTouch locationInView:[myTouch view]];
    point = [[CCDirector sharedDirector] convertToGL:point];
 
    [self scheduleOnce:@selector(makeTransition:) delay:0];
    
    
}
-(void) makeTransition:(ccTime)dt
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL enabled = [defaults boolForKey:@"enableFireworks"]; 
    BOOL soundenabled = [defaults boolForKey:@"enableFireworksSounds"];
    if (enabled) {
        CCParticleSystemQuad	*dont1 = [[CCParticleSystemManager sharedManager] particleWithFile:@"tap.plist"];
        [dont1 setPosition:ccp(point.x,point.y)];
        [self addChild:dont1];
        
    }
    if (enabled && soundenabled) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ff.mp3"];
        
    }
}
-(void)play {
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
    [Flurry logEvent:@"GAMES"];
}

-(void)about {
    [[CCDirector sharedDirector] replaceScene:[AboutLayer scene]];
}
-(void)store {
    [[CCDirector sharedDirector] pushScene:[StoreLayer scene]];
    
}

-(void)instuc{
    [[CCDirector sharedDirector] replaceScene:[InstructionsLayer scene]];
    
}
-(void)showLead{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentViewController:leaderboardViewController animated:YES completion:nil];
    
}
-(void)showAch{
    GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
    achivementViewController.achievementDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentViewController:achivementViewController animated:YES completion:nil];
}


-(void)shareTweet{
    
    
    if (version >= 6.0) {
    UIActivityViewController *share = [[UIActivityViewController alloc]initWithActivityItems:@[shareDia] applicationActivities:nil];
 
    AppController *appShare = (AppController*) [[UIApplication sharedApplication] delegate];
    [[appShare navController] presentViewController:share animated:YES completion:nil];
    [Flurry logEvent:@"SHARE"];
    }
    else{
        UIAlertView *alert;
        alert= [[UIAlertView alloc]initWithTitle:@"Sharing Not Available" message:@"Please Update To iOS 6 For This Feature" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma dismiss stuff


-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *appLead = (AppController*) [[UIApplication sharedApplication] delegate];
	[[appLead navController] dismissViewControllerAnimated:YES completion:nil];
}
-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *appAch = (AppController*) [[UIApplication sharedApplication] delegate];
	[[appAch navController] dismissViewControllerAnimated:YES completion:nil];
}




-(void)music{
    if (userMediaItemCollection) {
        
		MusicTableViewController *controller = [[MusicTableViewController alloc] initWithNibName: @"MusicTableView" bundle: nil];
		controller.delegate = self;
		
		controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        
        [[app navController] presentViewController:controller animated:YES completion:nil];
        
        // else, if no music is chosen yet, display the media item picker
	} else {
        
		MPMediaPickerController *picker =
        [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
		
		picker.delegate						= self;
		picker.allowsPickingMultipleItems	= YES;
		picker.prompt						= NSLocalizedString (@"Add songs to play", "Prompt in media item picker");
		
		// The media item picker uses the default UI style, so it needs a default-style
		//		status bar to match it visually
		[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated: YES];
        
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        
        [[app navController] presentViewController:picker animated:YES completion:nil];
        
    }
}
- (void) updatePlayerQueueWithMediaCollection: (MPMediaItemCollection *) mediaItemCollection {

	// Configure the music player, but only if the user chose at least one song to play

    if (mediaItemCollection) {
       
		// If there's no playback queue yet...
		if (userMediaItemCollection == nil) {
            
			// apply the new media item collection as a playback queue for the music player
			[self setUserMediaItemCollection: mediaItemCollection];
			[musicPlayer setQueueWithItemCollection: userMediaItemCollection];
			[self setPlayedMusicOnce: YES];
			[musicPlayer play];
            
            // Obtain the music player's state so it can then be
            //		restored after updating the playback queue.
		} else {
            
			// Take note of whether or not the music player is playing. If it is
			//		it needs to be started again at the end of this method.
			BOOL wasPlaying = NO;
			if (musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
				wasPlaying = YES;
			}
			
			// Save the now-playing item and its current playback time.
			MPMediaItem *nowPlayingItem			= musicPlayer.nowPlayingItem;
			NSTimeInterval currentPlaybackTime	= musicPlayer.currentPlaybackTime;
            
			// Combine the previously-existing media item collection with the new one
			NSMutableArray *combinedMediaItems	= [[userMediaItemCollection items] mutableCopy];
			NSArray *newMediaItems				= [mediaItemCollection items];
			[combinedMediaItems addObjectsFromArray: newMediaItems];
			
            
			[self setUserMediaItemCollection: [MPMediaItemCollection collectionWithItems: (NSArray *) combinedMediaItems]];
            NSLog(@"%@",userMediaItemCollection);


			// Apply the new media item collection as a playback queue for the music player.
			[musicPlayer setQueueWithItemCollection: userMediaItemCollection];
			
			// Restore the now-playing item and its current playback time.
			musicPlayer.nowPlayingItem			= nowPlayingItem;
			musicPlayer.currentPlaybackTime		= currentPlaybackTime;
			
			// If the music player was playing, get it playing again.
			if (wasPlaying) {
				[musicPlayer play];
			}
            
         
            
		}
        
		
	}
    /*int i = 0;
    for (MPMediaItem *item in [self.userMediaItemCollection items]){
        NSLog(@"playback queue item %i has title %@",i, [item valueForKey:MPMediaItemPropertyTitle] );
        i++;
    }*/
}

- (void) restorePlaybackState {
    
	if (musicPlayer.playbackState == MPMusicPlaybackStateStopped && userMediaItemCollection) {
        
		
		if (playedMusicOnce == NO) {
            
			[self setPlayedMusicOnce: YES];
			[musicPlayer play];
		}
	}
    
}
- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
    
	// Dismiss the media item picker.
	AppController *appAch = (AppController*) [[UIApplication sharedApplication] delegate];
	[[appAch navController] dismissViewControllerAnimated:YES completion:nil];
	
	// Apply the chosen songs to the music player's queue.
	[self updatePlayerQueueWithMediaCollection: mediaItemCollection];
    
    
}
- (void) musicTableViewControllerDidFinish: (MusicTableViewController *) controller {
	
	AppController *appAch = (AppController*) [[UIApplication sharedApplication] delegate];
	[[appAch navController] dismissViewControllerAnimated:YES completion:nil];
	[self restorePlaybackState];
}
// Invoked when the user taps the Done button in the media item picker having chosen zero
//		media items to play
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker {
    
	AppController *appAch = (AppController*) [[UIApplication sharedApplication] delegate];
	[[appAch navController] dismissViewControllerAnimated:YES completion:nil];
}
@end
