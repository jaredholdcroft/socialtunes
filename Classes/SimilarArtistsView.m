    //
//  SimilarArtistsViewController.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import "SimilarArtistsView.h"

@implementation SimilarArtistsViewController

@synthesize artistsTable, similarArtists;
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
	
	spotifyEngine = [[JHSpotifyEngine alloc] initWithDelegate:self];
	
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	similarArtists = [bigDaddy.sharedData valueForKey:@"SIMILAR_ARTIST_ARRAY"] ;	
	
	[artistsTable reloadData];
	
}	

#pragma mark JHSE Delegate implementation

- (void) requestSucceeded:(NSString *)response
{
	NSLog(@"Spotify lookup succeeded");
	//[responseXML setStringValue:response];
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
	NSLog(@"Spotify lookup failed! :: %@", [error description]);
}

- (void)connectionFinished:(NSString *)connectionIdentifier
{
    NSLog(@"Spotify lookup connection finished %@", connectionIdentifier);
	
}

- (void)artistsReceived:(NSArray *)artists forRequest:(NSString *)connectionIdentifier
{
	if(artists.count > 0) {
		NSMutableDictionary* spotifyInfo = [artists objectAtIndex:0];
	
		NSString *href1 = [spotifyInfo objectForKey:@"href"];
	
		NSString *href2 = [href1 stringByReplacingOccurrencesOfString:@"spotify:artist:" withString:@"http://open.spotify.com/artist/"];
	
		[self showWebViewWithURL:href2];
	}
	
}

- (void)albumsReceived:(NSArray *)artists forRequest:(NSString *)connectionIdentifier
{
	// Not in use
	
}

- (void)tracksReceived:(NSArray *)artists forRequest:(NSString *)connectionIdentifier
{
	// Not in use	
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)secton {
	return similarArtists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdent = @"MyIdent";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdent];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdent] autorelease];
	}
	
	NSString* artist = [similarArtists objectAtIndex:indexPath.row];
	
	UIImage *icon = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"spotify28" ofType:@"png"]];
	
	cell.accessoryView = [[[UIImageView alloc] initWithImage:icon] autorelease];
	
	//cell.imageView.image = icon;
	[cell.textLabel setText:artist];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString* artist = [similarArtists objectAtIndex:indexPath.row];
	
	[spotifyEngine searchArtist:artist];
	
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

- (void) showWebViewWithURL:(NSString *)url {
	
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	BrowserView *webView = [[BrowserView alloc] initWithNibName:@"BrowserView" bundle:nil];
	
	[webView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	
	webView.urlToLoad = url;
	
	[bigDaddy.viewController presentModalViewController:webView animated:YES];
	
	//[webView release];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
	[artistsTable release];
	[similarArtists release];
	[spotifyEngine release];
}

@end
