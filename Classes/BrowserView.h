//
//  WebView.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 18/01/2011.
//  Copyright 2011 bitformed. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrowserView : UIViewController <UIWebViewDelegate> {

	UIWebView* theView;
	UIActivityIndicatorView* activityInd;
	
	NSString *urlToLoad;
}

@property (nonatomic, retain) IBOutlet UIWebView* theView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityInd;
@property (nonatomic, retain) NSString *urlToLoad;

- (IBAction)gotoAddress:(NSString *)addr;
- (IBAction)closeView ;

@end
