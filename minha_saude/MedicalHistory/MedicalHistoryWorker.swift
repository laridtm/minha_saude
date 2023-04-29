import Moya

protocol MedicalHistoryWorkerLogic {
    func fetchMedicalHistory(id: String, filterType: MedicalRecordType?, completion: @escaping(Result<[MedicalRecord], Error>) -> Void)
}

public final class MedicalHistoryWorker: MedicalHistoryWorkerLogic {
    init() { }
    
    func fetchMedicalHistory(id: String, filterType: MedicalRecordType?, completion: @escaping(Result<[MedicalRecord], Error>) -> Void) {
        let provider = MoyaProvider<MedicalHistoryRequest>()
        
        provider.request(.fetchMedicalHistory(id: id, filterType: filterType)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let records = try filteredResponse.map([MedicalRecord].self)
                    
                    completion(.success(records))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
