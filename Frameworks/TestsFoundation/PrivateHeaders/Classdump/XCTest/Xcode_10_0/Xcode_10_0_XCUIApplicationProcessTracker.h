#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTest_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

@class XCUIApplicationProcess;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@protocol XCUIApplicationProcessTracker <NSObject>
- (void)setApplicationProcess:(XCUIApplicationProcess *)arg1 forToken:(NSNumber *)arg2;
- (XCUIApplicationProcess *)applicationProcessWithToken:(NSNumber *)arg1;
- (void)setApplicationProcess:(XCUIApplicationProcess *)arg1 forPID:(int)arg2;
- (XCUIApplicationProcess *)applicationProcessWithPID:(int)arg1;
@end

#endif
