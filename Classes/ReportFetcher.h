//
//  ReportFetcher.h
//  OilReporter
//
//  Created by Brendan Lim on 6/16/10.
//  Copyright 2010 Intridea, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"

@class Report;
@interface ReportFetcher : NSObject {
  id delegate;
  BOOL isloadMore;
  NSMutableArray *reports;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) BOOL isloadMore;
@property (nonatomic, retain) NSMutableArray *reports;

- (id) initWithDelegate:(id) _delegate;
- (id) initLoadMoreWithDelegate:(id) _delegate withTableView:(UITableView *)_tableView;

@end

@protocol ReportFetcherDelegate

@optional
- (void) reportFetcherDidSucceed:(ReportFetcher *) fetcher;
- (void) reportFetcherDidFail:(ReportFetcher *) fetcher error:(NSError *) error;
@end
