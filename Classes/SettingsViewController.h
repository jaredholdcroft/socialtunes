//
//  SettingsViewController.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 30/09/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	
	UIImageView *lastFMImage;

}

@property (nonatomic, retain) IBOutlet UIImageView *lastFMImage;

- (IBAction) closeView ;

- (IBAction) viewLastFM:(id)sender;

@end
