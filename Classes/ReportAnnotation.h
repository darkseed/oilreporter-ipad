//
//  ReportAnnotation.h
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ReportAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c withSubtitle:(NSString *)theSub withTitle:(NSString *)theTitle;
-(void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate;

@end
