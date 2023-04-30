import Moya

protocol RemindersWorkerLogic {
    func fetchReminders(id: String, size: Int?, completion: @escaping(Result<[Reminder], Error>) -> Void)
    func saveReminder(userId: String, reminder: Reminder, completion: @escaping (Result<Bool, Error>) -> Void)
    func editReminder(userId: String, reminder: Reminder, completion: @escaping (Result<Bool, Error>) -> Void)
    func deleteReminder(id: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

public final class RemindersWorker: RemindersWorkerLogic {
    init() { }
    
    func fetchReminders(id: String, size: Int?, completion: @escaping(Result<[Reminder], Error>) -> Void) {
        let provider = MoyaProvider<RemindersRequest>()
        
        provider.request(.fetchReminders(id: id, size: size)) { result in
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
    
    func saveReminder(userId: String, reminder: Reminder, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<RemindersRequest>()
        
        provider.request(.create(userId: userId, reminder: reminder)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editReminder(userId: String, reminder: Reminder, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<RemindersRequest>()
        
        provider.request(.edit(userId: userId, reminder: reminder)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteReminder(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<RemindersRequest>()
        
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
