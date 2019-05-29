#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTest_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

@class XCAccessibilityElement;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@protocol XCUIAXNotificationHandling <NSObject>
@property(readonly) _Bool axNotificationsIncludeElement;
- (void)handleAccessibilityNotification:(long long)arg1 fromElement:(XCAccessibilityElement *)arg2 payload:(NSData *)arg3;
@end

#endif
