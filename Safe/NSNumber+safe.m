//
//  NSNumber+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSNumber+safe.h"

@implementation NSNumber (safe)

+ (void)load
{
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(isEqualToNumber:) altSel:@selector(safeIsEqualToNumber:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(compare:) altSel:@selector(safeCompare:)];    
}

- (BOOL)safeIsEqualToNumber:(NSNumber *)number
{
    if (number == nil) {
        NSAssert(NO, @"no");
        return NO;
    }
    else {
        return [self safeIsEqualToNumber:number];
    }
}

- (NSComparisonResult)safeCompare:(NSNumber *)otherNumber
{
    if (otherNumber == nil) {
        NSAssert(NO, @"no");
        return NSOrderedDescending;
    }
    else {
        return [self safeCompare:otherNumber];
    }
}

@end
