import UIKit

extension UIColor {
    convenience init(color: Color) {
        self.init(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: color.alpha
        )
    }
}

final class VisibilityCheckTestsView: UIView {
    let views: [UIView]
    
    init() {
        views = VisibilityCheckTestsView.views()
        
        super.init(frame: .zero)
        
        for view in views {
            addSubview(view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let insets = UIEdgeInsets(
            top: 40, // Avoid status bar
            left: 10, // Looks cool
            bottom: 120, // Avoid consequences of imperfections in algorithm (e.g. offscreen views)
            right: 10  // Looks cool
        )
        let frameOfViews = bounds.mb_shrinked(insets)
        
        let availableArea = frameOfViews.width * frameOfViews.height
        let areaOfView = ceil(availableArea / CGFloat(views.count))
        let sideOfGrid = ceil(sqrt(areaOfView))
        let sideOfView = sideOfGrid - 1
        
        let columns = Int(frameOfViews.width / sideOfGrid)
        
        for (index, view) in views.enumerated() {
            let row = index % columns
            let column = index / columns
            
            view.frame = CGRect(
                x: insets.left + CGFloat(row) * sideOfGrid,
                y: insets.top + CGFloat(column) * sideOfGrid,
                width: sideOfView,
                height: sideOfView
            )
        }
    }
    
    static func views() -> [UIView] {
        return manuallyConfiguredViews() + generatedViews()
    }
    
    static func generatedViews() -> [UIView] {
        var views = [UIView]()
        
        for viewSettings in VisibilityCheckTestDataProvider().testDataToCheckOverlapping() {
            let view = OverlappedView(
                overlapping: viewSettings.overlapping
            )
            view.overlappedView.backgroundColor = UIColor(color: viewSettings.overlappedColor)
            view.overlappingView.backgroundColor = UIColor(color: viewSettings.overlappingColor)
            view.overlappedView.accessibilityIdentifier = viewSettings.id
            view.backgroundColor = UIColor(color: viewSettings.superviewColor)
            views.append(view)
        }
        
        return views
    }
    
    static func manuallyConfiguredViews() -> [UIView] {
        var views = [UIView]()
        
        let obviouslyVisibleView = UIView()
        obviouslyVisibleView.backgroundColor = .red
        obviouslyVisibleView.accessibilityIdentifier = "obviouslyVisibleView"
        views.append(obviouslyVisibleView)
        
        let overlappedWith07AlphaViaBackgroundColorPropertyView = OverlappedView(overlapping: 1)
        overlappedWith07AlphaViaBackgroundColorPropertyView.overlappedView.backgroundColor = .red
        overlappedWith07AlphaViaBackgroundColorPropertyView.overlappingView.backgroundColor = UIColor(white: 1, alpha: 0.7)
        overlappedWith07AlphaViaBackgroundColorPropertyView.overlappedView.accessibilityIdentifier = "overlappedWith07AlphaViaBackgroundColorPropertyView"
        views.append(overlappedWith07AlphaViaBackgroundColorPropertyView)
        
        let overlappedWith07AlphaViaAlphaPropertyView = OverlappedView(overlapping: 1)
        overlappedWith07AlphaViaAlphaPropertyView.overlappedView.backgroundColor = .red
        overlappedWith07AlphaViaAlphaPropertyView.overlappingView.backgroundColor = UIColor(white: 1, alpha: 1)
        overlappedWith07AlphaViaAlphaPropertyView.overlappingView.alpha = 0.7
        overlappedWith07AlphaViaAlphaPropertyView.overlappedView.accessibilityIdentifier = "overlappedWith07AlphaViaAlphaPropertyView"
        views.append(overlappedWith07AlphaViaAlphaPropertyView)
        
        let halfOverlappedView = OverlappedView(overlapping: 0.5)
        halfOverlappedView.overlappedView.backgroundColor = .red
        halfOverlappedView.overlappingView.backgroundColor = .blue
        halfOverlappedView.overlappedView.accessibilityIdentifier = "halfOverlappedView"
        views.append(halfOverlappedView)
        
        let notOverlappedView = OverlappedView(overlapping: 0)
        notOverlappedView.overlappedView.backgroundColor = .red
        notOverlappedView.overlappingView.backgroundColor = .blue
        notOverlappedView.overlappedView.accessibilityIdentifier = "notOverlappedView"
        notOverlappedView.accessibilityIdentifier = "superviewOfNotOverlappedView"
        views.append(notOverlappedView)
        
        let overlappedWith0AlphaViaBackgroundColorPropertyView = OverlappedView(overlapping: 1)
        overlappedWith0AlphaViaBackgroundColorPropertyView.overlappedView.backgroundColor = .red
        overlappedWith0AlphaViaBackgroundColorPropertyView.overlappingView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        overlappedWith0AlphaViaBackgroundColorPropertyView.overlappedView.accessibilityIdentifier = "overlappedWith0AlphaViaBackgroundColorPropertyView"
        views.append(overlappedWith0AlphaViaBackgroundColorPropertyView)
        
        let overlappedWith0AlphaViaAlphaPropertyView = OverlappedView(overlapping: 1)
        overlappedWith0AlphaViaAlphaPropertyView.overlappedView.backgroundColor = .red
        overlappedWith0AlphaViaAlphaPropertyView.overlappingView.backgroundColor = UIColor(white: 1, alpha: 1)
        overlappedWith0AlphaViaAlphaPropertyView.overlappingView.alpha = 0
        overlappedWith0AlphaViaAlphaPropertyView.overlappedView.accessibilityIdentifier = "overlappedWith0AlphaViaAlphaPropertyView"
        views.append(overlappedWith0AlphaViaAlphaPropertyView)
        
        return views
    }
}
