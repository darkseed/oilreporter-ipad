//
//  LoadingCell.m
//  OilReporter
//
//  Created by Brendan Lim on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoadingCell.h"


@implementation LoadingCell
@synthesize textLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
      self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
      [self.textLabel setOpaque:NO];
      [self.textLabel setBackgroundColor:[UIColor clearColor]];
      [self.textLabel setTextAlignment:UITextAlignmentCenter];
      [self.textLabel setFont:[UIFont fontWithName:@"American Typewriter" size:20.0]];
      [self.textLabel setTextColor:[UIColor darkGrayColor]];
      [self.textLabel setText:@"Load More Reports"];

      [self.contentView addSubview:self.textLabel];
    }

    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIImageView *cellBack = [[UIImageView alloc] init];
  
  if(selected) {
    [cellBack setImage:[UIImage imageNamed:@"bg_selected.png"]];  
    [self.textLabel setTextColor:[UIColor whiteColor]];
  } else {
    [cellBack setImage:[UIImage imageNamed:@"bg.png"]];  
    [self.textLabel setTextColor:[UIColor darkGrayColor]];
  }
  
	[self setBackgroundView:cellBack];
	[cellBack release];		
  
  [super setSelected:selected animated:animated];
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  UIImageView *cellBack = [[UIImageView alloc] init];
  
  if(highlighted) {
    [cellBack setImage:[UIImage imageNamed:@"bg_selected.png"]];  
    [self.textLabel setTextColor:[UIColor whiteColor]];
  } else {
    [cellBack setImage:[UIImage imageNamed:@"bg.png"]];  
    [self.textLabel setTextColor:[UIColor darkGrayColor]];
  }
  
  [self setBackgroundView:cellBack];
	[cellBack release];		
  
  [super setHighlighted:highlighted animated:animated];
}

- (void)dealloc {
    [super dealloc];
}


@end
