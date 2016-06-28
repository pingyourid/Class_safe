//
//  NSMutableString+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSMutableString+safe.h"
//__NSCFString
@implementation NSMutableString(safe)

+ (void)load
{
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSCFString") origSel:@selector(insertString:atIndex:) altSel:@selector(hjsafeInsertString:atIndex:)];
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSCFString") origSel:@selector(appendString:) altSel:@selector(hjsafeAppendString:)];
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSCFString") origSel:@selector(setString:) altSel:@selector(hjsafeSetString:)];
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSCFString") origSel:@selector(replaceOccurrencesOfString:withString:options:range:) altSel:@selector(hjsafeReplaceOccurrencesOfString:withString:options:range:)];
}

- (void)hjsafeInsertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return;
    } else if (loc > self.length) {
        NSAssert(NO, @"no");
        return;
    } else {
        [self hjsafeInsertString:aString atIndex:loc];
    }
}

- (void)hjsafeAppendString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return;
    } else {
        [self hjsafeAppendString:aString];
    }
}

- (void)hjsafeSetString:(NSString *)aString
{
    if (aString == nil) {
        NSAssert(NO, @"no");
        return;
    } else {
        [self hjsafeSetString:aString];
    }
}

- (NSUInteger)hjsafeReplaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    NSUInteger location = searchRange.location;
    NSUInteger length = searchRange.length;
    
    if (target == nil || replacement == nil) {
        NSAssert(NO, @"no");
        return 0;
    } else if (location + length > self.length) {
        NSAssert(NO, @"no");
        return 0;
    } else {
        return [self hjsafeReplaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
}

@end
