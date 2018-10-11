import MixboxUiTestsFoundation
import MixboxTestsFoundation

// TODO: I think it doesn't wait if element is not visible. If element is not visible it should wait, because it
// can appear few moments later. So there is a possibility of false-positive check, which is a very bad thing.
final class InvisibilityCheckInteraction: Interaction {
    let description: InteractionDescription
    
    private let elementMatcher: ElementMatcher
    private let settings: ResolvedInteractionSettings
    private let elementVisibilityChecker: ElementVisibilityChecker
    private let scrollingHintsProvider: ScrollingHintsProvider
    private let elementFinder: ElementFinder
    private let interactionHelper: InteractionHelper
    
    init(
        settings: ResolvedInteractionSettings,
        elementFinder: ElementFinder,
        elementVisibilityChecker: ElementVisibilityChecker,
        scrollingHintsProvider: ScrollingHintsProvider,
        snapshotCaches: SnapshotCaches)
    {
        self.settings = settings
        self.description = InteractionDescription(
            type: .check,
            settings: settings
        )
        self.elementMatcher = settings.elementSettings.matcher
        self.elementFinder = elementFinder
        self.elementVisibilityChecker = elementVisibilityChecker
        self.scrollingHintsProvider = scrollingHintsProvider
        self.interactionHelper = InteractionHelper(
            messagePrefix: "Проверка не прошла",
            elementVisibilityChecker: elementVisibilityChecker,
            scrollingHintsProvider: scrollingHintsProvider,
            elementFinder: elementFinder,
            interactionSettings: description.settings,
            snapshotCaches: snapshotCaches
        )
    }
    
    func perform() -> InteractionResult {
        return interactionHelper.retryInteractionUntilTimeout {
            var resolvedElementQuery = interactionHelper.resolveElementWithRetries()
            
            let failedElementsResult = checkForFailedElements(
                resolvedElementQuery: &resolvedElementQuery
            )
            
            switch failedElementsResult {
            case .failedElementsVisibleAreas(let failedElementsVisibleAreas):
                return makeInteractionResult(
                    failedElementsVisibleAreas: failedElementsVisibleAreas,
                    resolvedElementQuery: resolvedElementQuery
                )
            case .error(let message):
                return interactionHelper.failureResult(
                    message: message
                )
            }
        }
    }
    
    private enum CheckForFailedElementsResult {
        case failedElementsVisibleAreas([CGFloat])
        case error(String)
    }
    
    private func checkForFailedElements(
        resolvedElementQuery: inout ResolvedElementQuery)
        -> CheckForFailedElementsResult
    {
        var failedElementsVisibleAreas = [CGFloat]()
        
        forEach: for var (index, snapshot) in resolvedElementQuery.matchingSnapshots.enumerated() {
            if snapshot.isDefinitelyHidden.value == true {
                // ok
            } else {
                let scrollingResult = interactionHelper.scrollIfNeeded(
                    snapshot: snapshot,
                    expectedIndexOfSnapshotInResolvedElementQuery: index,
                    resolvedElementQuery: resolvedElementQuery
                )
                
                snapshot = scrollingResult.updatedSnapshot
                resolvedElementQuery = scrollingResult.updatedResolvedElementQuery
                
                var alreadyCalculatedPercentageOfVisibleArea: CGFloat?
                
                switch scrollingResult.status {
                case .scrolled:
                    // Ok
                    break
                case .alreadyVisible(let percentageOfVisibleArea):
                    alreadyCalculatedPercentageOfVisibleArea = percentageOfVisibleArea
                case .elementWasLostAfterScroll:
                    // Ok
                    break forEach
                case .internalError:
                    // Before:
                    // return .error(message)
                    // After:
                    break
                    
                    // TODO: Investigate the problem:
                    //
                    // We had an error in testcase 23999:
                    // - isNotDisplayed check was used
                    // - the scrolling hints provider couldn't not provide hint
                    // - element was not visible
                    //
                    // So it should be a normal situation. We should not fail test if we can't scroll to something invisible.
                    //
                    // Scrolling hints provider returned `.canNotProvideHint`, then it was converted to `.internalError`
                    // and led to test failure. The name may be misleading. There might be problems somewhere near
                    // that code.
                }
                
                let percentageOfVisibleArea = alreadyCalculatedPercentageOfVisibleArea
                    ?? elementVisibilityChecker.percentageOfVisibleArea(
                        snapshot: snapshot,
                        blendingThreshold: settings.visibilityCheckSettings.blendingThreshold
                )
                
                if percentageOfVisibleArea >= settings.visibilityCheckSettings.minimalPercentageOfVisibleArea {
                    failedElementsVisibleAreas.append(percentageOfVisibleArea)
                }
            }
        }
        
        return .failedElementsVisibleAreas(failedElementsVisibleAreas)
    }
    
    func makeInteractionResult(
        failedElementsVisibleAreas: [CGFloat],
        resolvedElementQuery: ResolvedElementQuery)
        -> InteractionResult
    {
        if !failedElementsVisibleAreas.isEmpty {
            let message: String
            let visibleAreaThreshold = settings.visibilityCheckSettings.minimalPercentageOfVisibleArea
            
            if failedElementsVisibleAreas.count == 1 && resolvedElementQuery.matchingSnapshots.count == 1, let visibleArea = failedElementsVisibleAreas.first {
                message = "элемент является видимым (видимая площадь \(visibleArea) > \(visibleAreaThreshold))"
            } else {
                let totalCount = resolvedElementQuery.matchingSnapshots.count
                let areas = failedElementsVisibleAreas.map { "\($0)" }.joined(separator: ", ")
                message = "\(failedElementsVisibleAreas.count) из \(totalCount) подходящих элементов являются видимыми, пороговое значение видимой площади == \(visibleAreaThreshold), видимые площади элементов: \(areas)"
            }
            
            return interactionHelper.failureResult(
                resolvedElementQuery: resolvedElementQuery,
                message: message
            )
        } else {
            return .success
        }
    }
}
