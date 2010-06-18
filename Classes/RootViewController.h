//
//  RootViewController.h
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ReportFetcher.h"

@class Report;
@class DetailViewController;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate, ReportFetcherDelegate> {
  
  DetailViewController *detailViewController;
  ReportFetcher *fetcher;
  UIActivityIndicatorView *activityIndicator;
  NSFetchedResultsController *fetchedResultsController;
  NSManagedObjectContext *managedObjectContext;
  NSMutableArray *reports;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@property (nonatomic, retain) ReportFetcher *fetcher;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSMutableArray *reports;

- (void)insertNewObject:(id)sender;
- (UITableViewCell *) showLoadingCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath;
- (void)reloadReports:(id)sender;

@end
