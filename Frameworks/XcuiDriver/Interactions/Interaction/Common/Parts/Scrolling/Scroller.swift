import MixboxUiTestsFoundation
import XCTest
import MixboxIpcCommon

final class Scroller {
    private let scrollingHintsProvider: ScrollingHintsProvider
    private let elementVisibilityChecker: ElementVisibilityChecker
    private let visibilityCheckSettings: VisibilityCheckSettings
    private let elementResolver: ElementResolver
    
    init(
        scrollingHintsProvider: ScrollingHintsProvider,
        elementVisibilityChecker: ElementVisibilityChecker,
        visibilityCheckSettings: VisibilityCheckSettings,
        elementResolver: ElementResolver)
    {
        self.scrollingHintsProvider = scrollingHintsProvider
        self.elementVisibilityChecker = elementVisibilityChecker
        self.visibilityCheckSettings = visibilityCheckSettings
        self.elementResolver = elementResolver
    }
    
    func scrollIfNeeded(
        snapshot: ElementSnapshot,
        expectedIndexOfSnapshotInResolvedElementQuery: Int,
        resolvedElementQuery: ResolvedElementQuery)
        -> ScrollingResult
    {
        if snapshot.frameOnScreen == .zero {
            // Fake cells have .zero accessibilityFrame, even if we set the value of it.
            // Probably, AX Client just ignores it if the element has no superview.
            
            // Need to scroll.
        } else {
            let frame = ApplicationFrameProvider.frame
            
            if frame.mb_intersectionOrNil(snapshot.frameOnScreen) != nil {
                // Element intersects screen.
                // We don't care if it is fully on screen or partially.
                // We just filter out the case when it is completely off screen.
                //
                // If element is partially on screen it might be "sufficiently visible" (and vice versa).
                // If it is fully on screen it can also be either sufficiently visible ot not.
                //
                // So in any case we must do the check if it is not comopletely off screen.
                let percentageOfVisibleArea = elementVisibilityChecker.percentageOfVisibleArea(
                    snapshot: snapshot,
                    blendingThreshold: visibilityCheckSettings.blendingThreshold
                )
                
                let elementIsSufficientlyVisible = percentageOfVisibleArea >= visibilityCheckSettings.minimalPercentageOfVisibleArea
                
                if elementIsSufficientlyVisible {
                    // sufficiently visible
                    
                    return ScrollingResult(
                        status: .alreadyVisible(percentageOfVisibleArea: percentageOfVisibleArea),
                        updatedSnapshot: snapshot,
                        updatedResolvedElementQuery: resolvedElementQuery
                    )
                } else {
                    // not sufficiently visible
                }
            } else {
                // off screen / can not be visible
            }
        }
        
        let scrollingContext = ScrollingContext(
            snapshot: snapshot,
            expectedIndexOfSnapshotInResolvedElementQuery: expectedIndexOfSnapshotInResolvedElementQuery,
            resolvedElementQuery: resolvedElementQuery,
            scrollingHintsProvider: scrollingHintsProvider,
            elementVisibilityChecker: elementVisibilityChecker,
            visibilityCheckSettings: visibilityCheckSettings,
            elementResolver: elementResolver
        )
        
        return scrollingContext.scrollIfNeeded()
    }
}
