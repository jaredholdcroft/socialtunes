//
//  LyricsFlyRestModel.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 22/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import "BaseRestModel.h"


@implementation BaseRestModel

@synthesize baseURL;
@synthesize http_username;
@synthesize http_password;

- (void) dealloc {
	[baseURL release];
	[http_username release];
	[http_password release];
	[super dealloc];
}

- (id)init {
    //We set ourself as the delegate to reduce code duplication. 
    //This can be overriden in sub-classes if required.    
    [[self class] setDelegate:self];
    //Set your base URL here. In my case this doesn't change.
    //This can be overriden in sub-classes if required.    
    [[self class] setBaseURL:[NSURL URLWithString:@"http://localhost:3000"]];    
    //I use JSON, set to XML if necessary.    
    [[self class] setFormat:HRDataFormatJSON];
    return self;
}
- (id)initWithUsername:(NSString*)username password:(NSString*)password {
	
	if (self = [super init]) {
		[self init];
		//Set us up to use Basic Auth for all requests.
		[[self class] setBasicAuthWithUsername:username password:password];
	}
	return self;
}

/**
 ** We require the object parameter to implement the RestRequestDelegate, this insures that our app
 ** is capable of responding to the restRequestSuccess method.
 **/
- (id)processResult:(id)resource with:(NSObject<RestRequestDelegate>*)object {
	//This just passes the result on to the passed in object.
	NSLog(@"noop");
	[object restRequestSuccess:resource];
	return nil;
}
/**
 ** We require the object parameter to implement the RestRequestDelegate, this insures that our app
 ** is capable of responding to the restRequestFailure method.
 **/
- (id)processFailure:(NSString *)error code:(id)code with:(NSObject<RestRequestDelegate>*)object{
	//This just passes the failure on to the passed in object.
	NSLog(@"noop");
	[object restRequestFailure:code message:error];
	return nil;
}
#pragma httpriot method definitions
/** For simplicity I handle starting/stopping the network activity indicator
 here in the base class. This keeps me from having to worry about it in each
 place that I make a request.
 **/
- (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource  object:(id)object {
	NSLog(@"[API] Returned resource [%@] %@ ",[resource class], resource);
	[self processResult:resource with:object];
}

- (void)restConnection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response object:(id)object {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	NSURL *url = [response URL];
	NSString *urlStr = [url absoluteString];
	NSLog(@"[API] Received response (code %i) URL: %@", [response statusCode], urlStr);
}

- (void)restConnection:(NSURLConnection *)connection didReceiveError:(NSError *)error response:(NSHTTPURLResponse *)response object:(id)object {
	//Recieved a bad status code 404, 500, etc.
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSURL *url = [response URL];
	NSString *urlStr = [url absoluteString];
	NSString *code = [NSString stringWithFormat:@"%i", [error code]];
	NSLog(@"[API] Error (code %i) URL: %@", [error code], urlStr);
	
	NSString *message = [NSString stringWithFormat:@"Sorry, the server is temporarily experiencing technical difficulties (code %i).", [error code]];
	[self processFailure:message code:(id)code with:object];
}

- (void)restConnection:(NSURLConnection *)connection didReceiveParseError:(NSError *)error responseBody:(NSString *)string object:(id)object{
	
	NSLog(@"[API] Parse error (code %i): %@", [error code], error);
	NSLog(@"[API] Response Body: %@", string);
	NSString *code = [NSString stringWithFormat:@"%i", [error code]];
	NSString *message = [NSString stringWithFormat:@"Sorry, the server is temporarily experiencing technical difficulties (format error)."];
	[self processFailure:message code:code with:object];
}


- (void)restConnection:(NSURLConnection *)connection didFailWithError:(NSError *)error object:(id)object {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"[API] Error getting connection: code: %i", [error code]);
	NSString *message = [NSString stringWithFormat:@"Sorry, the server is temporarily experiencing technical difficulties (code %i).", [error code]];
	NSString *code = [NSString stringWithFormat:@"%i", [error code]];
	[self processFailure:message code:code with:object];
}
@end