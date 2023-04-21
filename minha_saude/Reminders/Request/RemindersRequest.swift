import Moya

enum RemindersRequest {
    case fetchReminders(id: String)
}

extension RemindersRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchReminders(let id):
            return "/reminders/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchReminders:
            return .get
        }
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
