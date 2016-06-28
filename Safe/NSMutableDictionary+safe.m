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

      [HJSwizzle overrideMethodByClass:NSClassFromString(classString) origSel:@selector(setObject:forKeyedSubscript:) altSel:@selector(hjsafeSetObject:forKeyedSubscript:)];

      [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(setObject:forKey:) altSel:@selector(hjsafeSetObject:forKey:)];
    }];
}


/**
 *  dic[]的安全
 *
 *  @param obj
 *  @param key 
 */
- (void)hjsafeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key || !obj) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"no");
            if (!key) {
                return;
            }
            if (!obj) {
                [self removeObjectForKey:key];
            }
        }
        else
        {
            [self hjsafeSetObject:obj forKey:key];
        }
    }
    else {
        [self hjsafeSetObject:obj forKey:key];
    }
}

- (void)hjsafeSetObject:(id)aObj forKey:(id<NSCopying>)aKey
{
    if (aObj && ![aObj isKindOfClass:[NSNull class]] && aKey) {
        [self hjsafeSetObject:aObj forKey:aKey];
    }
    else {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"no");
            return;
        }
        else
        {
            return [self hjsafeSetObject:aObj forKey:aKey];
        }
    }
}


@end
