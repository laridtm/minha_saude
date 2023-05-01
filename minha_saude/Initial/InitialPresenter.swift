import Foundation

protocol InitialPresentationLogic: AnyObject {
    var viewController: InitialDisplayLogic? { get set }
    
    func presentError(_ error: String)
}

public final class InitialPresenter: InitialPresentationLogic {
    
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    weak var viewController: InitialDisplayLogic?
    
    init() {}
    
    func presentError(_ error: String) {
        viewController?.showToast(message: error, font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
