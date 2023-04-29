import Moya

protocol MedicalHistoryWorkerLogic {
    func fetchMedicalHistory(
        id: String,
        filterType: MedicalRecordType?,
        completion: @escaping(Result<[MedicalRecord], Error>) -> Void
    )
    func saveRecord(userId: String, record: MedicalRecord, completion: @escaping (Result<Bool, Error>) -> Void)
    func editRecord(userId: String, record: MedicalRecord, completion: @escaping (Result<Bool, Error>) -> Void)
    func deleteRecord(id: String, completion: @escaping (Result<Bool, Error>) -> Void)
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
    
    func saveRecord(userId: String, record: MedicalRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<MedicalHistoryRequest>()
        
        provider.request(.create(userId: userId, record: record)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editRecord(userId: String, record: MedicalRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<MedicalHistoryRequest>()
        
        provider.request(.edit(userId: userId, record: record)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteRecord(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<MedicalHistoryRequest>()
        
        provider.request(.delete(id: id)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
