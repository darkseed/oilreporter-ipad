    //
//  ReportViewController.m
//  OilReporter
//
//  Created by Brendan Lim on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"


@implementation ReportViewController
@synthesize desc, report, image;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil report:(Report *)theReport {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    self.report = theReport;
  }
  return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  
  // Background view
  UIImageView *cellBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 579, 1013)];
  [cellBack setImage:[UIImage imageNamed:@"graph_paper.png"]];  
  [self.view addSubview:cellBack];
  [cellBack release];	
  
  // Description view
  self.desc = [[UITextView alloc] initWithFrame:CGRectMake(16, 44, 280, 330)];
  self.desc.text = [NSString stringWithFormat:@"%@\n\nAmount of Oil:             %@/10\nImpact to Wetlands:   %@/10\n\nWildlife:\n%@", self.report.desc, self.report.oil, self.report.wetlands, self.report.wildlife];
  self.desc.font = [UIFont fontWithName:@"American Typewriter" size:18.0];
  self.desc.backgroundColor = [UIColor clearColor];
  self.desc.editable = NO;
  
  // Date view
  UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(24, 20, 280, 24)];
  date.font = [UIFont fontWithName:@"American Typewriter" size:13.0];
  date.opaque = NO;
  date.backgroundColor = [UIColor clearColor];
  date.textColor = [UIColor darkGrayColor];
  date.numberOfLines = 1;
  NSDateFormatter *formattedDate = [[NSDateFormatter alloc] init];
  [formattedDate setDateFormat:@"EEEE, MMMM d, yyyy"];  
  date.text = [NSString stringWithFormat:@"%@", [formattedDate stringFromDate: self.report.createdAt]];
  [formattedDate release];
  
  // Image view
  if(self.report.mediumImage != nil) {
    self.image = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"missing.png"]];
    self.image.frame = CGRectMake(20, 20, 280, 280);
    self.image.imageURL = [NSURL URLWithString:self.report.mediumImage];
    
    CALayer *layer = [self.image layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
    
    self.desc.frame = CGRectMake(16, 44+290, 280, 320);
    date.frame      = CGRectMake(24, 20+290, 280, 24);
    [self.view addSubview:self.image];
  }
  
  [self.view addSubview:self.desc];
  [self.view addSubview:date];

  [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [report dealloc];
  [image dealloc];
  [desc dealloc];
  [super dealloc];
}


@end
