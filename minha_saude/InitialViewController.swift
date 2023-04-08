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
        button.backgroundColor = .green //UIColor(cgColor: .init(red: 75, green: 175, blue: 80, alpha: 1)) //#4CAF50
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(enterApp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addEnterButton()
    }

    @objc private func enterApp() {
        let interactor = HomeInteractor()
        let home = HomeViewController(interactor: interactor)
        navigationController?.pushViewController(home, animated: true)
        print("Entrar")
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
