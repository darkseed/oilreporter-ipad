//
//  ConnectionManager.m
//
//  Created by Sean Soper on 04/21/10.
//  Copyright 2010 Intridea. All rights reserved.
//

#import "ConnectionManager.h"
#import "Reachability.h"

static ConnectionManager *defaultConnectionManager = nil;

@implementation ConnectionManager

@synthesize connected;

+ (ConnectionManager *) defaultManager {
  @synchronized(self) {
    if (defaultConnectionManager == nil) {
      [[self alloc] init];
    }
  }
  
  return defaultConnectionManager;
}

+ (id) allocWithZone:(NSZone *) zone {
  @synchronized(self) {    
    if (defaultConnectionManager == nil) {
      
      defaultConnectionManager = [super allocWithZone: zone];
      defaultConnectionManager.connected = false;
      
      [[NSNotificationCenter defaultCenter] addObserver: defaultConnectionManager 
                                               selector: @selector(reachabilityChanged:) 
                                                   name: kReachabilityChangedNotification 
                                                 object: nil];
      
      Reachability *internetReach = [[Reachability reachabilityForInternetConnection] retain];
      [internetReach startNotifer];
      [defaultConnectionManager updateReachability: internetReach];      
      
      return defaultConnectionManager;
    }
  }
  
  return nil;
}

- (void) reachabilityChanged:(NSNotification *) note {
	Reachability *curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateReachability: curReach];
}

- (void) updateReachability:(Reachability *) curReach {
  NetworkStatus netStatus = [curReach currentReachabilityStatus];
  
  self.connected = (netStatus != NotReachable);
}

- (id) copyWithZone:(NSZone *) zone {
  return self;
}

- (id) retain {
  return self;
}

- (unsigned) retainCount {
  return UINT_MAX;
}

- (void) release {
  // do nothing
}

- (id) autorelease {
  return self;
}


@end
