//
//  LyricsFlyRestModel.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 22/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "HTTPRiot.h"
@protocol RestRequestDelegate;

@interface BaseRestModel : HRRestModel <HRResponseDelegate> {
	NSString *baseURL;
	NSString *http_username;
	NSString *http_password;
}

@property (nonatomic,retain) NSString *baseURL;
@property (nonatomic,retain) NSString *http_username;
@property (nonatomic,retain) NSString *http_password;

- (id)initWithUsername:(NSString*)username password:(NSString*)password;
- (id)processResult:(id)resource with:(NSObject<RestRequestDelegate>*)object;
- (id)processFailure:(NSString *)error code:(id)code with:(NSObject<RestRequestDelegate>*)object;
@end

@protocol RestRequestDelegate 
- (void)restRequestFailure:(id)code message:(id)message;
- (void)restRequestSuccess:(id)results;
@end	