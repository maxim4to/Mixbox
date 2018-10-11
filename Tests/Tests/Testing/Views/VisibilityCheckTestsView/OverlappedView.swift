import UIKit
import MixboxUiKit

final class OverlappedView: UIView {
    let overlapping: CGFloat
    let overlappedView: UIView
    let overlappingView: UIView
    
    init(overlapping: CGFloat, overlappedView: UIView, overlappingView: UIView) {
        self.overlapping = overlapping
        self.overlappedView = overlappedView
        self.overlappingView = overlappingView
        
        super.init(frame: .zero)
        
        addSubview(overlappedView)
        addSubview(overlappingView)
    }
    
    convenience init(overlapping: CGFloat) {
        self.init(
            overlapping: overlapping,
            overlappedView: UIView(),
            overlappingView: UIView()
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        overlappedView.frame = bounds
        
        if overlapping <= 0 {
            overlappingView.frame = .zero
        } else if overlapping >= 1 {
            overlappingView.frame = bounds
        } else {
            overlappingView.frame = bounds
            overlappingView.mb_width = overlappingView.frame.width * overlapping
        }
    }
}
