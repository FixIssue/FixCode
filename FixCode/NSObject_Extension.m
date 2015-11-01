//
//  NSObject_Extension.m
//  FixCode
//
//  Created by Boris Bügling on 31/10/15.
//  Copyright (c) 2015 Fastlane. All rights reserved.
//


#import "NSObject_Extension.h"
#import "FixCode.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[FixCode alloc] initWithBundle:plugin];
        });
    }
}

@end
