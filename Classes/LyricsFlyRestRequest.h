	//
//  LyricsFlyRestRequest.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 23/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRestModel.h"
#import "SocialTunesAppDelegate.h"


@interface LyricsFlyRestRequest : BaseRestModel {
	
}

- (id)fetchLyrics:(id)object;

@end