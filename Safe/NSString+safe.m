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
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(substringFromIndex:) altSel:@selector(hjsafeSubstringFromIndex:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(substringToIndex:) altSel:@selector(hjsafeSubstringToIndex:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(substringWithRange:) altSel:@selector(hjsafeSubstringWithRange:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(rangeOfString:) altSel:@selector(hjsafeRangeOfString:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(rangeOfString:options:) altSel:@selector(hjsafeRangeOfString:options:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(stringByAppendingString:) altSel:@selector(hjsafeStringByAppendingString:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(initWithString:) altSel:@selector(hjsafeInitWithString:)];
    [HJSwizzle exchangeMethodByClass:[self class] origSel:@selector(stringWithString:) altSel:@selector(hjsafeStringWithString:)];    
}


- (NSString *)hjsafeSubstringFromIndex:(NSUInteger)from
{
    if (from > self.length) {
        NSAssert(NO, @"no");
        return nil;
    } else {
        return [self hjsafeSubstringFromIndex:from];
    }
}

- (NSString *)hjsafeSubstringToIndex:(NSUInteger)to
{
    if (to > self.length) {
        NSAssert(NO, @"no");
        return nil;
    } else {
        return [self hjsafeSubstringToIndex:to];
    }
}

- (NSString *)hjsafeSubstringWithRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location+length > self.length) {
        NSAssert(NO, @"no");
        return nil;
    } else {
        return [self hjsafeSubstringWithRange:range];
    }
}

- (NSRange)hjsafeRangeOfString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return NSMakeRange(NSNotFound, 0);
    } else {
        return [self hjsafeRangeOfString:aString];
    }
}

- (NSRange)hjsafeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return NSMakeRange(NSNotFound, 0);
    } else {
        return [self hjsafeRangeOfString:aString options:mask];
    }
}

- (NSString *)hjsafeStringByAppendingString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return [self hjsafeStringByAppendingString:@""];
    } else {
        return [self hjsafeStringByAppendingString:aString];
    }
}

- (id)hjsafeInitWithString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return [self hjsafeInitWithString:@""];
    } else {
        return [self hjsafeInitWithString:aString];
    }
}

+ (id)hjsafeStringWithString:(NSString *)string
{
    if (string == nil) {
        NSAssert(NO, @"no");
        return [self hjsafeStringWithString:@""];
    } else {
        return [self hjsafeStringWithString:string];
    }
}

@end
