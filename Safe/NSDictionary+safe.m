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
    NSArray *classArr = @[ @"__NSDictionary0", @"__NSDictionaryM", @"__NSCFDictionary" ];
    [classArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *classString = (NSString *) obj;
        [HJSwizzle overrideMethodByClass:NSClassFromString(classString) origSel:@selector(objectForKeyedSubscript:) altSel:@selector(hjsafeObjectForKeyedSubscript:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(dictionaryWithObject:forKey:) altSel:@selector(hjsafeDictionaryWithObject:forKey:)];
        [HJSwizzle exchangeMethodByClass:NSClassFromString(classString) origSel:@selector(objectForKey:) altSel:@selector(hjsafeObjectForKey:)];
    }];
}

- (id)hjsafeObjectForKeyedSubscript:(id<NSCopying>)key
{
    if (key == nil) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"can't be nil");
            return nil;
        }
        else {
            return [self hjsafeObjectForKey:key];
        }
    }
    else {
        return [self hjsafeObjectForKey:key];
    }
}

- (id)hjsafeObjectForKey:(id<NSCopying>)aKey
{
    if (!aKey) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"no");
            return nil;
        }
        else {
            return [self hjsafeObjectForKey:aKey];
        }
    }
    else
    {
        return [self hjsafeObjectForKey:aKey];
    }
}

+ (id)hjsafeDictionaryWithObject:(id)object forKey:(id<NSCopying>)key
{
    if (object == nil || key == nil) {
        if ([HJSafeFilter shouldThrowExceptionWithSymbolArray:[NSThread callStackSymbols]]) {
            NSAssert(NO, @"can't be nil");
            return [self dictionary];
        }
        else {
            return [self hjsafeDictionaryWithObject:object forKey:key];
        }
    }
    else {
        return [self hjsafeDictionaryWithObject:object forKey:key];
    }
}

@end
