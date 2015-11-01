//
//  FixCode.h
//  FixCode
//
//  Created by Boris Bügling on 31/10/15.
//  Copyright (c) 2015 Fastlane. All rights reserved.
//

#import <AppKit/AppKit.h>

@class FixCode;

static FixCode *sharedPlugin;

@interface FixCode : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;

@end