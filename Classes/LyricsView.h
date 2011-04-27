//
//  LyricsViewController.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 29/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#include "HTTPRiot.h"

@interface LyricsViewController : UIViewController {	
	UILabel *lyricsLabel;
	UIWebView *lyricsView;

}

@property (nonatomic, retain) IBOutlet UILabel *lyricsLabel;
@property (nonatomic, retain) IBOutlet UIWebView *lyricsView;

@end
