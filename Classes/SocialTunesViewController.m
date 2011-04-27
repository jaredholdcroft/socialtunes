//
//  SocialTunesViewController.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright Bitformed 2010. All rights reserved.
//

#import "SocialTunesViewController.h"


@implementation SocialTunesViewController

@synthesize media, flickr, gigs, lyrics, similarArtists, spotifyLinks, currentView, settings, share, adBanner, artist, track, album;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	// Lock all but the media buttons
	[gigs setEnabled:NO];
	[lyrics setEnabled:NO];
	[similarArtists setEnabled:NO];
	
	self.adBanner.requiredContentSizeIdentifiers = [NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
	
	// Let's start with the media view
	[self showMediaView:nil];
	currentViewType = Media;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.adBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
		
		artist.frame = CGRectMake(750,199,280,21);
		track.frame = CGRectMake(750,228,280,21);
		album.frame = CGRectMake(750,257,280,21);
	} else {
        self.adBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
		artist.frame = CGRectMake(20,830,280,21);
		track.frame = CGRectMake(20,859,280,21);
		album.frame = CGRectMake(20,888,280,21);
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction) shareStuff:(id)sender {
	
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	NSString* currentArtist = [bigDaddy.sharedData valueForKey:@"CURRENT_ARTIST"] ;
	
	NSString* currentTrack = [bigDaddy.sharedData valueForKey:@"CURRENT_TRACK"] ;
	
	SHKItem *item;
	

	switch(currentViewType) {
		case Lyrics:
			NSLog(@"Lyrics Share");
		
			item = [SHKItem URL:[NSURL URLWithString:@"http://bitformed.com/socialtunes"] title:[NSString stringWithFormat:@"Check out %@ by %@. #socialtunes", currentTrack, currentArtist]];			
			break;
		case Gigs:
			NSLog(@"Gigs Share");
			item = [SHKItem URL:[NSURL URLWithString:@"http://bitformed.com/socialtunes"] title:[NSString stringWithFormat:@"Check out %@ by %@. #socialtunes", currentTrack, currentArtist]];			
			break;
		case Similar:
			NSLog(@"Similar Share");
			
			item = [SHKItem URL:[NSURL URLWithString:@"http://bitformed.com/socialtunes"] title:[NSString stringWithFormat:@"Check out %@ by %@. #socialtunes", currentTrack, currentArtist]];			
			break;
		case Media:
			NSLog(@"Media Share");
			
			item = [SHKItem URL:[NSURL URLWithString:@"http://bitformed.com/socialtunes"] title:[NSString stringWithFormat:@"Check out %@ by %@. #socialtunes", currentTrack, currentArtist]];
	}
	
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	// Display the action sheet
	//[actionSheet showFromToolbar:navigationController.toolbar];
	[actionSheet showInView:self.view];
}

- (IBAction) showMediaView:(id)sender {
	CGRect frame = CGRectMake(120, 100, 600, 600); 
	
	MediaViewController *mediaView = [[MediaViewController alloc] initWithNibName:@"MediaView" bundle:nil];
	[mediaView.view setFrame:frame];

	[self createShadowLayer:mediaView.view];
	
	[currentView removeFromSuperview];
	
	[self.view addSubview:mediaView.view];

	[[mediaView.view layer] addAnimation:[self createSlideInAnimation] forKey:@"fadeIn"];
	
	//[media setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

	currentView = mediaView.view;
	currentViewType = Media;
}

- (IBAction) showSpotifyView:(id) sender {
	CGRect frame = CGRectMake(120, 100, 600, 600); 
	
	SpotifyViewController *spotifyView = [[SpotifyViewController alloc] initWithNibName:@"SpotifyView" bundle:nil];
	[spotifyView.view setFrame:frame];
	
	[self createShadowLayer:spotifyView.view];
	
	[currentView removeFromSuperview];
	
	[self.view addSubview:spotifyView.view];
	
	[[spotifyView.view layer] addAnimation:[self createSlideInAnimation] forKey:@"fadeIn"];
	
	currentView = spotifyView.view;
	
}
- (IBAction) showSimilarArtistsView:(id) sender {
	CGRect frame = CGRectMake(120, 100, 600, 600); 
	
	SimilarArtistsViewController *similarArtistsView = [[SimilarArtistsViewController alloc] initWithNibName:@"SimilarArtistsView" bundle:nil];
	[similarArtistsView.view setFrame:frame];
	
	[self createShadowLayer:similarArtistsView.view];
	
	[currentView removeFromSuperview];
	
	[self.view addSubview:similarArtistsView.view];
	
	[[similarArtistsView.view layer] addAnimation:[self createSlideInAnimation] forKey:@"fadeIn"];
	
	currentView = similarArtistsView.view;
	currentViewType = Similar;
}
- (IBAction) showLyricsView:(id) sender {
	CGRect frame = CGRectMake(120, 100, 600, 600); 
	
	LyricsViewController *lyricsView = [[LyricsViewController alloc] initWithNibName:@"LyricsView" bundle:nil];
	[lyricsView.view setFrame:frame];
	
	[self createShadowLayer:lyricsView.view];
	
	[currentView removeFromSuperview];
	
	[self.view addSubview:lyricsView.view];
	
	[[lyricsView.view layer] addAnimation:[self createSlideInAnimation] forKey:@"fadeIn"];
	
	currentView = lyricsView.view;
	currentViewType = Lyrics;	
}

- (IBAction) showGigsView:(id)sender {
	CGRect frame = CGRectMake(120, 100, 600, 600); 
	
	GigViewController *gigView = [[GigViewController alloc] initWithNibName:@"GigView" bundle:nil];
	[gigView.view setFrame:frame];
	
	
	[currentView removeFromSuperview];
	
	[self.view addSubview:gigView.view];
	
	[[gigView.view layer] addAnimation:[self createSlideInAnimation] forKey:@"fadeIn"];

	[self createShadowLayer:gigView.view];
	
	currentView = gigView.view;
	currentViewType = Gigs;
}

- (IBAction) showSettingsView:(id)sender {
	
	SettingsViewController *settingsView = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];

	[settingsView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	
	[self presentModalViewController:settingsView animated:YES];

}


- (void)createShadowLayer:(UIView *)onView {
	UIBezierPath *path = [UIBezierPath bezierPathWithCurvedShadowForRect:onView.bounds];	
	onView.layer.shadowPath = path.CGPath;	

	onView.layer.shouldRasterize = YES;
	onView.layer.shadowColor = [UIColor blackColor].CGColor;
	onView.layer.shadowOpacity = 1.0;
	onView.layer.shadowRadius = 7.0;
	onView.layer.shadowOffset = CGSizeMake(0, 4);
	//flickrView.view.layer.shadowPath = [UIBezierPath bezierPath].CGPath;
	
}

- (CATransition *) createSlideInAnimation {
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.25];
	[animation setDelegate:self];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction
								  functionWithName:kCAMediaTimingFunctionEaseIn]];
	
	return animation;
	
}

- (void)dealloc {
    [super dealloc];
	[media release];
	[flickr release];
	[gigs release];
	[lyrics release];
	[spotifyLinks release];
	[similarArtists release];
	[currentView release];
	[share release];
	[track release];
	[artist release];
	[album release];

}


@end


