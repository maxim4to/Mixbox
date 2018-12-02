// TODO: Move to Mixbox frameworks

import UIKit

// Conform to this protocol if you need to save animation in tests. It's window.layer.speed won't be affected
protocol AnimationsInTestSupportable: class {}

#if DEBUG
public final class AnimationRemoverForTests: NSObject {
    @objc public static func setUp() {
        guard let originalMethod = class_getInstanceMethod(
            UIView.self,
            #selector(UIView.didMoveToSuperview)
            ) else { return }
        
        guard let swizzledMethod = class_getInstanceMethod(
            UIView.self,
            #selector(UIView.swizzled_didMoveToSuperview_AnimationRemoverForQaAutomation)
            ) else { return }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension UIView {
    @objc func swizzled_didMoveToSuperview_AnimationRemoverForQaAutomation() {
        swizzled_didMoveToSuperview_AnimationRemoverForQaAutomation()
        
        // I tried 1e+20, got black screen.
        // I tried 1_000_000, got many other problems.
        // I tried 10_000, got some problems.
        if !(self is AnimationsInTestSupportable) {
            let bigNumberButNotSoBig: Float = 100
            self.window?.layer.speed = bigNumberButNotSoBig
        }
    }
}
#endif
