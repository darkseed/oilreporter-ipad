//
//  ReportViewController.h
//  OilReporter
//
//  Created by Brendan Lim on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Report.h"
#import "EGOImageView.h"
#import <QuartzCore/QuartzCore.h> 

@interface ReportViewController : UIViewController {
  Report *report;
  IBOutlet UITextView *desc;
  IBOutlet EGOImageView *image;
}

@property(nonatomic, retain) Report *report;
@property(nonatomic, retain) IBOutlet UITextView *desc;
@property(nonatomic, retain) IBOutlet EGOImageView *image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil report:(Report *)theReport;

@end
