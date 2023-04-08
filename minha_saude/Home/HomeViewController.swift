import Cartography
import UIKit

class HomeViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        stackView.spacing = 24
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setupStackView()
        setupConstraints()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        let shortcuts: [QuickAcessView.QuickAccessType] = [.profile, .reminders, .history, .share]
        shortcuts.forEach {
            stackView.addArrangedSubview(QuickAcessView(type: $0))
        }
    }
    
    private func setupConstraints() {
        constrain(stackView, view) { stack, view in
            stack.top == view.safeAreaLayoutGuide.top
            stack.left == view.left
            stack.trailing == view.trailing
        }
    }
}
