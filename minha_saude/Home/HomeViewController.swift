import Cartography
import UIKit

class HomeViewController: UIViewController {
    
    struct Constants {
        static let layoutMargins: CGFloat = 10
        static let stackViewSpacing: CGFloat = 24
        static let userInfoSpacing: CGFloat = 17
    }
    
    private let interactor: HomeInteractorBusinessLogic
    
    private let userInfoView: UserInfoView = {
        let view = UserInfoView()
        view.clipsToBounds = true
        return view
    }()
    
    private let userEmergencyInfoView: UserEmergencyInfoView = {
        let view = UserEmergencyInfoView()
        view.clipsToBounds = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: Constants.layoutMargins, bottom: 0, right: Constants.layoutMargins)
        stackView.spacing = Constants.stackViewSpacing
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
        view.addSubview(userEmergencyInfoView)
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
        constrain(userInfoView, userEmergencyInfoView, stackView, view) { userInfo, emergencyInfo, stack, view in
            userInfo.top == view.safeAreaLayoutGuide.top
            userInfo.leading == view.leading
            userInfo.trailing == view.trailing
            
            emergencyInfo.top == userInfo.bottom + Constants.userInfoSpacing
            emergencyInfo.leading == view.leading + Constants.stackViewSpacing
            emergencyInfo.trailing == view.trailing - Constants.stackViewSpacing
            
            stack.top == emergencyInfo.bottom + Constants.stackViewSpacing
            stack.leading == view.leading
            stack.trailing == view.trailing
        }
    }

}

extension HomeViewController: QuickAccessViewDelegate {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType) {
        interactor.didTouchQuickAccess(type: type)
    }
}
