//
//  ReportCell.h
//
//  Created by Brendan Lim on 4/14/10.
//  Copyright 2010 Intridea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> 

@class EGOImageView;
@interface ReportCell : UITableViewCell {
  UILabel *metaLabel;
  UILabel *descLabel;
 	EGOImageView* thumbView;
}

@property (nonatomic, retain) UILabel *metaLabel;
@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) EGOImageView *thumbView;

- (void)setThumbnail:(NSString*)thumbUrl;

@end
