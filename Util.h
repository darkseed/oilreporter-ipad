//
//  Util.h
//
//  Created by Brendan Lim on 5/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Util : NSObject {
  
}

+ (UIColor *) colorFromRGB:(NSString *)stringToConvert;

+ (void) alertWithTitle:(NSString *)title 
                message:(NSString *)message 
               delegate:(id)delegate 
      cancelButtonTitle:(NSString *)cancelTitle 
      otherButtonTitles:(NSString *)otherTitles;

+ (void) alertNoInternetWithDelegate:(id)delegate;

@end
