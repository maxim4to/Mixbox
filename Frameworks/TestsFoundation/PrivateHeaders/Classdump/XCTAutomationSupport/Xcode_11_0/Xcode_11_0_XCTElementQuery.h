#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 140000

#import "Xcode_11_0_XCTAutomationSupport_CDStructures.h"
#import "Xcode_11_0_SharedHeader.h"
#import "Xcode_11_0_XCTCapabilitiesProviding.h"
#import <Foundation/Foundation.h>

@protocol XCTElementSnapshotAttributeDataSource, XCTElementSnapshotProvider;

@class XCAccessibilityElement, XCElementSnapshot, XCTTimeoutControls;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTElementQuery : NSObject <NSSecureCoding, XCTCapabilitiesProviding>
{
    _Bool _isMacOS;
    _Bool _suppressAttributeKeyPathAnalysis;
    _Bool _useLegacyElementType;
    XCAccessibilityElement *_rootElement;
    unsigned long long _options;
    XCTTimeoutControls *_timeoutControls;
    id <XCTElementSnapshotProvider> _snapshotProvider;
    id <XCTElementSnapshotAttributeDataSource> _elementSnapshotAttributeDataSource;
    XCElementSnapshot *_rootElementSnapshot;
    CDUnknownBlockType _evaluationContext;
    NSArray *_transformers;
}

+ (id)_firstMatchTransformerSubarraysFromArray:(id)arg1 trailingMatchAllTransformers:(id *)arg2;
+ (void)provideCapabilitiesToBuilder:(id)arg1;
+ (_Bool)supportsSecureCoding;
@property _Bool useLegacyElementType; // @synthesize useLegacyElementType=_useLegacyElementType;
@property(readonly, copy) NSArray *transformers; // @synthesize transformers=_transformers;
@property(copy, nonatomic) CDUnknownBlockType evaluationContext; // @synthesize evaluationContext=_evaluationContext;
@property(retain) XCElementSnapshot *rootElementSnapshot; // @synthesize rootElementSnapshot=_rootElementSnapshot;
@property _Bool suppressAttributeKeyPathAnalysis; // @synthesize suppressAttributeKeyPathAnalysis=_suppressAttributeKeyPathAnalysis;
@property __weak id <XCTElementSnapshotAttributeDataSource> elementSnapshotAttributeDataSource; // @synthesize elementSnapshotAttributeDataSource=_elementSnapshotAttributeDataSource;
@property(retain) id <XCTElementSnapshotProvider> snapshotProvider; // @synthesize snapshotProvider=_snapshotProvider;
@property(retain) XCTTimeoutControls *timeoutControls; // @synthesize timeoutControls=_timeoutControls;
@property(readonly) _Bool isMacOS; // @synthesize isMacOS=_isMacOS;
@property(readonly) unsigned long long options; // @synthesize options=_options;
@property(readonly, copy) XCAccessibilityElement *rootElement; // @synthesize rootElement=_rootElement;
- (id)_allMatchingSnapshotsForInput:(id)arg1 transformers:(id)arg2 relatedElements:(id *)arg3 noMatchesMessage:(id *)arg4 error:(id *)arg5;
- (id)_firstMatchingSnapshotForInput:(id)arg1 transformers:(id)arg2 relatedElements:(id *)arg3 noMatchesMessage:(id *)arg4 error:(id *)arg5;
- (id)_firstMatchingSnapshotForInput:(id)arg1 transformersSubarrays:(id)arg2 relatedElements:(id *)arg3 noMatchesMessage:(id *)arg4 error:(id *)arg5;
- (id)matchingSnapshotsWithRelatedElements:(id *)arg1 noMatchesMessage:(id *)arg2 error:(id *)arg3;
- (id)_snapshotForElement:(id)arg1 error:(id *)arg2;
- (id)_rootElementSnapshot:(id *)arg1;
@property(readonly, copy) NSDictionary *snapshotParameters;
@property(readonly, copy) NSArray *snapshotAttributes;
- (_Bool)hasTransformerWithStopsOnFirstMatch;
@property(readonly) _Bool supportsAttributeKeyPathAnalysis;
- (_Bool)canBeRemotelyEvaluatedWithCapabilities:(id)arg1;
- (_Bool)isEqual:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
@property(readonly) _Bool supportsRemoteEvaluation;
- (id)initWithRootElement:(id)arg1 transformers:(id)arg2 options:(unsigned long long)arg3 isMacOS:(_Bool)arg4 timeoutControls:(id)arg5;
- (id)initWithRootElement:(id)arg1 transformers:(id)arg2 options:(unsigned long long)arg3 isMacOS:(_Bool)arg4;
- (id)initWithRootElement:(id)arg1 transformers:(id)arg2 options:(unsigned long long)arg3;
- (id)initWithRootElement:(id)arg1 transformers:(id)arg2;

// Remaining properties

@end

#endif