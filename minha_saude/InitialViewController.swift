import Cartography
import UIKit

class InitialViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 6
        static let spacing: CGFloat = 20
    }
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.ColorAssets.brandGreen.color
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(enterApp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.ColorAssets.background.color
        addEnterButton()
    }

    @objc private func enterApp() {
        let homeViewController = HomeConfigurator().resolve()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func addEnterButton() {
        view.addSubview(enterButton)
        constrain(enterButton, view) { button, view in
            button.leading == view.leading + Constants.spacing
            button.trailing == view.trailing - Constants.spacing
            button.centerY == view.centerY
        }
    }
}
