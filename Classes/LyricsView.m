    //
//  LyricsViewController.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import "LyricsView.h"
#import "LyricsFlyRestRequest.h"


@implementation LyricsViewController

@synthesize lyricsLabel, lyricsView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark -
#pragma mark Override viewDidLoad
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	LyricsFlyRestRequest* req = [[LyricsFlyRestRequest alloc] init];
	[req fetchLyrics:self];
    
}	

- (void)restRequestFailure:(id)code message:(id)message {
	NSLog(@"We could net reach ChartLyrics");
	[self.lyricsView loadHTMLString:[NSString stringWithFormat:@"<html><body><p style=\"font-family:helvetica; font-size:large;\">No Lyrics found for this track. Try uploading them at ChartLyrics.com</p></body></html>"] baseURL:nil];
	
}

- (void)restRequestSuccess:(id)results {
	
	NSLog(@"We have lyrics");
	
	NSDictionary* root = [results objectForKey:@"GetLyricResult"];
	@try {
		
		NSString* lyricsText = [[NSString alloc] initWithString:[root objectForKey:@"Lyric"]];
	
		if(lyricsText.length == 0) {
			[self.lyricsView loadHTMLString:[NSString stringWithFormat:@"<html><body><p style=\"font-family:helvetica; font-size:large;\">No Lyrics found for this track. Try uploading them at ChartLyrics.com</p></body></html>"] baseURL:nil];
		} else {
	
			NSString* editedLyricsText = [lyricsText stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
			editedLyricsText = [editedLyricsText stringByReplacingOccurrencesOfString:@"\r" withString:@"<br/>"];
	
			[self.lyricsView loadHTMLString:[NSString stringWithFormat:@"%@ %@ %@", @"<html><body><p style=\"font-family:helvetica; font-size:medium;\">", editedLyricsText, @"</p></body></html>"] baseURL:nil];
		}
	}
	@catch (NSException * e) {
		[self.lyricsView loadHTMLString:[NSString stringWithFormat:@"<html><body><p style=\"font-family:helvetica; font-size:large;\">No Lyrics found for this track. Try uploading them at ChartLyrics.com</p></body></html>"] baseURL:nil];
	}
	
}	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
	[lyricsLabel release];
	[lyricsView release];
}


@end
