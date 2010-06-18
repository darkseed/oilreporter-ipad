//
//  DetailViewController.m
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ReportAnnotation.h"
#import "DetailViewController.h"
#import "RootViewController.h"
#import "ReportViewController.h"
#import "Report.h"
#import "Util.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation DetailViewController

@synthesize toolbar, popoverController, detailItem, detailDescriptionLabel, rootViewController, reports, mapView, storedAnnotations;

#pragma mark -
#pragma mark Object insertion

- (IBAction)insertNewObject:(id)sender {
	[rootViewController insertNewObject:sender];
}


#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(NSManagedObject *)managedObject {
    
	if (detailItem != managedObject) {
		[detailItem release];
		detailItem = [managedObject retain];
		
        // Update the view.
        [self configureView];
	}
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }		
}


- (void)configureView {
    // Update the user interface for the detail item.
    detailDescriptionLabel.text = [[detailItem valueForKey:@"timeStamp"] description];
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    barButtonItem.title = @"Reports";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
}

#pragma mark -
#pragma mark Map Annotations

- (void) showAnnotations {
  if(self.reports == nil)
    return;
  
  self.storedAnnotations = [[NSMutableArray alloc] init];
  for(Report *report in self.reports) {
    CLLocationCoordinate2D tempCoordinate;
    tempCoordinate.latitude = [[report latitude] floatValue];
    tempCoordinate.longitude = [[report longitude] floatValue];
    ReportAnnotation *annotation = [[ReportAnnotation alloc] initWithCoordinate:tempCoordinate 
                                                                   withSubtitle:[NSString stringWithFormat:@"Oil: %@ / Wetlands: %@ / Wildlife: %@", report.oil, report.wetlands, report.wildlife]
                                                                      withTitle:report.desc];
    
    [self.storedAnnotations addObject:annotation];
    [annotation release];
  }
  
  [self.mapView addAnnotations:self.storedAnnotations];
  
  [self zoomToFitMapAnnotations];

}

-(void)zoomToFitMapAnnotations
{
  if([self.mapView.annotations count] == 0)
    return;
  
  CLLocationCoordinate2D topLeftCoord;
  topLeftCoord.latitude = -90;
  topLeftCoord.longitude = 180;
  
  CLLocationCoordinate2D bottomRightCoord;
  bottomRightCoord.latitude = 90;
  bottomRightCoord.longitude = -180;
  
  for(ReportAnnotation *annotation in self.mapView.annotations) {
    topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
    topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
    
    bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
    bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
  }
  
  MKCoordinateRegion region;
  region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
  region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
  region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
  region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
  
  region = [self.mapView regionThatFits:region];
  [self.mapView setRegion:region animated:YES];
}

- (MKAnnotationView *) mapView: (MKMapView *)_mapView viewForAnnotation: (id <MKAnnotation>) annotation{
  MKPinAnnotationView *annView= [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
  
  annView.animatesDrop = YES;
  annView.canShowCallout = TRUE;
  
  // Add a detail disclosure button to the callout.
//  UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//  [rightButton addTarget:self action:@selector(showReportPopover:) forControlEvents:UIControlEventTouchUpInside];
//  for (int i = 0; i < self.reports.count; i++) {
//     rightButton.tag = i;
//  }
//  annView.rightCalloutAccessoryView = rightButton;  
  
  return annView;
}

#pragma mark -
#pragma mark View lifecycle

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  self.toolbar.tintColor = [Util colorFromRGB:@"0x0a3054"];

  self.mapView.delegate = self;
  [super viewDidLoad];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
  [popoverController release];
  [toolbar release];
	[detailItem release];
	[detailDescriptionLabel release];
  [reports release];
  [storedAnnotations release];
  [mapView release];
	[super dealloc];
}	


@end
