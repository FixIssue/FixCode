//
//  FixCode.m
//  FixCode
//
//  Created by Boris Bügling on 31/10/15.
//  Copyright (c) 2015 Fastlane. All rights reserved.
//

#import <objc/runtime.h>

#import "Aspects.h"
#import "FixCode.h"

@interface NSView (Debug)

-(NSString*)_subtreeDescription;

@end

#pragma mark -

@interface FixCode()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong, readwrite) NSWindowController *currentCodeSigningWindowController;

@end

#pragma mark -

@implementation FixCode

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];

    [self swizzleCodeSigningResolution];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)doItRight {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/fastlane/fastlane/blob/master/docs/CodeSigning.md"]];

    [self.currentCodeSigningWindowController.window close];
    [self.currentCodeSigningWindowController close];
}

- (void)findAndReplaceFixIssueButtonInView:(NSView*)view {
    NSButton* fixIssueButton = [self findFirstButtonRecursive:view];
    fixIssueButton.title = @"Do it right ✨🚀✨";

    fixIssueButton.action = @selector(doItRight);
    fixIssueButton.target = self;

    [fixIssueButton sizeToFit];
}

- (NSButton*)findFirstButtonRecursive:(NSView*)view {
    if ([view isKindOfClass:NSButton.class]) {
        return (NSButton*)view;
    }

    for (NSView* subview in view.subviews) {
        NSButton* result = [self findFirstButtonRecursive:subview];
        if (result) {
            return result;
        }
    }

    return nil;
}

- (NSTextField*)findLastTextFieldRecursive:(NSView*)view {
    NSTextField* textField = nil;

    for (NSView* subview in view.subviews) {
        if ([subview isKindOfClass:NSTextField.class]) {
            textField = (NSTextField*)subview;
        }

        NSTextField* result = [self findLastTextFieldRecursive:subview];
        if (result) {
            return result;
        }
    }

    return textField;
}

- (void)swizzleCodeSigningResolution
{
    NSError* error = nil;

    [objc_getClass("IDECodesignIssueResolutionWindowController") aspect_hookSelector:@selector(windowDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        self.currentCodeSigningWindowController = info.instance;
        NSView* contentView = [[self.currentCodeSigningWindowController window] contentView];

        [self findAndReplaceFixIssueButtonInView:contentView];

        NSTextField* field = [self findLastTextFieldRecursive:contentView];
        [field setStringValue:[field.stringValue componentsSeparatedByString:@"\n"][0]];
    } error:&error];

    if (error) {
        NSLog(@"Error: %@", error);
    }

    [objc_getClass("Xcode3CodesignTroubleshootingViewController") aspect_hookSelector:@selector(viewDidAppear) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        NSView* view = [info.instance view];
        [self findAndReplaceFixIssueButtonInView:view];
    } error:&error];

    if (error) {
        NSLog(@"Error: %@", error);
    }
}

@end
