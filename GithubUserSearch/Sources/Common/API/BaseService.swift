import Moya

protocol BaseService: TargetType, Hashable { }

extension BaseService {

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var headers: [String: String]? {
        return [
            // TODO: - Add APIKey
            "Authorization": "token 63934fe801e4dc64ca8c699a1458ff5d3dec8aa1",
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/vnd.github.v3+json"
        ]
    }

    var sampleData: Data {
        return Data()
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
