//
//  GigViewController.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 31/05/2010.
//  Copyright 2010 Bitformed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKMapView-ZoomLevel.h"
#import "MBProgressHUD.h"
#import "GigAnnotation.h"
#import "LastFMGigsRestRequest.h"
#import "SimilarArtistsView.h"

@interface GigViewController : UIViewController <CLLocationManagerDelegate, MBProgressHUDDelegate> {
	
	MKMapView *mapView;
	CLLocationManager *locationMgr;
	MBProgressHUD *HUD;
	CLLocation *myLocation;

}

@property (nonatomic, retain) IBOutlet MKMapView * mapView;
@property (nonatomic, retain) CLLocationManager * locationMgr;
@property (nonatomic, retain) CLLocation *myLocation;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end
