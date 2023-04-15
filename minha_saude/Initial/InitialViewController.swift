import Cartography
import UIKit

class InitialViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 6
        static let spacing: CGFloat = 20
        static let logoSize: CGFloat = 244
        static let logoFontSize: CGFloat = 32
        static let topSpacing: CGFloat = 215
        static let centerSpacing: CGFloat = 10
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.image = Asset.Assets.minhaSaudeLogo.image
        return imageView
    }()
    
    private let minhaSaudeLabel: UILabel = {
        let label = UILabel()
        label.text = "MINHA SAÚDE"
        label.font = UIFont.boldSystemFont(ofSize: Constants.logoFontSize)
        label.textColor = Asset.ColorAssets.brandBlue.color
        label.textAlignment = .center
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite seu CPF"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
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
        view.addSubview(imageView)
        view.addSubview(minhaSaudeLabel)
        view.addSubview(idTextField)
        view.addSubview(enterButton)
        
        constrain(imageView, minhaSaudeLabel, idTextField, enterButton, view) { image, appName, id, button, view in
            image.width == Constants.logoSize
            image.height == Constants.logoSize
            image.centerX == view.centerX
            image.top == view.top + Constants.topSpacing
            
            appName.centerX == view.centerX
            appName.top == image.bottom + Constants.centerSpacing
            
            id.top == appName.bottom + Constants.spacing
            id.leading == view.leading + Constants.spacing
            id.trailing == view.trailing - Constants.spacing
            
            button.top == id.bottom + Constants.spacing
            button.leading == view.leading + Constants.spacing
            button.trailing == view.trailing - Constants.spacing
        }
    }
}
