public final class VisibilityCheckSettingsCustomization {
    public let minimalPercentageOfVisibleArea: CGFloat? // nil => default
    public let blendingThreshold: CGFloat? // nil => default
    
    public static var `default`: VisibilityCheckSettingsCustomization {
        return VisibilityCheckSettingsCustomization(
            minimalPercentageOfVisibleArea: nil,
            blendingThreshold: nil
        )
    }
    
    public init(
        minimalPercentageOfVisibleArea: CGFloat?,
        blendingThreshold: CGFloat?)
    {
        self.minimalPercentageOfVisibleArea = minimalPercentageOfVisibleArea
        self.blendingThreshold = blendingThreshold
    }
}
