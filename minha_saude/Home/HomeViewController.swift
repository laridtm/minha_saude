import Cartography
import UIKit

class HomeViewController: UIViewController {
    private let interactor: HomeInteractorBusinessLogic
    
    private let userInfoView: UserInfoView = {
        let view = UserInfoView()
        view.clipsToBounds = true
        return view
    }()
    
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
    
    public init(interactor: HomeInteractorBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.ColorAssets.background.color
        configure()
    }
    
    private func configure() {
        view.addSubview(userInfoView)
        setupStackView()
        setupConstraints()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        let shortcuts: [QuickAcessView.QuickAccessType] = [.profile, .reminders, .history, .share]
        shortcuts.forEach {
            let view = QuickAcessView(type: $0)
            view.delegate = self
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupConstraints() {
        constrain(userInfoView, stackView, view) { userInfo, stack, view in
            userInfo.top == view.safeAreaLayoutGuide.top
            userInfo.left == view.left
            userInfo.trailing == view.trailing
            
            stack.top == userInfo.bottom + 25
            stack.left == view.left
            stack.trailing == view.trailing
        }
    }

}

extension HomeViewController: QuickAccessViewDelegate {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType) {
        interactor.didTouchQuickAccess(type: type)
    }
}
