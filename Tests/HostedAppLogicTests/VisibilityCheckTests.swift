import XCTest
@testable import Tests
@testable import MixboxInAppServices

//private extension CGFloat {
//    var bounded: CGFloat {
//        return min(1, max(0, self))
//    }
//}

class VisibilityCheckTests: XCTestCase {
    let viewController = TestingViewController(
        testingViewControllerSettings: TestingViewControllerSettings(
            name: "VisibilityCheckTestsView"
        )
    )
    
    private var viewToHighlightOnFailure: UIView?
    override func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {
        viewToHighlightOnFailure?.layer.borderColor = UIColor.purple.cgColor
        viewToHighlightOnFailure?.layer.borderWidth = 4

        for _ in 0..<10 {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        }

        super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)

        // Set breakpoint on this line (highlighted state).

        viewToHighlightOnFailure?.layer.borderWidth = 0
        
        for _ in 0..<10 {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        }

        // Set breakpoint on this line (clear state).
    }
//
//    func testExample() {
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = viewController
//
//        waitScreenIsLoaded()
//
//        let testData = VisibilityCheckTestDataProvider().testDataToCheckOverlapping()
//        //XCTAssertGreaterThan(testData.count, 100, "Why so little test data?")
//
//        for viewSettings in testData {
//            guard let view = element(id: viewSettings.id) else {
//                XCTFail("View \(viewSettings.id) not found")
//                return
//            }
//
//            viewToHighlightOnFailure = view
//
//            check(view: view, viewSettings: viewSettings)
//        }
//    }
    
    func find(view: UIView, l: CGFloat, r: CGFloat) -> CGFloat {
        let m = (l + r) / 2
        let d = (r - l)
        if d <= 0.01 {
            return m
        } else {
            if view.percentageOfVisibleArea(blendingThreshold: m) > 0.5 {
                return find(view: view, l: l, r: m)
            } else {
                return find(view: view, l: m, r: r)
            }
        }
    }
    
    func testExample() {
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = viewController
        
        waitScreenIsLoaded()
        
        let testData = VisibilityCheckTestDataProvider().testDataToCheckOverlapping()
        //XCTAssertGreaterThan(testData.count, 100, "Why so little test data?")
        
        for (i, viewSettings) in testData.enumerated() {
            guard let view = element(id: viewSettings.id) else {
                XCTFail("View \(viewSettings.id) not found")
                return
            }
            
            autoreleasepool {
                let bt = ceil(find(view: view, l: 0, r: 1) * 1000) / 1000.0
                print("\(viewSettings.overlappingColor.alpha)\t\(bt)")
            }
        }
    }

    private func check(
        view: UIView,
        viewSettings: VisibilityCheckTestsViewSettings,
        file: StaticString = #file,
        line: UInt = #line)
    {
        checkWithBlendingThresholdEquals0(view: view, viewSettings: viewSettings, file: file, line: line)
        checkBelowBlendingThreshold(view: view, viewSettings: viewSettings, file: file, line: line)
        checkAboveBlendingThreshold(view: view, viewSettings: viewSettings, file: file, line: line)
        checkWithBlendingThresholdEquals1(view: view, viewSettings: viewSettings, file: file, line: line)
    }
    
    private func checkWithBlendingThresholdEquals0(
        view: UIView,
        viewSettings: VisibilityCheckTestsViewSettings,
        file: StaticString = #file,
        line: UInt = #line)
    {
        if viewSettings.overlappingViewIsVisible {
            let precentageOfVisibleArea = view.percentageOfVisibleArea(
                blendingThreshold: 0
            )
        
            assertInRange(
                precentageOfVisibleArea,
                viewSettings.nonOverlappedAreaRange,
                "If blendingThreshold is 0 then view should be always overlapped (\(viewSettings))"
            )
        }
    }
    
    private func checkWithBlendingThresholdEquals1(
        view: UIView,
        viewSettings: VisibilityCheckTestsViewSettings,
        file: StaticString = #file,
        line: UInt = #line)
    {
        let precentageOfVisibleArea = view.percentageOfVisibleArea(
            blendingThreshold: 1
        )
        
        XCTAssertEqual(
            precentageOfVisibleArea,
            1,
            "If blendingThreshold is 1 then percentageOfVisibleArea is always 1 (\(viewSettings))"
        )
    }
//
//    private func decorateFailureMessage(
//        message: String,
//        viewSettings: VisibilityCheckTestsViewSettings)
//        -> String
//    {
//        return "
//    }
    
    private func checkBelowBlendingThreshold(
        view: UIView,
        viewSettings: VisibilityCheckTestsViewSettings,
        file: StaticString = #file,
        line: UInt = #line)
    {
        if viewSettings.overlappingViewIsVisible {
            let precentageOfVisibleArea = view.percentageOfVisibleArea(
                blendingThreshold: viewSettings.blendingThresholdRange.lowerBound
            )
            
            assertInRange(
                precentageOfVisibleArea,
                viewSettings.nonOverlappedAreaRange,
                "If blendingThreshold is below a certain value then view should be overlapped (\(viewSettings))"
            )
        }
    }
    
    private func checkAboveBlendingThreshold(
        view: UIView,
        viewSettings: VisibilityCheckTestsViewSettings,
        file: StaticString = #file,
        line: UInt = #line)
    {
        let precentageOfVisibleArea = view.percentageOfVisibleArea(
            blendingThreshold: viewSettings.blendingThresholdRange.upperBound
        )
        
        XCTAssertEqual(
            precentageOfVisibleArea,
            1,
            "If blendingThreshold is above a certain value  then percentageOfVisibleArea is 1 (\(viewSettings))"
        )
    }
    
    private func assertInRange<T>(
        _ value: T,
        _ range: ClosedRange<T>,
        _ message: String,
        file: StaticString = #file,
        line: UInt = #line)
    {
        XCTAssertGreaterThanOrEqual(value, range.lowerBound, message, file: file, line: line)
        XCTAssertLessThanOrEqual(value, range.upperBound, message, file: file, line: line)
    }
    
    private func waitScreenIsLoaded() {
        let start = Date()
        while Date().timeIntervalSince(start) < 2 {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
        }
    }
    
    private func element(id: String, inside: UIView? = nil) -> UIView? {
        guard let view = inside ?? viewController.view else {
            return nil
        }
        
        if view.accessibilityIdentifier == id {
            return view
        }
        
        for subview in view.subviews {
            if let matchingElement = element(id: id, inside: subview) {
                return matchingElement
            }
        }
        
        return nil
    }
    
//    // Note: requires waitScreenIsLoaded() at the beginning of test
//    private func assert(
//        areaIsGreaterThanOrEqualTo: CGFloat,
//        id: String,
//        blendingThreshold: CGFloat,
//        file: StaticString = #file,
//        line: UInt = #line)
//    {
//        guard let view = element(id: id) else {
//            XCTFail("View \(id) not found")
//            return
//        }
//
//        let precentageOfVisibleArea = view.percentageOfVisibleArea(blendingThreshold: blendingThreshold)
//
//        XCTAssertGreaterThanOrEqual(precentageOfVisibleArea, area, file: file, line: line)
//    }
    
    // Note: requires waitScreenIsLoaded() at the beginning of test
    private func assertIsNotDisplayed(
        _ id: String,
        area: CGFloat,
        blendingThreshold: CGFloat,
        file: StaticString = #file,
        line: UInt = #line)
    {
        guard let view = element(id: id) else {
            XCTFail("View \(id) not found")
            return
        }
        
        let precentageOfVisibleArea = view.percentageOfVisibleArea(blendingThreshold: blendingThreshold)
        
        XCTAssertLessThan(precentageOfVisibleArea, area, file: file, line: line)
    }
}
