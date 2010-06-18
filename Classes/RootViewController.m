//
//  RootViewController.m
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ReportViewController.h"
#import "DetailViewController.h"
#import "ReportCell.h"
#import "LoadingCell.h"
#import "Report.h"
#import "Util.h"

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

@synthesize detailViewController, fetchedResultsController, managedObjectContext, reports, fetcher;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
  // Start loading the latest reports
  self.fetcher = [[ReportFetcher alloc] initWithDelegate:self];

  self.navigationController.navigationBar.tintColor = [Util colorFromRGB:@"0x0a3054"];
  self.tableView.backgroundColor = [UIColor whiteColor];
  self.clearsSelectionOnViewWillAppear = NO;
  self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                                        target:self 
                                                                                        action:@selector(reloadReports:)];
  
  NSError *error = nil;
  if (![[self fetchedResultsController] performFetch:&error]) {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
  }
}


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    self.navigationController.navigationBar.tintColor = nil;
  else
    self.navigationController.navigationBar.tintColor = [Util colorFromRGB:@"0x0a3054"];
  
  return YES;
}

#pragma mark -
#pragma mark Refreshing Reports

-(void)reloadReports:(id)sender {
  self.fetcher = [[ReportFetcher alloc] initWithDelegate:self];
}

#pragma mark -
#pragma mark ReportFetcherDelegate Methods

- (void) reportFetcherDidSucceed:(ReportFetcher *) _fetcher 
{
  if(_fetcher.isloadMore) {
    [self.reports addObjectsFromArray:_fetcher.reports];
  } else {
    [self.detailViewController.mapView removeAnnotations:self.detailViewController.storedAnnotations];
    self.detailViewController.storedAnnotations = [[NSMutableArray alloc] init];
    self.reports = _fetcher.reports;
  }

  self.detailViewController.reports = self.reports;
  [self.detailViewController showAnnotations];
  [self.tableView reloadData];
}

- (void) reportFetcherSucceed:(ReportFetcher *) fetcher 
{
  NSLog(@"Failed");
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


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
}


#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject:(id)sender {
    
    NSIndexPath *currentSelection = [self.tableView indexPathForSelectedRow];
    if (currentSelection != nil) {
        [self.tableView deselectRowAtIndexPath:currentSelection animated:NO];
    }    
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSIndexPath *insertionPath = [fetchedResultsController indexPathForObject:newManagedObject];
    [self.tableView selectRowAtIndexPath:insertionPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    detailViewController.detailItem = newManagedObject;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.reports count] + 1;
}

- (UITableViewCell *) showLoadingCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
  NSString *cellIdentifier = @"LoadingCell";
  
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
  if (cell == nil) {
    [[NSBundle mainBundle] loadNibNamed: cellIdentifier owner:self options:nil];
    cell = [[[LoadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
  
  if (indexPath.row == [self.reports count])
    return [self showLoadingCell: tableView cellForRowAtIndexPath: indexPath];
  
  static NSString *CellIdentifier = @"ReportCell";  
  ReportCell *cell = (ReportCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[ReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }

  cell.descLabel.text = [NSString stringWithFormat:@"%@\r\r", [(Report *)[self.reports objectAtIndex:indexPath.row] desc]];

  NSDateFormatter *formattedDate = [[NSDateFormatter alloc] init];
  [formattedDate setDateFormat:@"EEEE, MMMM d, yyyy"];  
  cell.metaLabel.text = [NSString stringWithFormat:@"%@", [formattedDate stringFromDate: [[self.reports objectAtIndex:indexPath.row] createdAt]]];
  [formattedDate release];
  
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  [cell setThumbnail:[[self.reports objectAtIndex:indexPath.row] thumbImage]];

  return cell;
}

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    Set the detail item in the detail view controller.
//    NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//    detailViewController.detailItem = selectedObject;    
  
  if (indexPath.row == [self.reports count]) {
    self.fetcher = [[ReportFetcher alloc] initLoadMoreWithDelegate:self
                                                     withTableView:self.tableView];
    return;
  }

  [detailViewController.mapView selectAnnotation:[detailViewController.storedAnnotations objectAtIndex:[indexPath row]]
                                        animated:YES];
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  ReportViewController *reportViewController = [[ReportViewController alloc] initWithNibName:@"ReportView" 
                                                                                      bundle:nil 
                                                                                      report:[self.reports objectAtIndex:indexPath.row]];
  reportViewController.title = @"Report";
  
  [self.navigationController pushViewController: reportViewController animated:YES];
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}    


#pragma mark -
#pragma mark Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    
  [detailViewController release];
  [fetchedResultsController release];
  [managedObjectContext release];
  [reports release];
  [fetcher release];
  [super dealloc];
}

@end
