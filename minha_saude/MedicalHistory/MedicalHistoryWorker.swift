import Moya

protocol MedicalHistoryWorkerLogic {
    func fetchMedicalHistory(
        id: String,
        options: FetchMedicalHistoryOptions,
        completion: @escaping(Result<[MedicalRecord], Error>) -> Void
    )
    func saveRecord(userId: String, record: MedicalRecord, completion: @escaping (Result<Bool, Error>) -> Void)
    func editRecord(userId: String, record: MedicalRecord, completion: @escaping (Result<Bool, Error>) -> Void)
    func deleteRecord(id: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

public final class MedicalHistoryWorker: MedicalHistoryWorkerLogic {
    
    init() { }
    
    func fetchMedicalHistory(
        id: String,
        options: FetchMedicalHistoryOptions,
        completion: @escaping(Result<[MedicalRecord], Error>) -> Void
    ) {
        let provider = MoyaProvider<MedicalHistoryRequest>()
        
        provider.request(.fetchMedicalHistory(id: id, options: options)) { result in
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

public struct FetchMedicalHistoryOptions {
    let filterType: MedicalRecordType?
    let size: Int?
    let recent: Bool?
    
    public init(filterType: MedicalRecordType? = nil, size: Int? = nil, recent: Bool? = nil) {
        self.filterType = filterType
        self.size = size
        self.recent = recent
    }
    
    public func convertToMap() -> [String: Any] {
        var result: [String: Any] = [:]
        
        if let filter = filterType {
            result["filter"] = filter
        }
        
        if let size = size {
            result["size"] = size
        }
        
        if let recent = recent {
            result["recent"] = recent
        }
        
        return result
    }
}
