import Foundation
import MixboxUiTestsFoundation

@objc(PrincipalClass)
final class EntryPoint: NSObject {
    override init() {
        AccessibilityEnabler.enableAccessibilityForSimulator()
    }
}
