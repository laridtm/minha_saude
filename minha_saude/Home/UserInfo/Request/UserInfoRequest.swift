import Moya

enum UserInfoRequest {
    case fetchUser(id: String)
}

extension UserInfoRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchUser(let id):
            return "/profile/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUser:
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
