
#import "ReportAnnotation.h"

@implementation ReportAnnotation
@synthesize coordinate, subtitle, title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c withSubtitle:(NSString *)theSub withTitle:(NSString *)theTitle {
	coordinate = c;
	self.subtitle = theSub;
	self.title = theTitle;
	return self;
}

-(void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate {
	coordinate = newCoordinate;
}

- (void) dealloc {
  [subtitle release];
  [title release];
  [super dealloc];
}
@end