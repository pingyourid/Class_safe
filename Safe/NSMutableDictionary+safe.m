//
//  NSMutableDictionary+safe.m
//  HJ
//
//  Created by bibibi on 15/7/20.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import "NSMutableDictionary+safe.h"

@implementation NSMutableDictionary (safe)

+ (void)load
{
    NSArray *classArr = @[ @"__NSDictionaryM", @"__NSCFDictionary" ];
    [classArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSString *classString = (NSString *)obj;

      [HJSwizzle overrideMethodByClass:NSClassFromString(classString) origSel:@selector(setObject:forKeyedSubscript:) altSel:@selector(safeSetObject:forKeyedSubscript:)];

      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(setObject:forKey:) altSel:@selector(safeSetObject:forKey:)];
      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(objectForKey:) altSel:@selector(safeObjectForKey:)];
    }];
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
        return;
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
    }
    else {
        NSAssert(NO, @"no");
        return;
    }
}

- (id)safeObjectForKey:(id<NSCopying>)aKey
{
    if (aKey != nil) {
        return [self safeObjectForKey:aKey];
    }
    else {
        NSArray *syms = [NSThread callStackSymbols];
        if (([syms count] > 1) //以后可能过滤一个列表
            && (([[syms objectAtIndex:1] rangeOfString:@"UIKeyboard"].length != 0))) {
            return [self safeObjectForKey:aKey];
        }

        NSAssert(NO, @"no");

        return nil;
    }
}

@end
