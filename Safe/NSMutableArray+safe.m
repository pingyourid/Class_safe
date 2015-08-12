//
//  NSMutableArray+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (safe)

+ (void)load
{
    NSArray *classArr = @[ @"__NSArrayM", @"__NSCFArray" ];
    [classArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSString *classString = (NSString *)obj;

      [HJSwizzle overrideMethodByClass:NSClassFromString(classString) origSel:@selector(setObject:atIndexedSubscript:) altSel:@selector(safeSetObject:atIndexedSubscript:)];

      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(addObject:) altSel:@selector(safeAddObject:)];
      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(insertObject:atIndex:) altSel:@selector(safeInsertObject:atIndex:)];
      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(insertObjects:atIndexes:) altSel:@selector(safeInsertObjects:atIndexes:)];
      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(removeObjectAtIndex:) altSel:@selector(safeRemoveObjectAtIndex:)];
      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(removeObjectsInRange:) altSel:@selector(safeRemoveObjectsInRange:)];
    }];
}

- (void)safeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (obj == nil) {
        return;
    }

    if (self.count < idx) {
        NSAssert(NO, @"no");
        return;
    }

    if (idx == self.count) {
        [self addObject:obj];
    }
    else {
        [self replaceObjectAtIndex:idx withObject:obj];
    }
}

- (void)safeAddObject:(id)object
{
    if (object == nil) {
        NSAssert(NO, @"no");
        return;
    }
    else {
        [self safeAddObject:object];
    }
}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index
{
    if (object == nil) {
        NSAssert(NO, @"no");
        return;
    }
    else if (index > self.count) {
        NSAssert(NO, @"no");
        return;
    }
    else {
        [self safeInsertObject:object atIndex:index];
    }
}

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs
{
    NSUInteger firstIndex = indexs.firstIndex;
    if (indexs == nil) {
        NSAssert(NO, @"no");
        return;
    }
    else if (indexs.count != objects.count || firstIndex > objects.count) {
        NSAssert(NO, @"no");
        return;
    }
    else {
        [self safeInsertObjects:objects atIndexes:indexs];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        NSAssert(NO, @"no");
        return;
    }
    else {
        [self safeRemoveObjectAtIndex:index];
    }
}

- (void)safeRemoveObjectsInRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        NSAssert(NO, @"no");
        return;
    }
    else {
        [self safeRemoveObjectsInRange:range];
    }
}

@end
