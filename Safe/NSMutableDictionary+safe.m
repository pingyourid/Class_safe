//
//  NSMutableDictionary+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSMutableDictionary+safe.h"

@implementation NSMutableDictionary(safe)

+ (void)load
{
    [HJSwizzle overrideMethodByClass:NSClassFromString(@"__NSDictionaryM") origSel:@selector(setObject:forKeyedSubscript:) altSel:@selector(safeSetObject:forKeyedSubscript:)];
    
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSDictionaryM") origSel:@selector(setObject:forKey:) altSel:@selector(safeSetObject:forKey:)];
    [HJSwizzle exchangeMethodByClass:NSClassFromString(@"__NSDictionaryM") origSel:@selector(objectForKey:) altSel:@selector(safeObjectForKey:)];
}

/**
 *  dic[]的安全
 *
 *  @param obj
 *  @param key 
 */
- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) {
        NSAssert(NO, @"no");
        return ;
    }
    
    if (!obj) {
        [self removeObjectForKey:key];
    }
    else {
        [self setObject:obj forKey:key];
    }
}

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey
{
    if (aObj && ![aObj isKindOfClass:[NSNull class]] && aKey) {
        [self safeSetObject:aObj forKey:aKey];
    } else {
        NSAssert(NO, @"no");
        return;
    }
}

- (id)safeObjectForKey:(id<NSCopying>)aKey
{
    if (aKey != nil) {
        return [self safeObjectForKey:aKey];
    } else {
        NSAssert(NO, @"no");
        return nil;
    }
}

@end
