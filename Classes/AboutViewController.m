    //
//  AboutViewController.m
//  OilReporter
//
//  Created by Brendan Lim on 6/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController
@synthesize desc;

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
  self.desc = [[UITextView alloc] initWithFrame:CGRectMake(16, 55, 510, 330)];
  self.desc.text = @"Oil Reporter was built by Intridea for the Gulf of Mexico Oil Spill for CrisisCommons. On April 20, 2010, an explosion occurred on the semi-submersible offshore drilling rig Deepwater Horizon in the Gulf of Mexico killing 11 rig workers and injuring 17 others. On April 24, it was found that the wellhead was damaged and was leaking oil into the Gulf. Oil Reporter for iPad allows users to see the reports that are coming in from the iPhone and Android Oil Reporter applications in real time.\n\nCrisis Commons is an international volunteer network of technical and business professionals drawn together by a call to service. They create technological tools and resources for responders to use in mitigating disasters and crises around the world. CrisisCamps are efforts by local communities to garner the collective skills of volunteers, particularly technology related, to support relief efforts during crises, such as natural disasters. Most recently, CrisisCamps have been active in supporting relief efforts following the earthquake in Haiti.";
  self.desc.font = [UIFont fontWithName:@"American Typewriter" size:16.0];
  self.desc.backgroundColor = [UIColor clearColor];
  self.desc.editable = NO;
  
  
  UIButton *intrideaButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 398, 251, 77)];
  [intrideaButton setImage:[UIImage imageNamed:@"built_by_intridea_big.png"] forState:UIControlStateNormal];
  [intrideaButton addTarget:self action:@selector(launchIntridea:) forControlEvents:UIControlEventTouchUpInside];
  
  UITextView *contact = [[UITextView alloc] initWithFrame:CGRectMake(10, 474, 510, 40)];
  contact.text = @"Phone: 1-888-968-IDEA (4332)\nE-Mail: info@intridea.com";
  contact.font = [UIFont fontWithName:@"American Typewriter" size:12.0];
  contact.textAlignment = UITextAlignmentCenter;
  contact.backgroundColor = [UIColor clearColor];
  contact.editable = NO;
  
  
  UIButton *ccButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 530, 251, 77)];
  [ccButton setImage:[UIImage imageNamed:@"crisis_commons.png"] forState:UIControlStateNormal];
  [ccButton addTarget:self action:@selector(launchCrsis:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:intrideaButton];
  [self.view addSubview:contact];
  [self.view addSubview:ccButton];
  [self.view addSubview:self.desc];
  
  [contact release];
  [ccButton release];
  [intrideaButton release];
  [super viewDidLoad];
}

-(IBAction) launchIntridea:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://intridea.com"]];

}

-(IBAction) launchCrisis:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://crisiscommons.org"]];
}

-(IBAction) dismiss:(id)sender {
  [self dismissModalViewControllerAnimated:YES];
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
  [desc release];
  [super dealloc];
}


@end
