import Cartography
import UIKit

class HomeViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.alignment = .fill
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
        
        //TODO: Tirar o ! da UIImage
        stackView.addArrangedSubview(QuickAcessView(quickAccessTitle: "Perfil", quickAccessImage: UIImage(named: "UserLight")!))
        stackView.addArrangedSubview(QuickAcessView(quickAccessTitle: "Lembretes", quickAccessImage: UIImage()))
        stackView.addArrangedSubview(QuickAcessView(quickAccessTitle: "Histórico", quickAccessImage: UIImage()))
        stackView.addArrangedSubview(QuickAcessView(quickAccessTitle: "Compartilhar", quickAccessImage: UIImage()))
    }
    
    private func setupConstraints() {
        constrain(stackView, view) { stack, view in
            stack.top == view.safeAreaLayoutGuide.top
            stack.left == view.left
            stack.trailing == view.trailing
        }
    }
}
