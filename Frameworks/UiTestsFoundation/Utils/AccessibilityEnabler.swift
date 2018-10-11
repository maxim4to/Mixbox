import Foundation

public final class AccessibilityEnabler {
    // https://github.com/google/EarlGrey/blob/3102ef3b137f05a179628b1b9768856e5feea90e/EarlGrey/Core/GREYAutomationSetup.m#L151
    public static func enableAccessibilityForSimulator() {
        
        let path = NSString(string: "/System/Library/PrivateFrameworks/AccessibilityUtilities.framework/AccessibilityUtilities")
        
        let localPath = path.fileSystemRepresentation
        
        guard localPath.pointee != 0 else {
            // TODO: throw error
            return
        }
        
        guard dlopen(localPath, RTLD_LOCAL) != nil else {
            // TODO: throw error
            return
        }
        
        guard let axBackBoardServerClass = NSClassFromString("AXBackBoardServer") as? NSObject.Type else {
            // TODO: throw error
            return
        }
        
        guard let server = axBackBoardServerClass.perform(Selector("server")).takeRetainedValue() as? NSObject else {
            // TODO: throw error
            return
        }
        
        let selector: Selector = NSSelectorFromString("setAccessibilityPreferenceAsMobile:value:notification:")
        let setAccessibilityPreferenceAsMobileImp: IMP! = server.method(for: selector)
        let setAccessibilityPreferenceAsMobile = unsafeBitCast(
            setAccessibilityPreferenceAsMobileImp,
            to: (@convention(c)(Any?,Selector,CFString!,CFBoolean!,CFString!)->Void).self
        )
        
        setAccessibilityPreferenceAsMobile(
            server,
            selector,
            "ApplicationAccessibilityEnabled" as CFString,
            kCFBooleanTrue,
            "com.apple.accessibility.cache.app.ax" as CFString
        )
        
        setAccessibilityPreferenceAsMobile(
            server,
            selector,
            "AccessibilityEnabled" as CFString,
            kCFBooleanTrue,
            "com.apple.accessibility.cache.ax" as CFString
        )
    }
}
