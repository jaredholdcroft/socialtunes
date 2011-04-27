//
//  MKMapView+ZoomLevel.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 24/08/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
				  zoomLevel:(NSUInteger)zoomLevel
				   animated:(BOOL)animated;

@end