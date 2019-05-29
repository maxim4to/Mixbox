#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTest_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTResult : NSObject
{
    id _value;
    NSError *_error;
}

+ (id)resultWithError:(id)arg1;
+ (id)resultWithValue:(id)arg1;
+ (id)result;
+ (id)resultWithValue:(id)arg1 error:(id)arg2;
@property(retain) NSError *error; // @synthesize error=_error;
@property(retain) id value; // @synthesize value=_value;
@property(readonly) _Bool hasError;
@property(readonly) _Bool hasValue;
- (id)initWithValue:(id)arg1 error:(id)arg2;

@end

#endif