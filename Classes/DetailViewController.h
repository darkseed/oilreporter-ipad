//
//  DetailViewController.h
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class RootViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, MKMapViewDelegate> {    
  UIPopoverController *popoverController;
  UIToolbar *toolbar;
  
  NSManagedObject *detailItem;
  UILabel *detailDescriptionLabel;
  NSMutableArray *reports;
  NSMutableArray *storedAnnotations;
  MKMapView *mapView;

  RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) NSManagedObject *detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray *reports;
@property (nonatomic, retain) NSMutableArray *storedAnnotations;

@property (nonatomic, assign) IBOutlet RootViewController *rootViewController;

- (IBAction)insertNewObject:(id)sender;
- (void) showAnnotations;
- (void) zoomToFitMapAnnotations;
@end
