//
//  NSArray+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSArray+safe.h"

@implementation NSArray (Safe)

+ (void)load
{
    NSArray *classArr = @[@"__NSArrayM",@"__NSCFArray",@"__NSArrayI",@"__NSArray0"];
    [classArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *classString = (NSString *)obj;
        
        [HJSwizzle overrideMethodByClass:NSClassFromString(classString) origSel:@selector(objectAtIndexedSubscript:) altSel:@selector(hjsafeObjectAtIndexedSubscript:)];
        
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(objectAtIndex:) altSel:@selector(hjsafeObjectAtIndex:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(subarrayWithRange:) altSel:@selector(hjsafeSubarrayWithRange:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(indexOfObject:) altSel:@selector(hjsafeIndexOfObject:)];
    }];
}

- (id)hjsafeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"can't be nil");
            return nil;
        }
        else
        {
            return [self hjsafeObjectAtIndex:index];
        }
    }
    else {
        return [self hjsafeObjectAtIndex:index];
    }
}

- (id)hjsafeObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"index beyond");
            return nil;
        }
        else
        {
            return [self hjsafeObjectAtIndex:index];
        }
    }
    else {
        return [self hjsafeObjectAtIndex:index];
    }
}

- (NSArray *)hjsafeSubarrayWithRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            //超过了边界,就获取从loction开始所有的item
            NSAssert(NO, @"index beyond");
            length = (self.count - location);
            return [self hjsafeSubarrayWithRange:NSMakeRange(location, length)];
        }
        else
        {
            return [self hjsafeSubarrayWithRange:range];
        }
        
        
    }
    else {
        return [self hjsafeSubarrayWithRange:range];
    }
}

- (NSUInteger)hjsafeIndexOfObject:(id)anObject
{
    if (anObject == nil) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"no");
            return NSNotFound;
        }
        else
        {
            return [self hjsafeIndexOfObject:anObject];
        }
    }
    else {
        return [self hjsafeIndexOfObject:anObject];
    }
}

@end
