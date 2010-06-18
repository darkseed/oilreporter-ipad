//
//  ReportCell.m
//  Mashable
//
//  Created by Brendan Lim on 4/14/10.
//  Copyright 2010 Intridea. All rights reserved.
//

#import "ReportCell.h"
#import "EGOImageView.h"
#import "Util.h"

@implementation ReportCell

@synthesize metaLabel, descLabel, thumbView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    thumbView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"missing.png"]];
    thumbView.frame = CGRectMake(10, 14, 50, 50);
    
    CALayer *layer = [thumbView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0];
    
    self.metaLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 7, 230, 24)];
    [self.metaLabel setOpaque:NO];
    [self.metaLabel setBackgroundColor:[UIColor clearColor]];
		[self.metaLabel setTextAlignment:UITextAlignmentLeft];
    [self.metaLabel setFont:[UIFont fontWithName:@"American Typewriter" size:12.0]];
    [self.metaLabel setTextColor:[UIColor darkGrayColor]];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 27, 228, 40)];
    [self.descLabel setOpaque:NO];
		[self.descLabel setTextAlignment:UITextAlignmentLeft];
    [self.descLabel setFont:[UIFont fontWithName:@"American Typewriter" size:14.0]];
    [self.descLabel setTextColor:[Util colorFromRGB:@"1x222222"]];
    [self.descLabel setBackgroundColor:[UIColor clearColor]];
    [self.descLabel setLineBreakMode:UILineBreakModeTailTruncation];
    [self.descLabel setNumberOfLines:4];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    [self.contentView addSubview:self.thumbView];
    [self.contentView addSubview:self.metaLabel];
    [self.contentView addSubview:self.descLabel];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIImageView *cellBack = [[UIImageView alloc] init];

  if(selected) {
    [cellBack setImage:[UIImage imageNamed:@"bg_selected.png"]];  
    [self.descLabel setTextColor:[UIColor whiteColor]];
    [self.metaLabel setTextColor:[UIColor whiteColor]];
  } else {
    [cellBack setImage:[UIImage imageNamed:@"bg.png"]];  
    [self.descLabel setTextColor:[Util colorFromRGB:@"1x222222"]];
    [self.metaLabel setTextColor:[UIColor darkGrayColor]];
  }

	[self setBackgroundView:cellBack];
	[cellBack release];		
  
  [super setSelected:selected animated:animated];
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  UIImageView *cellBack = [[UIImageView alloc] init];

  if(highlighted) {
    [cellBack setImage:[UIImage imageNamed:@"bg_selected.png"]];  
    [self.descLabel setTextColor:[UIColor whiteColor]];
    [self.metaLabel setTextColor:[UIColor whiteColor]];
  } else {
    [cellBack setImage:[UIImage imageNamed:@"bg.png"]];  
    [self.descLabel setTextColor:[Util colorFromRGB:@"1x222222"]];
    [self.metaLabel setTextColor:[UIColor darkGrayColor]];
  }
  
  [self setBackgroundView:cellBack];
	[cellBack release];		
  
  [super setHighlighted:highlighted animated:animated];
}

- (void)setThumbnail:(NSString*)thumbUrl {
	thumbView.imageURL = [NSURL URLWithString:thumbUrl];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if(!newSuperview) {
		[thumbView cancelImageLoad];
	}
}

- (void)dealloc {
  [metaLabel release];
  [descLabel release];
  [super dealloc];
}


@end
