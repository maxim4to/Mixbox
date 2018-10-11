import MixboxUiTestsFoundation
import XCTest

// TODO: unit/greybox tests with more test data.
final class VisibilityCheckTests: TestCase {
    // Less thorough test
    func test_manuallyConfiguredViews() {
        openScreen(name: "VisibilityCheckTestsView")
        
        waitScreenIsLoaded()
        
        // Visibility check checks every pixel.
        // It can be configured with blending theshold T.
        // If pixel is overlapped by another pixel with alpha = A:
        //     If A > T, then pixel is not visible
        //     If A <= T, then pixel is visible
        //
        // Current precision is about 0.01. So if A == 0.99 and T == 0.98 then pixel is not visible.
        //
        // More vivid examples.
        //
        // Imagine a white view:
        // +-------+
        // |       |
        // |       |
        // |       |
        // |       |
        // +-------+
        //
        // That is overlapped by a black view:
        // +-------+
        // |#######|
        // |#######|
        // |#######|
        // |#######|
        // +-------+
        //
        // Black view opacity:  0.50
        // Blending Threshold:  1.00 => visible (1.0 means that there is no theshold)
        // Blending Threshold:  0.51 => visible
        // Blending Threshold:  0.49 => invisible
        // Blending Threshold:  0.00 => invisible (0.0 means zero tolerance)
        // +-------+
        // |# # # #|
        // | # # # |
        // |# # # #|
        // | # # # |
        // +-------+
        //
        // Alpha:              0.25
        // Blending Threshold  0.26 => visible
        // Blending Threshold  0.24 => invisible
        // +-------+
        // |#   #  |
        // |  #   #|
        // |#   #  |
        // |  #   #|
        // +-------+
        
        assertIsDisplayed("obviouslyVisibleView", area: 1, blendingThreshold: 0)
        assertIsDisplayed("obviouslyVisibleView", area: 1, blendingThreshold: 1)
        assertIsDisplayed("obviouslyVisibleView", area: 0.5, blendingThreshold: 1)
        
        assertIsNotDisplayed("overlappedWith07AlphaView1", area: 1, blendingThreshold: 0)
        assertIsDisplayed("overlappedWith07AlphaView1", area: 1, blendingThreshold: 1)
        assertIsDisplayed("overlappedWith07AlphaView1", area: 1, blendingThreshold: 0.71)
        assertIsNotDisplayed("overlappedWith07AlphaView1", area: 1, blendingThreshold: 0.69)
        
        assertIsNotDisplayed("overlappedWith07AlphaView2", area: 1, blendingThreshold: 0)
        assertIsDisplayed("overlappedWith07AlphaView2", area: 1, blendingThreshold: 1)
        assertIsDisplayed("overlappedWith07AlphaView2", area: 1, blendingThreshold: 0.71)
        assertIsNotDisplayed("overlappedWith07AlphaView2", area: 1, blendingThreshold: 0.69)
        
        assertIsDisplayed("halfOverlappedView", area: 0, blendingThreshold: 0)
        assertIsDisplayed("halfOverlappedView", area: 0.5, blendingThreshold: 0)
        assertIsNotDisplayed("halfOverlappedView", area: 1, blendingThreshold: 0)
        
        assertIsDisplayed("notOverlappedView", area: 1, blendingThreshold: 0)
        // Superview is not overlapped by its subviews, subviews are contents of their superview
        assertIsDisplayed("superviewOfNotOverlappedView", area: 1, blendingThreshold: 0)
    }
//    
//    // More thorough test
//    func test_onGeneratedData() {
//        openScreen(name: "VisibilityCheckTestsView")
//        
//        waitScreenIsLoaded()
//        
//        let testData = VisibilityCheckTestDataProvider().testDataForOverlappingTests()
//        XCTAssertGreaterThan(testData.count, 100, "Why so little test data?")
//        
//        for viewSettings in testData {
//            // areaPrecision can be very low if view is small.
//            // TODO: make this test less dependent on views size
//            let areaPrecision: CGFloat = 0.1
//            let visibileAreaTreshold = 1 - viewSettings.overlapping
//            let expectedSatisfactoryPercentageOfVisibileArea = max(
//                1,
//                visibileAreaTreshold - areaPrecision
//            )
//            let expectedUnsatisfactoryPercentageOfVisibileArea = min(
//                0,
//                visibileAreaTreshold + areaPrecision
//            )
//            
//            // alpha=0.80 && blendingThreshold=0.21 => visible
//            // alpha=0.80 && blendingThreshold=0.20 => visible
//            // alpha=0.80 && blendingThreshold=0.19 => not visible
//            
//            let precisionOfBlendingThreshold: CGFloat = 0.01
//            
//            let blendingThresholdThatMakesOverlappingViewTransparentForCheck = viewSettings.overlappingColor.alpha
//            let blendingThresholdThatMakesOverlappingViewOpaqueForCheck = min(
//                blendingThresholdThatMakesOverlappingViewTransparentForCheck - precisionOfBlendingThreshold,
//                0
//            )
//            
//            let id = viewSettings.id
//            
//            assertIsDisplayed(
//                id,
//                area: expectedSatisfactoryPercentageOfVisibileArea,
//                blendingThreshold: blendingThresholdThatMakesOverlappingViewOpaqueForCheck
//            )
//            
//            let percentageOfVisibleAreaCanMatter = expectedSatisfactoryPercentageOfVisibileArea != expectedUnsatisfactoryPercentageOfVisibileArea
//            
//            if percentageOfVisibleAreaCanMatter {
//                assertIsNotDisplayed(
//                    id,
//                    area: expectedUnsatisfactoryPercentageOfVisibileArea,
//                    blendingThreshold: blendingThresholdThatMakesOverlappingViewOpaqueForCheck
//                )
//            }
//            
//            let overlappingFactorCanBeSuppressed = viewSettings.overlapping != 0
//                && blendingThresholdThatMakesOverlappingViewTransparentForCheck != blendingThresholdThatMakesOverlappingViewOpaqueForCheck
//            
//            if overlappingFactorCanBeSuppressed {
//                assertIsDisplayed(
//                    id,
//                    area: 1,
//                    blendingThreshold: blendingThresholdThatMakesOverlappingViewTransparentForCheck
//                )
//            }
//        }
//    }
    
    private var screen: Screen {
        return pageObjects.screen
    }
    
    private func waitScreenIsLoaded() {
        let anyVisibleView: ViewElement = screen.element("anyVisibleView") { $0.id == "obviouslyVisibleView" }
        
        anyVisibleView.isDisplayed()
    }
    
    // Note: requires waitScreenIsLoaded() at the beginning of test
    private func assertIsDisplayed(
        _ id: String,
        area: CGFloat?,
        blendingThreshold: CGFloat?,
        file: StaticString = #file,
        line: UInt = #line)
    {
        let element = screen
            .view(id)
            .withoutTimeout
            .with(minimalPercentageOfVisibleArea: area)
            .with(blendingThresholdForVisibilityCheck: blendingThreshold)
        
        // That moment you realize that you shouldn't have two implementations of opposite checks
        element.assert.isDisplayed(file: file, line: line)
        XCTAssertFalse(element.isNotDisplayed(), file: file, line: line)
    }
    
    // Note: requires waitScreenIsLoaded() at the beginning of test
    private func assertIsNotDisplayed(
        _ id: String,
        area: CGFloat?,
        blendingThreshold: CGFloat?,
        file: StaticString = #file,
        line: UInt = #line)
    {
        let element = screen
            .view(id)
            .withoutTimeout
            .with(minimalPercentageOfVisibleArea: area)
            .with(blendingThresholdForVisibilityCheck: blendingThreshold)
        
        element.assert.isNotDisplayed(file: file, line: line)
        XCTAssertFalse(element.isDisplayed(), file: file, line: line)
    }
}

private final class Screen: BasePageObjectWithDefaultInitializer {
    func view(_ id: String) -> ViewElement {
        return element(id) { element in element.id == id }
    }
}

private extension PageObjects {
    var screen: Screen {
        return pageObject()
    }
}
