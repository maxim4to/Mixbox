@import CoreFoundation;

/**
 *  Used for enabling accessibility on simulator and device.
 */
@protocol AXBackBoardServer

/**
 *  Returns backboard server instance.
 */
+ (id)server;

/**
 *  Sets preference with @c key to @c value and raises @c notification.
 */
- (void)setAccessibilityPreferenceAsMobile:(CFStringRef)key
                                     value:(CFBooleanRef)value
                              notification:(CFStringRef)notification;

@end
