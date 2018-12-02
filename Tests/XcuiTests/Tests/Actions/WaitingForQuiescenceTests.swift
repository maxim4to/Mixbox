import MixboxUiTestsFoundation
import XCTest

final class WaitingForQuiescenceTests: TestCase {
    override func precondition() {
        openScreen(name: "WaitingForQuiescenceTestsView")
    }
    
    // There is a problem that is reproduced under heavy load (when multiple simulators are active),
    // It seems that taps are either lost or UI is not ready for tap,
    // for example if new screen is opened (view controller is pushed)
    // and tap occures immediately. I didn't reproduce it on a local machine
    // and the bug is flaky.
    //
    // TODO: Reproduce the problem in tests and fix it.
    // See `insertDelayBeforeAction` in code, delete it, it is a workaround for a problem.
    func test() {
        continueAfterFailure = false
        
        for _ in 0..<5 {
            pageObjects.xcui.backButton.assert.hasText("0")
            pageObjects.xcui.pushButton.tap()
            pageObjects.xcui.backButton.assert.hasText("1")
            pageObjects.xcui.backButton.tap()
        }
    }
}

private final class Screen: BasePageObjectWithDefaultInitializer {
    var pushButton: ButtonElement {
        return element("push") {
            $0.id == "push"
        }
    }
    var label: ViewElement {
        return element("label") {
            $0.id == "label"
        }
    }
    var backButton: ButtonElement {
        return element("back") {
            $0.id == "back"
        }
    }
}

private extension PageObjects {
    var real: Screen {
        return apps.mainRealHierarchy.pageObject()
    }
    var xcui: Screen {
        return apps.mainXcui.pageObject()
    }
}
