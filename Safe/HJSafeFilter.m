//
//  HJSafeFilter.m
//  CommonLib
//
//  Created by bibibi on 15/10/30.
//  Copyright © 2015年 ihome. All rights reserved.
//

#import "HJSafeFilter.h"

@implementation HJSafeFilter

+ (BOOL)shouldThrowExceptionWithSymbolArray:(NSArray *)syms
{
    if (([syms count] > 1)
        && ([[syms objectAtIndex:1] rangeOfString:@"YYW"].length != 0)) {//replace YYW with app target
            return YES;
        }
    return NO;
}

@end

