//
//  LyricsFlyRestRequest.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 23/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import "LyricsFlyRestRequest.h"


@implementation LyricsFlyRestRequest
	
- (id)init {
	self = [super init];
	
	// Set Lyricsfly base URL
	// http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?artist=string&song=string
	[[self class] setBaseURL:[NSURL URLWithString:@"http://api.chartlyrics.com/apiv1.asmx/"]];    

	// Set response format
    [[self class] setFormat:HRDataFormatXML];
	
	return self;
}

- (id)fetchLyrics:(id)object {
	
	SocialTunesAppDelegate *bigDaddy = (SocialTunesAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	NSString* currentArtist = [[bigDaddy.sharedData valueForKey:@"CURRENT_ARTIST"] 
							   stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	
	NSString* currentTrack = [[bigDaddy.sharedData valueForKey:@"CURRENT_TRACK"] 
							  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	
	NSString* lyricsFlyURL = [NSString stringWithFormat:@"SearchLyricDirect?artist=%@&song=%@", currentArtist, currentTrack ];
	
	[[self class] getPath:lyricsFlyURL 
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
