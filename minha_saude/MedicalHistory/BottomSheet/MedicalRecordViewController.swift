import Cartography
import UIKit

public enum MedicalRecordViewControllerType {
    case new
    case edit
}

public protocol MedicalRecordDisplayDelegate: AnyObject {
    func viewWillDismiss()
}
                                        
protocol MedicalRecordDisplayLogic: UIViewController {
    func dismissBottomSheet()
}

class MedicalRecordViewController: UIViewController {
    private let interactor: MedicalRecordBusinessLogic
    private let type: MedicalRecordViewControllerType
    private let record: MedicalRecord?
    
    public weak var delegate: MedicalRecordDisplayDelegate?
    
    private let recordView: MedicalRecordView = {
        let view = MedicalRecordView()
        view.clipsToBounds = true
        return view
    }()
    
    public init(
        interactor: MedicalRecordBusinessLogic,
        type: MedicalRecordViewControllerType,
        record: MedicalRecord? = nil
    ) {
        self.interactor = interactor
        self.type = type
        self.record = record
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(recordView)
        
        recordView.delegate = self
        recordView.configure(type: type, record: record)
        
        constrain(recordView, view) { record, view in
            record.edges == view.edges
        }
    }
}

extension MedicalRecordViewController: MedicalRecordViewDelegate {
    func didTouchInSave(
        date: String,
        time: String,
        hospital: String,
        profesional: String,
        speciallity: String,
        observation: String,
        type: MedicalRecordType
    ) {
        if self.type == .new {
            interactor.saveNewRecord(
                date: date,
                time: time,
                hospital: hospital,
                profesional: profesional,
                speciallity: speciallity,
                observation: observation,
                type: type
            )
        } else if self.type == .edit {
            guard let recordId = record?.id else { return }
            interactor.saveEditedRecord(
                id: recordId,
                date: date,
                time: time,
                hospital: hospital,
                profesional: profesional,
                speciallity: speciallity,
                observation: observation,
                type: type
            )
            
        }
    }
    
    func didTouchInRemove() {
        guard let recordId = record?.id else { return }
        interactor.deleteRecord(id: recordId)
    }
}

extension MedicalRecordViewController: MedicalRecordDisplayLogic {
    func dismissBottomSheet() {
        delegate?.viewWillDismiss()
        dismiss(animated: true)
    }
}
