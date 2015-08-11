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
    [HJSwizzle overrideMethodByClass:NSClassFromString(@"__NSArrayI") origSel:@selector(objectAtIndexedSubscript:) altSel:@selector(safeObjectAtIndexedSubscript:)];    
   
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSArrayI") origSel:@selector(objectAtIndex:) altSel:@selector(safeObjectAtIndex:)];
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSArrayI") origSel:@selector(subarrayWithRange:) altSel:@selector(safeSubarrayWithRange:)];
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSArrayI") origSel:@selector(indexOfObject:) altSel:@selector(safeIndexOfObject:)];
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    else {
        return [self objectAtIndex:index];
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        NSAssert(NO, @"index beyond");
        return nil;
    }
    else {
        return [self safeObjectAtIndex:index];
    }
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        //超过了边界,就获取从loction开始所有的item
        NSAssert(NO, @"index beyond");
        if ((location + length) > self.count) {
            length = (self.count - location);
            return [self safeSubarrayWithRange:NSMakeRange(location, length)];
        }

        return nil;
    }
    else {
        return [self safeSubarrayWithRange:range];
    }
}

- (NSUInteger)safeIndexOfObject:(id)anObject
{
    if (anObject == nil) {
        NSAssert(NO, @"anObject can't be nil");
        return NSNotFound;
    }
    else {
        return [self safeIndexOfObject:anObject];
    }
}

@end
