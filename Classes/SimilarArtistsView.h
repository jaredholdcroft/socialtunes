//
//  SimilarArtistsViewController.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//	

#import <UIKit/UIKit.h>
#import "SocialTunesViewController.h"
#import "SocialTunesAppDelegate.h"
#import "parseCSV.h"
#import "BrowserView.h"
#import "JHSpotifyEngine.h"

@interface SimilarArtistsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, JHSpotifyEngineDelegate> {
	
	UITableView *artistsTable;
	NSArray *similarArtists;
	
	JHSpotifyEngine *spotifyEngine;
}

@property (nonatomic, retain) IBOutlet UITableView *artistsTable;
@property (nonatomic, retain) NSArray *similarArtists;

- (void) showWebViewWithURL:(NSString *)url;

@end
