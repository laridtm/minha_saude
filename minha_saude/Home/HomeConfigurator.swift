import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let interactor = HomeInteractor()
        return HomeViewController(interactor: interactor)
    }
}
