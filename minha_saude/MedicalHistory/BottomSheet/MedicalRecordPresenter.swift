protocol MedicalRecordPresentationLogic: AnyObject {
    var viewController: MedicalRecordDisplayLogic? { get set }
    
    func createdRecord()
    func editRecord()
    func deleteRecord()
}

public final class MedicalRecordPresenter: MedicalRecordPresentationLogic {
    weak var viewController: MedicalRecordDisplayLogic?
    
    init() {}
    
    //TODO: criar feedback de sucesso
    
    func createdRecord() {
        viewController?.dismissBottomSheet()
    }
    
    func editRecord() {
        viewController?.dismissBottomSheet()
    }
    
    func deleteRecord() {
        viewController?.dismissBottomSheet()
    }
}
