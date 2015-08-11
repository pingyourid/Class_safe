//
//  NSString+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSString+safe.h"

@implementation NSString (safe)

+ (void)load
{
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(substringFromIndex:) altSel:@selector(safeSubstringFromIndex:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(substringToIndex:) altSel:@selector(safeSubstringToIndex:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(substringWithRange:) altSel:@selector(safeSubstringWithRange:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(rangeOfString:) altSel:@selector(safeRangeOfString:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(rangeOfString:options:) altSel:@selector(safeRangeOfString:options:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(stringByAppendingString:) altSel:@selector(safeStringByAppendingString:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(initWithString:) altSel:@selector(safeInitWithString:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(stringWithString:) altSel:@selector(safeStringWithString:)];    
}

- (NSString *)safeSubstringFromIndex:(NSUInteger)from
{
    if (from > self.length) {
        NSAssert(NO, @"no");
        return nil;
    } else {
        return [self safeSubstringFromIndex:from];
    }
}

- (NSString *)safeSubstringToIndex:(NSUInteger)to
{
    if (to > self.length) {
        NSAssert(NO, @"no");
        return nil;
    } else {
        return [self safeSubstringToIndex:to];
    }
}

- (NSString *)safeSubstringWithRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location+length > self.length) {
        NSAssert(NO, @"no");
        return nil;
    } else {
        return [self safeSubstringWithRange:range];
    }
}

- (NSRange)safeRangeOfString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return NSMakeRange(NSNotFound, 0);
    } else {
        return [self safeRangeOfString:aString];
    }
}

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return NSMakeRange(NSNotFound, 0);
    } else {
        return [self safeRangeOfString:aString options:mask];
    }
}

- (NSString *)safeStringByAppendingString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return [self safeStringByAppendingString:@""];
    } else {
        return [self safeStringByAppendingString:aString];
    }
}

- (id)safeInitWithString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return [self safeInitWithString:@""];
    } else {
        return [self safeInitWithString:aString];
    }
}

+ (id)safeStringWithString:(NSString *)string
{
    if (string == nil) {
        NSAssert(NO, @"no");
        return [self safeStringWithString:@""];
    } else {
        return [self safeStringWithString:string];
    }
}

@end
