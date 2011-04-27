//
//  GigAnnotation.m
//  SocialTunes
//
//  Created by Jared Holdcroft on 08/09/2010.
//  Copyright 2010 Home. All rights reserved.
//

#import "GigAnnotation.h"

static NSString* const GIG_ANNOTATION_SELECTED = @"gigAnnotationSelected";

@implementation GigAnnotation

@synthesize coordinate, title, subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
	
	[self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:GIG_ANNOTATION_SELECTED];

	return self;

}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord andTitle:(NSString *) t 
{
	coordinate = coord;
	title = t;
	[self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:GIG_ANNOTATION_SELECTED];
	
	return self;
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord andTitle:(NSString *) t andSubtitle:(NSString *)st
{
	coordinate = coord;
	title = t;
	subtitle = st;
	[self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:GIG_ANNOTATION_SELECTED];
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	NSString* action = (NSString*)context;
	
	if([action isEqualToString:GIG_ANNOTATION_SELECTED]) {
		BOOL annotationAppeared = [[change valueForKey:@"new"] boolValue];
		// Do Something
		NSLog(@"Annotation pressed");
	}
}


@end