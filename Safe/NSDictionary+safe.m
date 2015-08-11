//
//  NSDictionary+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSDictionary+safe.h"
#import <objc/runtime.h>

@implementation NSDictionary (safe)

+ (void)load
{
    [HJSwizzle overrideMethodByClass:[self class] origSel:@selector(objectForKeyedSubscript:) altSel:@selector(safeObjectForKeyedSubscript:)];

    [HJSwizzle exchangeClassMethodByClass:[self class] origClassSel:@selector(dictionaryWithObject:forKey:) altClassSel:@selector(safeDictionaryWithObject:forKey:)];
}

- (id)safeObjectForKeyedSubscript:(id<NSCopying>)key
{
    if (key == nil) {
        NSAssert(NO, @"can't be nil");
        return nil;
    }
    else {
        return [self objectForKey:key];
    }
}

+ (id)safeDictionaryWithObject:(id)object forKey:(id<NSCopying>)key
{
    if (object == nil || key == nil) {
        NSAssert(NO, @"can't be nil");
        return [self dictionary];
    }
    else {
        return [self safeDictionaryWithObject:object forKey:key];
    }
}

@end
