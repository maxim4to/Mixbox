#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTest_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>
#import <XCTest/XCTestExpectation.h>

@protocol XCTestExpectationDelegate;

@class XCTestExpectationImplementation, _XCTestExpectationImplementation;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTestExpectation ()
{
    id _internalImplementation;
}

+ (id)expectationWithDescription:(id)arg1;
+ (id)compoundOrExpectationWithSubexpectations:(id)arg1;
+ (id)compoundAndExpectationWithSubexpectations:(id)arg1;
@property(readonly) _XCTestExpectationImplementation *internalImplementation; // @synthesize internalImplementation=_internalImplementation;
- (void)cleanup;
@property _Bool hasBeenWaitedOn;
- (void)on_queue_setHasBeenWaitedOn:(_Bool)arg1;
@property id <XCTestExpectationDelegate> delegate;
@property(readonly, copy) NSArray *fulfillCallStackReturnAddresses;
@property(readonly, copy) NSArray *creationCallStackReturnAddresses;
@property(readonly) _Bool on_queue_fulfilled;
@property(readonly) _Bool fulfilled;
@property _Bool hasInverseBehavior;
@property(readonly) _Bool on_queue_isInverted;
@property(nonatomic) unsigned long long fulfillmentCount;
@property(readonly) unsigned long long on_queue_fulfillmentToken;
@property(readonly) unsigned long long fulfillmentToken;
@property(readonly) unsigned long long creationToken;
- (_Bool)_queue_fulfillWithCallStackReturnAddresses:(id)arg1;
- (void)fulfill;
- (id)description;

- (id)init;

@end

#endif