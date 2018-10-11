// Note that VisibilityCheckSettingsCustomization is used in tests.
public final class VisibilityCheckSettings {
    public let minimalPercentageOfVisibleArea: CGFloat
    public let blendingThreshold: CGFloat
    
    // Almost as in EarlGrey, despite it was a side-effect of rounding.
    // I think we should pick up a better value. EarlGrey has too high threshold
    // and it can "see" views that an average person can not see.
    public static let defaultBlendingThreshold: CGFloat = 0.9
    
    public init(
        minimalPercentageOfVisibleArea: CGFloat,
        blendingThreshold: CGFloat = defaultBlendingThreshold)
    {
        self.minimalPercentageOfVisibleArea = minimalPercentageOfVisibleArea
        self.blendingThreshold = blendingThreshold
    }
    
    public func customized(customization: VisibilityCheckSettingsCustomization) -> VisibilityCheckSettings {
        return VisibilityCheckSettings(
            minimalPercentageOfVisibleArea: customization.minimalPercentageOfVisibleArea ?? minimalPercentageOfVisibleArea,
            blendingThreshold: customization.blendingThreshold ?? blendingThreshold
        )
    }
}
