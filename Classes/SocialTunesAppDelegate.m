//
//  SocialTunesAppDelegate.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright Bitformed 2010. All rights reserved.
//

#import "SocialTunesAppDelegate.h"
#import "SocialTunesViewController.h"

@implementation SocialTunesAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize sharedData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch  
	sharedData = [[NSMutableDictionary alloc]init];
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
	[sharedData release];
    [super dealloc];
}

@end
