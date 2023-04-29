import Moya

enum MedicalHistoryRequest {
    case fetchMedicalHistory(id: String, filterType: MedicalRecordType?)
}

extension MedicalHistoryRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchMedicalHistory(let id, _):
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
        switch self {
        case .fetchMedicalHistory(_, let filter):
            guard let filter = filter else { return .requestPlain }
            return .requestParameters(parameters: ["filter": filter], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

