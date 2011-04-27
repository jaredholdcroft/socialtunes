//
//  SocialTunesViewController.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright Bitformed 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import "UIBezierPath+ShadowPath.h"
#import "MediaViewController.h"
#import "GigViewController.h"
#import "SimilarArtistsView.h"
#import "SpotifyView.h"
#import "LyricsView.h"
#import "SettingsViewController.h"
#import "SHK.h"
#import "iAd/iAd.h"

typedef enum {
	Media,Gigs,Lyrics,Similar
} Views;

@interface SocialTunesViewController : UIViewController {
	
	UIButton *media;
	UIButton *flickr;
	UIButton *gigs;
	UIButton *similarArtists;
	UIButton *lyrics;
	UIButton *spotifyLinks;
	UIButton *share;
	
	UILabel *track;
	UILabel *artist;
	UILabel *album;
	
	UIButton *settings;
	ADBannerView *adBanner;
	
	UIView *currentView;
	
	Views currentViewType;
	
}

@property (nonatomic, retain) IBOutlet UIButton *media;
@property (nonatomic, retain) IBOutlet UIButton *flickr;
@property (nonatomic, retain) IBOutlet UIButton *gigs;
@property (nonatomic, retain) IBOutlet UIButton *lyrics;
@property (nonatomic, retain) IBOutlet UIButton *similarArtists;
@property (nonatomic, retain) IBOutlet UIButton *spotifyLinks;
@property (nonatomic, retain) IBOutlet UIButton *settings;
@property (nonatomic, retain) IBOutlet UIButton *share;
@property (nonatomic, retain) IBOutlet ADBannerView *adBanner;
@property (nonatomic, retain) IBOutlet UILabel *track;
@property (nonatomic, retain) IBOutlet UILabel *artist;
@property (nonatomic, retain) IBOutlet UILabel *album;

@property (nonatomic, retain) UIView *currentView;

- (IBAction) showMediaView:(id)sender;
- (IBAction) showGigsView:(id)sender;
- (IBAction) showLyricsView:(id)sender;
- (IBAction) showSimilarArtistsView:(id)sender;
- (IBAction) showSpotifyView:(id)sender;
- (IBAction) showSettingsView:(id)sender;
- (IBAction) shareStuff:(id)sender;

- (void) createShadowLayer:(UIView *)onView;
- (CATransition *) createSlideInAnimation;

@end

