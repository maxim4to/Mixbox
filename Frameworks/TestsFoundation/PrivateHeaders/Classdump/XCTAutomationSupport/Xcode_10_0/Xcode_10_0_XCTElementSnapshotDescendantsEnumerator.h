#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTAutomationSupport_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTElementSnapshotDescendantsEnumerator : NSEnumerator
{
    NSEnumerator *_innerEnumerator;
    NSMutableArray *_unenumeratedDescendantsQueue;
}

@property(retain) NSMutableArray *unenumeratedDescendantsQueue; // @synthesize unenumeratedDescendantsQueue=_unenumeratedDescendantsQueue;
@property(retain) NSEnumerator *innerEnumerator; // @synthesize innerEnumerator=_innerEnumerator;
- (id)nextObject;
- (id)initWithElementSnapshot:(id)arg1;

@end

#endif