//
//  Report.h
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright 2010 Intridea, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Report : NSObject {
  NSString *desc;
  NSString *wildlife;
  NSString *latitude;
  NSString *longitude;
  NSString *thumbImage;
  NSString *mediumImage;
  NSString *oil;
  NSString *wetlands;
  NSDate *createdAt;
}

@property(nonatomic, retain) NSString *desc, *wildlife, *latitude, *longitude, *thumbImage, *mediumImage, *oil, *wetlands;
@property(nonatomic, retain) NSDate *createdAt;

-(id) initWithDictionary:(NSDictionary *)dict;

@end
