#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTAutomationSupport_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

@protocol XCTElementSnapshotAttributeDataSource, XCTElementSnapshotProvider;

@class XCAccessibilityElement, XCElementSnapshot;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTElementQuery : NSObject <NSSecureCoding>
{
    _Bool _suppressAttributeKeyPathAnalysis;
    id <XCTElementSnapshotProvider> _snapshotProvider;
    id <XCTElementSnapshotAttributeDataSource> _elementSnapshotAttributeDataSource;
    unsigned long long _options;
    XCElementSnapshot *_rootElementSnapshot;
    CDUnknownBlockType _evaluationContext;
    double _responsivenessTimeout;
    double _executionTimeout;
    XCAccessibilityElement *_rootElement;
    NSArray *_transformers;
}

+ (id)_firstMatchTransformerSubarraysFromArray:(id)arg1 trailingMatchAllTransformers:(id *)arg2;
+ (_Bool)supportsSecureCoding;
@property(readonly, copy) NSArray *transformers; // @synthesize transformers=_transformers;
@property(readonly, copy) XCAccessibilityElement *rootElement; // @synthesize rootElement=_rootElement;
@property double executionTimeout; // @synthesize executionTimeout=_executionTimeout;
@property double responsivenessTimeout; // @synthesize responsivenessTimeout=_responsivenessTimeout;
@property(copy, nonatomic) CDUnknownBlockType evaluationContext; // @synthesize evaluationContext=_evaluationContext;
@property(retain) XCElementSnapshot *rootElementSnapshot; // @synthesize rootElementSnapshot=_rootElementSnapshot;
@property(readonly) unsigned long long options; // @synthesize options=_options;
@property _Bool suppressAttributeKeyPathAnalysis; // @synthesize suppressAttributeKeyPathAnalysis=_suppressAttributeKeyPathAnalysis;
@property __weak id <XCTElementSnapshotAttributeDataSource> elementSnapshotAttributeDataSource; // @synthesize elementSnapshotAttributeDataSource=_elementSnapshotAttributeDataSource;
@property(retain) id <XCTElementSnapshotProvider> snapshotProvider; // @synthesize snapshotProvider=_snapshotProvider;
- (id)_allMatchingSnapshotsForInput:(id)arg1 transformers:(id)arg2 relatedElements:(id *)arg3 error:(id *)arg4;
- (id)_firstMatchingSnapshotForInput:(id)arg1 transformers:(id)arg2 relatedElements:(id *)arg3 error:(id *)arg4;
- (id)_firstMatchingSnapshotForInput:(id)arg1 transformersSubarrays:(id)arg2 relatedElements:(id *)arg3 error:(id *)arg4;
- (id)matchingSnapshotsWithRelatedElements:(id *)arg1 error:(id *)arg2;
- (id)_snapshotForElement:(id)arg1 error:(id *)arg2;
- (id)_rootElementSnapshot:(id *)arg1;
- (id)_snapshotAttributesOrError:(id *)arg1;
- (id)matchingSnapshotsWithError:(id *)arg1;
- (_Bool)hasTransformerWithStopsOnFirstMatch;
@property(readonly) _Bool supportsAttributeKeyPathAnalysis;
- (_Bool)isEqual:(id)arg1;
- (unsigned long long)hash;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
@property(readonly) _Bool supportsRemoteEvaluation;
- (id)initWithRootElement:(id)arg1 transformers:(id)arg2 options:(unsigned long long)arg3;
- (id)initWithRootElement:(id)arg1 transformers:(id)arg2;

@end

#endif