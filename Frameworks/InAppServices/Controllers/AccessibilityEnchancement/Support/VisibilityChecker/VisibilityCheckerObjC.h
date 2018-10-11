#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VisibilityCheckerObjC : NSObject

// E.g.:
//
// +----------+ <= A
// |0123456789|
// |012+----------+
// +---|0123456789| <= B
//     |0123456789|
//     +----------+
//
// If A and B are both opaque, then result for A will be 13/20.
// If B.alpha = 0.2 and blendingThreshold is 0.18 (<0.2), then result for A will be 13/20.
// If B.alpha = 0.2 and blendingThreshold is 0.22 (>0.2), then result for A will be 20/20.

+ (double)percentageOfVisibleAreaOfView:(UIView *)view
                  withBlendingThreshold:(CGFloat)blendingThreshold;

@end
