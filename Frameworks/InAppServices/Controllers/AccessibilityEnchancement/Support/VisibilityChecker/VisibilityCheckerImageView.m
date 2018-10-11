#import "VisibilityCheckerImageView.h"

@implementation VisibilityCheckerImageView

// Workaround for adding it as a subview to UIVisualEffectView.
// We disassembled UIKit, found a way to avoid this assertion:
// <UIImageView: 0x7fe1da7a1d10; frame = (0 0; 375 667); userInteractionEnabled = NO; layer = <CALayer: 0x608000620700>> - (null) has been added as a subview to <UIVisualEffectView: 0x7fe1da505230; frame = (0 0; 375 667); layer = <CALayer: 0x604000825100>>. Do not add subviews directly to the visual effect view itself, instead add them to the -contentView.

- (BOOL)isKindOfClass:(Class)aClass {
    if (aClass == NSClassFromString(@"_UIVisualEffectImageView")) {
        return true;
    } else {
        return [super isKindOfClass:aClass];
    }
}

@end
