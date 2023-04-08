import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor(router: router)
        return HomeViewController(interactor: interactor)
    }
}
