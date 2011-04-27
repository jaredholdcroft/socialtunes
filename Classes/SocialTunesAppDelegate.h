//
//  SocialTunesAppDelegate.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright Bitformed 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

// Global constants - should be extern strings!

#define CURRENT_TRACK @"CURRENT_TRACK";
#define CURRENT_ARTIST @"CURRENT_ARTIST";
#define CURRENT_ALBUM @"CURRENT_ALBUM";


@class SocialTunesViewController;

@interface SocialTunesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SocialTunesViewController *viewController;
	
	NSMutableDictionary *sharedData;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SocialTunesViewController *viewController;
@property (nonatomic, retain) NSMutableDictionary *sharedData;

@end

