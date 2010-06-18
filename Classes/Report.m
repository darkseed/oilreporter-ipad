//
//  Report.m
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright 2010 Intridea, Inc. All rights reserved.
//

#import "Report.h"
#import "CJSONDeserializer.h"

@implementation Report

@synthesize desc, latitude, longitude, wildlife, oil, wetlands, thumbImage, mediumImage, createdAt;

-(id) initWithDictionary:(NSDictionary *)dictionary 
{
  if (self = [super init]) {
    self.desc = [dictionary objectForKey:@"description"];
    self.latitude = [dictionary objectForKey:@"latitude"];
    self.longitude = [dictionary objectForKey:@"longitude"];
    self.wildlife = [dictionary objectForKey:@"wildlife"];
    self.oil = [dictionary objectForKey:@"oil"];
    self.wetlands = [dictionary objectForKey:@"wetlands"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setLocale:enUSPOSIXLocale];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]; //2010-06-12T23:26:42Z
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];                       
    
    self.createdAt = [dateFormat dateFromString: [dictionary objectForKey:@"created_at"]];
    
    [dateFormat release];
    [enUSPOSIXLocale release];

    if([NSNull null] != [dictionary objectForKey:@"media"]) {
      if([[dictionary objectForKey:@"media"] objectForKey:@"tiny"] != nil)
        self.thumbImage = [[dictionary objectForKey:@"media"] objectForKey:@"tiny"];

      if([[dictionary objectForKey:@"media"] objectForKey:@"medium"] != nil)
        self.mediumImage = [[dictionary objectForKey:@"media"] objectForKey:@"medium"]; 
    }
    
  }
  return self;
}

- (void) dealloc 
{
  [self.desc release];
  [self.latitude release];
  [self.longitude release];
  [self.wildlife release];
  [self.oil release];
  [self.wetlands release];
  [self.thumbImage release];
  [self.mediumImage release];
  [self.createdAt release];
  [super dealloc];
}

@end
