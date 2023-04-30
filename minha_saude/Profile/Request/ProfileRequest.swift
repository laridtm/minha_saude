import Moya

enum ProfileRequest {
    case fetchProfile(userId: String)
    case saveProfile(profile: UserProfile)
}

extension ProfileRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchProfile(let id):
            return "/profile/\(id)"
        case .saveProfile:
            return "profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchProfile:
            return .get
        case .saveProfile:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchProfile:
            return .requestPlain
        case .saveProfile(let profile):
            return .requestJSONEncodable(profile)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

