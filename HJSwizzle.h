//
//  HJSwizzle.h
//  CommonLib
//
//  Created by bibibi on 15/8/10.
//  Copyright (c) 2015年 ihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJSwizzle : NSObject

+ (BOOL)overrideMethodByClass:(Class)aClass origSel:(SEL)origSel altSel:(SEL)altSel;
+ (BOOL)overrideClassMethodByClass:(Class)aClass origClassSel:(SEL)origClassSel altClassSel:(SEL)altClassSel;

+ (BOOL)exchangeMethodByClass:(Class)aClass origSel:(SEL)origSel altSel:(SEL)altSel;
+ (BOOL)exchangeClassMethodByClass:(Class)aClass origClassSel:(SEL)origClassSel altClassSel:(SEL)altClassSel;

@end
