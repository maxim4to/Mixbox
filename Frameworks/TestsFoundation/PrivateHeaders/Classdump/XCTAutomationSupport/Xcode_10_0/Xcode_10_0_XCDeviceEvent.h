#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 120100

#import "Xcode_10_0_XCTAutomationSupport_CDStructures.h"
#import "Xcode_10_0_SharedHeader.h"
#import <Foundation/Foundation.h>

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCDeviceEvent : NSObject <NSSecureCoding>
{
    unsigned int _eventPage;
    unsigned int _usage;
    double _duration;
    unsigned long long _type;
    double _rotation;
}

+ (id)deviceEventForDigitalCrownRotation:(double)arg1 velocity:(double)arg2;
+ (id)deviceEventWithPage:(unsigned int)arg1 usage:(unsigned int)arg2 duration:(double)arg3;
+ (_Bool)supportsSecureCoding;
@property unsigned long long type; // @synthesize type=_type;
@property double rotation; // @synthesize rotation=_rotation;
@property double duration; // @synthesize duration=_duration;
@property unsigned int usage; // @synthesize usage=_usage;
@property unsigned int eventPage; // @synthesize eventPage=_eventPage;
@property(readonly) _Bool isButtonHoldEvent;
- (id)description;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;

@end

#endif