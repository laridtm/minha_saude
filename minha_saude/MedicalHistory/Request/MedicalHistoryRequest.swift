import Moya

enum MedicalHistoryRequest {
    case fetchMedicalHistory(id: String)
}

extension MedicalHistoryRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchMedicalHistory(let id):
            return "/medical-record/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMedicalHistory:
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

