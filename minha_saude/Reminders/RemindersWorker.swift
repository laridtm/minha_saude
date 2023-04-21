import Moya

protocol RemindersWorkerLogic {
    func fetchReminders(id: String, completion: @escaping(Result<[Reminder], Error>) -> Void)
}

public final class RemindersWorker: RemindersWorkerLogic {
    init() { }
    
    func fetchReminders(id: String, completion: @escaping(Result<[Reminder], Error>) -> Void) {
        let provider = MoyaProvider<RemindersRequest>()
        
        provider.request(.fetchReminders(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let records = try filteredResponse.map([Reminder].self)
                    
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
