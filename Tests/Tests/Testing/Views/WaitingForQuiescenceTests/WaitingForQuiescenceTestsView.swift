import UIKit
import MixboxFoundation

final class WaitingForQuiescenceTestsView: TestStackScrollView {
    private let navigationController = UINavigationController()
    private let pushButton = ButtonWithClosures()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewController = ViewController(index: 0)
        
        navigationController.pushViewController(viewController, animated: false)
        
        addSubview(navigationController.view)
        addSubview(pushButton)
        
        pushButton.setTitleColor(.black, for: .normal)
        pushButton.setTitle("push", for: .normal)
        pushButton.accessibilityIdentifier = "push"
        
        pushButton.onTap = { [weak self] in
            self?.push()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func push() {
        let viewController = ViewController(index: navigationController.viewControllers.count)
        
        viewController.button.onTap = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pushButton.frame = CGRect(
            left: bounds.mb_left,
            right: bounds.mb_right,
            top: bounds.mb_top,
            height: 100
        )
        navigationController.view.frame = CGRect(
            left: bounds.mb_left,
            right: bounds.mb_right,
            top: pushButton.mb_bottom,
            bottom: bounds.mb_bottom
        )
    }
}

private final class ViewController: UIViewController {
    let button = ButtonWithClosures()
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        
        let color: UIColor
        if index <= 0 {
            color = .white
        } else {
            let colors: [UIColor] = [.red, .green, .blue]
            color = colors[(index - 1) % 3]
        }
        
        button.backgroundColor = color
        
        button.setTitle("\(index)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.accessibilityIdentifier = "back"
        
        view = button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

