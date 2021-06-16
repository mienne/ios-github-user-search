import Moya

enum GithubService {

    case searchUser(SearchUserParams)
}

extension GithubService: BaseService {

    var path: String {
        switch self {
        case .searchUser: return "/search/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .searchUser: return .get
        }
    }
    var task: Task {
        switch self {
        case .searchUser(let params):
            return .requestParameters(
                parameters: params.asDictionary(),
                encoding: URLEncoding.default
            )
        }
    }
}
