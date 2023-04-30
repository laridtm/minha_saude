import Moya

enum RemindersRequest {
    case fetchReminders(id: String, size: Int?)
    case create(userId: String, reminder: Reminder)
    case edit(userId: String, reminder: Reminder)
    case delete(id: String)
}

extension RemindersRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchReminders(let id, _):
            return "/reminders/\(id)"
        case .create(let userId, _):
            return "/reminders/\(userId)"
        case .edit(let userId, let reminder):
            return "/reminders/\(userId)/\(reminder.id ?? "")"
        case .delete(let id):
            return "/reminders/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchReminders:
            return .get
        case .create:
            return .post
        case .edit:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchReminders(_, let size):
            if let filterSize = size {
                return .requestParameters(parameters: ["size": filterSize], encoding: URLEncoding.default)
            }
            return .requestPlain
        case .create(_, let reminder):
            return .requestJSONEncodable(reminder)
        case .edit(_, let reminder):
            return .requestJSONEncodable(reminder)
        case .delete:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
