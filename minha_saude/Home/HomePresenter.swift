protocol HomePresentationLogic: AnyObject {
    var viewController: HomeDisplayLogic? { get set }
    
    func presentUserInfo(info: UserInfo)
}

public final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    init() {}
    
    func presentUserInfo(info: UserInfo) {
        viewController?.displayUserInfo(info: info)
    }
}
