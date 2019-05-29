#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTest_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import "Xcode_10_0_XCDebugLogDelegate.h"
#import "Xcode_10_0_XCTASDebugLogDelegate.h"
#import "Xcode_10_0_XCTRunnerIDESessionDelegate.h"
#import <Foundation/Foundation.h>

@class XCTestConfiguration;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTestDriver : NSObject <XCTRunnerIDESessionDelegate, XCDebugLogDelegate, XCTASDebugLogDelegate>
{
    XCTestConfiguration *_testConfiguration;
    NSObject *_queue;
    NSMutableArray *_debugMessageBuffer;
    int _debugMessageBufferOverflow;
}

+ (instancetype)sharedTestDriver;
+ (double)IDEConnectionTimeout;
@property int debugMessageBufferOverflow; // @synthesize debugMessageBufferOverflow=_debugMessageBufferOverflow;
@property(retain) NSMutableArray *debugMessageBuffer; // @synthesize debugMessageBuffer=_debugMessageBuffer;
@property(retain) NSObject *queue; // @synthesize queue=_queue;
@property(readonly) XCTestConfiguration *testConfiguration; // @synthesize testConfiguration=_testConfiguration;
- (void)runTestConfiguration:(id)arg1 completionHandler:(CDUnknownBlockType)arg2;
- (void)runTestSuite:(id)arg1 completionHandler:(CDUnknownBlockType)arg2;
- (void)reportStallOnMainThreadInTestCase:(id)arg1 method:(id)arg2 file:(id)arg3 line:(unsigned long long)arg4;
- (_Bool)runTestsAndReturnError:(id *)arg1;
- (id)_readyIDESession:(id *)arg1 forTestRunSession:(id)arg2;
- (id)_transportForIDESession:(id *)arg1;
- (void)_queue_flushDebugMessageBufferWithBlock:(CDUnknownBlockType)arg1;
- (void)logDebugMessage:(id)arg1;
- (void)printBufferedDebugMessages;
- (void)logStartupInfo;
- (id)initWithTestConfiguration:(id)arg1;
- (void)IDESessionDidDisconnect:(id)arg1;

// Remaining properties

@end

#endif