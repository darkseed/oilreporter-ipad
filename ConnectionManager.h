//
//  ConnectionManager.h
//
//  Created by Sean Soper on 04/21/10.
//  Copyright 2010 Intridea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface ConnectionManager : NSObject {
  BOOL connected;
}

@property (nonatomic, assign) BOOL connected;

- (void) reachabilityChanged:(NSNotification *) note;
- (void) updateReachability:(Reachability *) curReach;

+ (ConnectionManager *) defaultManager;

@end
