//
//  AboutViewController.h
//  OilReporter
//
//  Created by Brendan Lim on 6/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController {
  UITextView *desc;
}

@property(nonatomic, retain) IBOutlet UITextView *desc;

-(IBAction) dismiss:(id)sender;
-(IBAction) launchIntridea:(id)sender;
-(IBAction) launchCrisis:(id)sender;

@end
