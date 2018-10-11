import CoreGraphics

struct VisibilityCheckTestsViewSettings {
    let overlappedColor: Color
    let overlappingColor: Color
    let superviewColor: Color
    let overlapping: CGFloat
    let id: String
    
    // This is actually depends on blending algorithm,
    // so thresholds should go along with colors.
    // E.g. view is overlapped by view with alpha 0.5.
    // Blending threshold is somewhere around 0.1..0.9
    let blendingThresholdRange: ClosedRange<CGFloat>
    
    // This depends on actual view size so should be in sync with bigger view that draws views.
    let overlappedAreaRange: ClosedRange<CGFloat>
    
    var nonOverlappedAreaRange: ClosedRange<CGFloat> {
        return (1 - overlappedAreaRange.upperBound)...(1 - overlappedAreaRange.lowerBound)
    }
    
    var overlappingViewIsVisible: Bool {
        return overlappingColor.alpha > 0
    }
}

struct Color {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
}
