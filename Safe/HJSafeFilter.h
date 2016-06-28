//
//  HJSafeFilter.h
//  CommonLib
//
//  Created by bibibi on 15/10/30.
//  Copyright © 2015年 ihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJSafeFilter : NSObject

+ (BOOL)shouldThrowExceptionWithSymbolArray:(NSArray *)syms;

@end
