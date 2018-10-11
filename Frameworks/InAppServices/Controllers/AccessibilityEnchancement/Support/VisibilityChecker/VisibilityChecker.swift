protocol VisibilityChecker {
    func percentageOfVisibleArea(
        view: UIView,
        blendingThreshold: CGFloat)
        -> CGFloat
}

final class VisibilityCheckerImpl: VisibilityChecker {
    func percentageOfVisibleArea(
        view: UIView,
        blendingThreshold: CGFloat)
        -> CGFloat
    {
        return CGFloat(
            VisibilityCheckerObjC.percentageOfVisibleArea(
                of: view,
                withBlendingThreshold: blendingThreshold
            )
        )
    }
}
