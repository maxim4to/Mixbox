#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTAutomationSupport_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTAnimationsIdleNotifier : NSObject
{
}

+ (void)addAnimationIdleHandler:(CDUnknownBlockType)arg1;
+ (void)handleAnimationsIdle;
+ (void)animationDidStop;
+ (void)animationDidStart;
+ (_Bool)swizzleUIViewAnimationStateMethodsWithError:(id *)arg1;
+ (void)initialize;
- (void)notifyWhenIdle:(CDUnknownBlockType)arg1;

@end

#endif