    //
//  WebView.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 18/01/2011.
//  Copyright 2011 bitformed. All rights reserved.
//

#import "BrowserView.h"


@implementation BrowserView

@synthesize theView, activityInd, urlToLoad; 

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self gotoAddress:urlToLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (IBAction)gotoAddress:(NSString *)addr {
	
	[theView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:addr]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[activityInd startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[activityInd stopAnimating];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

	if(navigationType == UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:request.URL];
	}
	return true;
}

- (IBAction) closeView {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[super dealloc];
	[theView release];
	[urlToLoad release];
	[activityInd release];
}


@end
