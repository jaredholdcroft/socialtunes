    //
//  GigViewController.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 31/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import "GigViewController.h"



@implementation GigViewController

@synthesize mapView, locationMgr, myLocation;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.locationMgr = [[CLLocationManager alloc] init];
	self.locationMgr.delegate = self;
	self.locationMgr.desiredAccuracy = kCLLocationAccuracyKilometer;
	self.locationMgr.distanceFilter = 10; // or whatever
	[self.locationMgr startUpdatingLocation];
	
}		

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"Location: %@", [newLocation description]);

	CLLocationCoordinate2D centerCoord = { newLocation.coordinate.latitude, newLocation.coordinate.longitude };
    [mapView setCenterCoordinate:centerCoord zoomLevel:7 animated:YES];
	
	myLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
	
	
	// Should be initialized with the windows frame so the HUD disables all user input by covering the entire screen
	HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
	
	// Add HUD to screen
	[self.view.window addSubview:HUD];
	
	// Regisete for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
	
	HUD.labelText = @"Loading";
	
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:@selector(fetchNearbyEvents) onTarget:self withObject:nil animated:YES];
	
}

// Push this into this code so I can call MBProgressHUD
- (void)fetchNearbyEvents {
	LastFMGigsRestRequest* req = [[LastFMGigsRestRequest alloc] init];
	[req fetchEvents:self atLocation:myLocation withinDistance:@"100"];
	//[req release];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Error: %@", [error description]);
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
	[mapView release];
	[locationMgr release];
	[myLocation release];
}

- (void)restRequestFailure:(id)code message:(id)message {
	NSLog(@"No Gigs found");
	[HUD removeFromSuperview];
	[HUD release];
}

- (void)restRequestSuccess:(id)results {

	//NSDictionary* root = results;
	
	NSDictionary* root = [results objectForKey:@"lfm"];
	NSDictionary* eventsRoot = [root objectForKey:@"events"];
	
	NSArray* events = [eventsRoot objectForKey:@"event"];
	
	NSEnumerator *enumerator = [events objectEnumerator];
	id obj;
	
	while ((obj = (NSDictionary*) [enumerator nextObject])) {
		
		NSDictionary* artists = [obj objectForKey:@"artists"];
		
		NSString* artistName = [[NSString alloc] initWithString:[artists objectForKey:@"headliner"]];
			
		NSDictionary* venue = [obj objectForKey:@"venue"];
		NSDictionary* location = [venue objectForKey:@"location"];
		NSDictionary* point = [location objectForKey:@"point"];
		
		NSString* venueName = [	[NSString alloc] initWithString:[venue objectForKey:@"name"]];
		
		NSString* lat = [point valueForKey:@"lat"];
		NSString* lng = [point valueForKey:@"long"];
			
		CLLocationCoordinate2D coordinate;
		
		coordinate.latitude = [lat doubleValue]	;
		coordinate.longitude= [lng doubleValue] ;
		
		GigAnnotation * annotation = [[GigAnnotation alloc] 
									  initWithCoordinate:coordinate andTitle:artistName andSubtitle:venueName];
		[self.mapView addAnnotation:annotation];
		
	}
	[HUD removeFromSuperview];
	[HUD release];
		
}

- (void)hudWasHidden {
	// Remove HUD from screen when the HUD was hidded
//	[HUD removeFromSuperview];
//	[HUD release];
}


@end
