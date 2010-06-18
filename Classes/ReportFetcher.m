//
//  ReportFetcher.m
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReportFetcher.h"
#import "ASIHTTPRequest.h"
#import "Report.h"

#define kApiKey @"1bdac03b67c73ab6b4bc82a025c23af12e349792"
#define kPerPage @"20"

@implementation ReportFetcher

@synthesize delegate, reports, isloadMore;

- (id) initWithDelegate:(id) _delegate
{
  if (self = [super init]) {
    self.delegate = _delegate;
    self.isloadMore = NO;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://oilreporter.org/reports.json?api_key=%@&per_page=%@",kApiKey, kPerPage]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
  }
  
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  return self;
}

- (id) initLoadMoreWithDelegate:(id) _delegate withTableView:(UITableView *)_tableView
{
  if (self = [super init]) {
    self.delegate = _delegate;
    self.isloadMore = YES;
    
    int pageNumber = floor([_tableView numberOfRowsInSection:0] / 20) + 1;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://oilreporter.org/reports.json?api_key=%@&per_page=%@&page=%d",kApiKey, kPerPage, pageNumber]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
  }
  
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  return self;
}

- (void)requestFinished:(ASIHTTPRequest *)request 
{
  self.reports = [[NSMutableArray alloc] init];
  NSString *responseString = [request responseString];
  NSData *responseData = [responseString dataUsingEncoding:NSUTF32BigEndianStringEncoding];

  NSError *error = nil;
	NSArray *reportsArray = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&error];
  
  for (NSDictionary *dict in reportsArray) { 
    Report *report = [[[Report alloc] initWithDictionary:dict] autorelease];
    [self.reports addObject:report];
  } 
  
  
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

  if (self.delegate && [self.delegate respondsToSelector: @selector(reportFetcherDidSucceed:)])
    [self.delegate reportFetcherDidSucceed:self];  
}

- (void)requestFailed:(ASIHTTPRequest *)request 
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

  if (self.delegate && [self.delegate respondsToSelector: @selector(reportFetcherDidFail:error:)])
    [self.delegate reportFetcherDidFail: self error: [request error]];
}

- (void) dealloc 
{
  [self.delegate release];
  [self.reports release];
  [super dealloc];
}
@end
