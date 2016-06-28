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
    NSArray *classArr = @[@"__NSArrayM",@"__NSCFArray"];
    [classArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *classString = (NSString *)obj;
        
        [HJSwizzle overrideMethodByClass:NSClassFromString(classString) origSel:@selector(setObject:atIndexedSubscript:) altSel:@selector(hjsafeSetObject:atIndexedSubscript:)];
        
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(addObject:) altSel:@selector(hjsafeAddObject:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(insertObject:atIndex:) altSel:@selector(hjsafeInsertObject:atIndex:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(insertObjects:atIndexes:) altSel:@selector(hjsafeInsertObjects:atIndexes:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(removeObjectAtIndex:) altSel:@selector(hjsafeRemoveObjectAtIndex:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(removeObjectsInRange:) altSel:@selector(hjsafeRemoveObjectsInRange:)];
    }];
}

- (void)hjsafeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx{
    if (obj == nil) {
        return ;
    }
    
    if (self.count < idx) {
        NSAssert(NO, @"no");
        return ;
    }
    
    if (idx == self.count) {
        [self addObject:obj];
    } else {
        [self replaceObjectAtIndex:idx withObject:obj];
    }
}

- (void)hjsafeAddObject:(id)object
{
	if (object == nil) {
        NSAssert(NO, @"no");
		return;
	} else {
        [self hjsafeAddObject:object];
    }
}

- (void)hjsafeInsertObject:(id)object atIndex:(NSUInteger)index
{
	if (object == nil) {
        NSAssert(NO, @"no");
		return;
	} else if (index > self.count) {
        NSAssert(NO, @"no");
		return;
	} else {
        [self hjsafeInsertObject:object atIndex:index];
    }
}

- (void)hjsafeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs
{
    NSUInteger firstIndex = indexs.firstIndex;
    if (indexs == nil) {
        NSAssert(NO, @"no");
        return;
    } else if (indexs.count!=objects.count || firstIndex>objects.count) {
        NSAssert(NO, @"no");
        return;
    } else {
        [self hjsafeInsertObjects:objects atIndexes:indexs];
    }
}

- (void)hjsafeRemoveObjectAtIndex:(NSUInteger)index
{
	if (index >= self.count) {
        NSAssert(NO, @"no");
		return;
	} else {
        [self hjsafeRemoveObjectAtIndex:index];
    }
}

- (void)hjsafeRemoveObjectsInRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        NSAssert(NO, @"no");
        return;
    } else {
        [self hjsafeRemoveObjectsInRange:range];
    }
}

@end
