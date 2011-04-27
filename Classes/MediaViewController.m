    //
//  MediaViewController.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import "MediaViewController.h"


@implementation MediaViewController

@synthesize iPod, artwork, lockUnlock;

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
	locked = FALSE;
	
	if ([self reachable]) {
		NSLog(@"Reachable");
		self.iPod = [MPMusicPlayerController iPodMusicPlayer];
		
		similarArtists = [[NSMutableArray alloc] init];
	    
		// Initial sync of display with music player state
		[self handleNowPlayingItemChanged:nil];
		
		// Register for music player notifications
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self 
							   selector:@selector(handleNowPlayingItemChanged:)
								   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification 
								 object:self.iPod];
		
		[self.iPod beginGeneratingPlaybackNotifications];
		
		[self fetchSimilarArtists];
		
	}
	else {
		NSLog(@"Not Reachable");
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"No Network" 
														 message:@"Social Tunes requires a network connection to fetch all that lovely metadata" 
														delegate:self cancelButtonTitle:@"Booooooo" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	
    

}	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

#pragma mark -
#pragma mark Fetch similar artists HTTP
// Push this into this code so I can call MBProgressHUD
- (void)fetchSimilarArtists {
	NSLog(@"Fetching artists...");
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	NSString* currentArtist = [[bigDaddy.sharedData valueForKey:@"CURRENT_ARTIST"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
	
	// Can't use this as the HTTPRiot XML -> Dictionary code borks when the attr and child tag are the same
	//LastFMArtistsRestRequest* req = [[LastFMArtistsRestRequest alloc] init];
	//[req fetchArtists:self basedOn:currentArtist butOnlyThisMany:@"10"];
	
	// Create the request.
	NSString *similarURL = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/artist/%@/similar.txt",
							currentArtist];
	
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:similarURL]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	[theConnection start];
	if (theConnection) {
		// Create the NSMutableData to hold the received data.
		// receivedData is an instance variable declared elsewhere.
		theResponse = [[NSMutableData data] retain];
	} else {
		// Inform the user that the connection failed.
		
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	// This method is called when the server has determined that it
	// has enough information to create the NSURLResponse.
	
	// It can be called multiple times, for example in the case of a
	// redirect, so each time we reset the data.
	
	// receivedData is an instance variable declared elsewhere.
	[theResponse setLength:0];
}		

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	// Append the new data to receivedData.
	// receivedData is an instance variable declared elsewhere.
	[theResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[theResponse length]);
	
	NSString* csvData = [[NSString alloc] initWithData:theResponse encoding:NSUTF8StringEncoding];
	
	NSArray *csvRows = [csvData componentsSeparatedByString:@"\n"];
	
	
	
	for (id csvRow in csvRows) {
		if([csvRow length] > 4) {
			NSString *theArtist = [[[csvRow componentsSeparatedByString:@","] objectAtIndex:2] stringByConvertingHTMLToPlainText];
			
			[similarArtists addObject:theArtist];
		}
		
	}
	
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	[bigDaddy.sharedData setObject:similarArtists forKey:@"SIMILAR_ARTIST_ARRAY"] ;
	
	// release the connection, and the data object
    [connection release];
    [theResponse release];
	NSLog(@"Artists recieved: %d", similarArtists.count);
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [theResponse release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %		@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:@""]);
}	

- (void)hudWasHidden {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
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

#pragma mark -
#pragma mark Media player notification handlers

// When the now playing item changes, update song info labels and artwork display.
- (void)handleNowPlayingItemChanged:(id)notification {
	
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];

    // Ask the music player for the current song.
    MPMediaItem *currentItem = self.iPod.nowPlayingItem;
	
	if(currentItem != nil) {
	
		// Display the artist, album, and song name for the now-playing media item.
		// These are all UILabels.
		bigDaddy.viewController.track.text = [currentItem valueForProperty:MPMediaItemPropertyTitle];
		bigDaddy.viewController.artist.text = [currentItem valueForProperty:MPMediaItemPropertyArtist];
		bigDaddy.viewController.album.text  = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];    
	
		[bigDaddy.sharedData setObject:bigDaddy.viewController.track.text forKey:@"CURRENT_TRACK"] ;
		[bigDaddy.sharedData setObject:bigDaddy.viewController.artist.text forKey:@"CURRENT_ARTIST"] ;
		[bigDaddy.sharedData setObject:bigDaddy.viewController.album.text forKey:@"CURRENT_ALBUM"] ;
		
		// Display album artwork. self.artworkImageView is a UIImageView.
		CGSize artworkImageViewSize = self.artwork.bounds.size;
		MPMediaItemArtwork *artworkItem = [currentItem valueForProperty:MPMediaItemPropertyArtwork];
		if (artworkItem != nil) {
			self.artwork.image = [artworkItem imageWithSize:artworkImageViewSize];
		} else {
			self.artwork.image = nil;
		}
		
		// Lock this track in place
		[self.iPod endGeneratingPlaybackNotifications];
		locked = TRUE;
		
		[bigDaddy.viewController.gigs setEnabled:YES];
		[bigDaddy.viewController.lyrics setEnabled:YES];
		[bigDaddy.viewController.similarArtists setEnabled:YES];
		
	} else {
		bigDaddy.viewController.artist.text = @"";
		bigDaddy.viewController.album.text = @"";
		bigDaddy.viewController.track.text = @"";
		
		UIAlertView* alertView = [[UIAlertView alloc] 
								  initWithTitle:@"No media!" message:@"Please select a song in iPod.app and try again..." delegate:self 
								  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		
		[bigDaddy.viewController.gigs setEnabled:NO];
		[bigDaddy.viewController.lyrics setEnabled:NO];
		[bigDaddy.viewController.similarArtists setEnabled:NO];
	}
}

- (void)lockAndUnlockArtist {
	if (locked) {
		[self.iPod beginGeneratingPlaybackNotifications];
	} else {
		[self.iPod endGeneratingPlaybackNotifications];
	}
	
}

- (BOOL)reachable {
    Reachability *r = [Reachability reachabilityWithHostName:@"apple.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(internetStatus == NotReachable) {
        return NO;
    }
    return YES;
}

- (void)dealloc {
    [super dealloc];
	[theResponse release];
	[artwork release];
	[HUD release];
	[iPod release];
	[similarArtists release];
}


@end
