//
//  GigAnnotation.h
//  SocialTunes
//
//  Created by Jared Holdcroft on 08/09/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GigAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain ) NSString *title;
@property (nonatomic, retain ) NSString *subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord andTitle:(NSString *) t;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord andTitle:(NSString *) t andSubtitle:(NSString *)st;


@end