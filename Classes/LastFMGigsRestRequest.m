//
//  LyricsFlyRestRequest.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 23/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import "LastFMGigsRestRequest.h"


@implementation LastFMGigsRestRequest
		
- (id)init {
	self = [super init];
	
	// Set LAST.fm base URL
	[[self class] setBaseURL:[NSURL URLWithString:@"http://ws.audioscrobbler.com"]];    

	// Set response format
    [[self class] setFormat:HRDataFormatXML];
	
	return self;
}

- (id)fetchEvents:(id)object atLocation:(CLLocation *)location withinDistance:(NSString *)distance {

	NSString *url = [NSString stringWithFormat:@"/2.0/?method=geo.getevents&api_key=%@&lat=%f&long=%f&distance=%@", LASTFM_API_KEY,
					location.coordinate.latitude, location.coordinate.longitude, distance]	;
	
	[[self class] getPath:url 
			  withOptions:nil object:object];
	return self;  
}

- (id)processResult:(id)resource with:(NSObject<RestRequestDelegate>*)object {
	NSLog(@"[API] Returned resource [%@] %@ ",[resource class], resource);
	[object restRequestSuccess:resource];  
	
	return self;
}
- (id)processFailure:(NSString *)error code:(id)code with:(NSObject<RestRequestDelegate>*)object {
	return self;
}	

@end
