protocol HomePresentationLogic: AnyObject {
    var viewController: HomeDisplayLogic? { get set }
    
    func presentUserEmergencyInfo(info: UserEmergencyInfo)
}

public final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    init() {}
    
    func presentUserEmergencyInfo(info: UserEmergencyInfo) {
        viewController?.displayUserEmergencyInfo(info: info)
    }
}
