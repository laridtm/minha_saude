import Moya

enum MedicalHistoryRequest {
    case fetchMedicalHistory(id: String, options: FetchMedicalHistoryOptions)
    case create(userId: String, record: MedicalRecord)
    case edit(userId: String, record: MedicalRecord)
    case delete(id: String)
}

extension MedicalHistoryRequest: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchMedicalHistory(let id, _):
            return "/medical-record/\(id)"
        case .create(let userId, _):
            return "/medical-record/\(userId)"
        case .edit(let userId, let record):
            return "/medical-record/\(userId)/\(record.id ?? "")"
        case .delete(let id):
            return "/medical-record/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMedicalHistory:
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
        case .fetchMedicalHistory(_, let options):
            return .requestParameters(parameters: options.convertToMap(), encoding: URLEncoding.default)
        case .create(_, let record):
            return .requestJSONEncodable(record)
        case .edit(_, let record):
            return .requestJSONEncodable(record)
        case .delete:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

