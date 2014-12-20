//
//  AppDelegate.m
//  coco_convert
//
//  Created by Andrew on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "iRate.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "MKStoreManager.h"
#import "UIDevice+Resolutions.h"

@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return UIInterfaceOrientationIsLandscape(interfaceOrientation); /* auto rotate always */
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]]);
    [[CCDirector sharedDirector] resume];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
    
    if ([UIDevice currentResolution] == UIDevice_iPhoneTallerHiRes) {
        NSDictionary *appDefaults = [NSDictionary dictionaryWithObjects:@[@"NO",@"NO",@"YES"] forKeys:@[@"enableFireworks",@"enableFireworksSounds",@"enableHD"]];
        
        [defaults registerDefaults:appDefaults];
        [defaults synchronize];
    }
    else{
        NSDictionary *appDefaults = [NSDictionary dictionaryWithObjects:@[@"NO",@"NO",@"NO"] forKeys:@[@"enableFireworks",@"enableFireworksSounds",@"enableHD"]];
        
        [defaults registerDefaults:appDefaults];
        [defaults synchronize];
    }

    
    
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    [MKStoreManager sharedManager];
    [Flurry startSession:@"HKQKXYNV3H8RVVWMN82P"];
    [iRate sharedInstance].daysUntilPrompt = 2;
    [iRate sharedInstance].usesUntilPrompt = 2;
    
    
    /* UIAlertView *alert;
     alert= [[UIAlertView alloc]initWithTitle:@"Please Read" message:@"Check out store. Coins = score in each game. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     */
    
    orien = false;
    
        
   	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

    [glView setMultipleTouchEnabled:YES];
    
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.wantsFullScreenLayout = YES;
    

	// Display FSP and SPF
	[director_ setDisplayStats:NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
    
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

  //[TapjoyConnect requestTapjoyConnect:@"5ac537c4-824e-4b5b-86bd-7fc215d438df" secretKey:@"KLmHZEPKztEBWemZeDJ2"];
   // [TapjoyConnect requestTapjoyConnect:@"b2705004-9e22-4c1a-90bb-69d4a5e6f0ed" secretKey:@"NNpwK9hxW2jHQAIf2qcs"];

	//[TapjoyConnect setTransitionEffect:TJCTransitionExpand];
	//[TapjoyConnect setUserdefinedColorWithIntValue:0x808080];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFeaturedApp:)
                                       //          name:TJC_FEATURED_APP_RESPONSE_NOTIFICATION
                                       //        object:nil];
   
    //[TapjoyConnect setFeaturedAppDisplayCount:TJC_FEATURED_COUNT_INF];
    
    
   
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [IntroLayer scene]];
    //[director_ pushScene: [StoreLayer scene]];
	
	// Create a Navigation Controller with the Director
	//navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_ = [[MyRootViewController alloc] initWithRootViewController:director_];
    navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
//	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
    
	// make main window visible
	[window_ makeKeyAndVisible];
	[director_ startAnimation];
    
    
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"infonove.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"tap.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"pause.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"ATF Launch.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"fire2.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"firework.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"fir.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"new.plist"];
    [[CCParticleSystemManager sharedManager] preloadCacheWithType:@"fire.plist"];
    
    
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}*/

- (void) orientationChanged:(NSNotification *)note
{/*
   if (orien ==false) {
        
        alert2 = [[UIAlertView alloc]initWithTitle:@"Please Rotate" message:@"Please rotate your device so the screen flips at least once for configuration. This message will close when configured correctly." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert2 show];
        orien = true;
    }
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationLandscapeRight:
            
            [director_ startAnimation];
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            break;

        default:
            break;
    };*/
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
    
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
    PaueWorldScene *pause = [PaueWorldScene node];
    [[CCDirector sharedDirector] pushScene:pause];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
    //PaueWorldScene *pause = [PaueWorldScene node];
   // [[CCDirector sharedDirector] pushScene:pause];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

#pragma mark TJC_NOTIFICATION_HANDLERS
-(void)dismissRecived{
    NSLog(@"lll");
}
@end

