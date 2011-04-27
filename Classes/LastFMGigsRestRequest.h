	//
//  LyricsFlyRestRequest.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 23/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "BaseRestModel.h"

#define LASTFM_API_KEY @"d354795613ba310e095fb6fe21fbce31"
#define LASTFM_SECRETK @"bc4bb96135265a86e82405b5481bf2e8"

@interface LastFMGigsRestRequest : BaseRestModel  {
	
}

//- (id)fetch:(id)object withOptions:(NSDictionary *)options;
- (id)fetchEvents:(id)object atLocation:(CLLocation *)location withinDistance:(NSString *)distance ;

@end