//
//  Util.m
//
//  Created by Brendan Lim on 5/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util

+ (UIColor *) colorFromRGB:(NSString *)stringToConvert {
  NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
  
  // String should be 6 or 8 characters  
  if ([cString length] < 6) return [UIColor blackColor];  
  
  // strip 0X if it appears  
  if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];  
  
  if ([cString length] != 6) return [UIColor blackColor];  
  
  // Separate into r, g, b substrings  
  NSRange range;  
  range.location = 0;  
  range.length = 2;  
  NSString *rString = [cString substringWithRange:range];  
  
  range.location = 2;  
  NSString *gString = [cString substringWithRange:range];  
  
  range.location = 4;  
  NSString *bString = [cString substringWithRange:range];  
  
  // Scan values  
  unsigned int r, g, b;  
  [[NSScanner scannerWithString:rString] scanHexInt:&r];  
  [[NSScanner scannerWithString:gString] scanHexInt:&g];  
  [[NSScanner scannerWithString:bString] scanHexInt:&b];  
  
  return [UIColor colorWithRed:((float) r / 255.0f)  
                         green:((float) g / 255.0f)  
                          blue:((float) b / 255.0f)  
                         alpha:1.0f];  
}

+ (void) alertWithTitle:(NSString *)title 
                message:(NSString *)message 
               delegate:(id)delegate 
      cancelButtonTitle:(NSString *)cancelTitle 
      otherButtonTitles:(NSString *)otherTitles {
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                  message:message
                                                 delegate:delegate 
                                        cancelButtonTitle:cancelTitle
                                        otherButtonTitles:otherTitles];
  [alert show];
  [alert release];    
  
}

+ (void) alertNoInternetWithDelegate:(id)delegate {
  [self alertWithTitle:@"Connection Required" 
               message:@"You must be connected to the Internet to be able to view the latest reports." 
              delegate:delegate 
     cancelButtonTitle:@"Okay" 
     otherButtonTitles:nil];     
  
}

@end
