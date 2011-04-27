//
//  MediaViewController.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SocialTunesAppDelegate.h"
#import "SocialTunesViewController.h"
#import "MBProgressHUD.h"
#import "NSString+HTML.h"
#import "Reachability.h"

@interface MediaViewController : UIViewController <MPMediaPickerControllerDelegate, MBProgressHUDDelegate> {

    UIImageView *artwork;	
	MPMusicPlayerController *iPod;

	UIButton *lockUnlock;
	
	// HUD
	MBProgressHUD *HUD;
	
	// Similar artists
	NSMutableData *theResponse;
	NSMutableArray *similarArtists;
	bool locked;
}

@property (nonatomic, retain) IBOutlet UIImageView *artwork;
@property (nonatomic, retain) IBOutlet UIButton *lockUnlock;

@property (nonatomic, retain) MPMusicPlayerController *iPod;

- (void)handleNowPlayingItemChanged:(id)notification ;
- (void)lockAndUnlockArtist;

- (void)fetchSimilarArtists;

- (BOOL)reachable;


@end
