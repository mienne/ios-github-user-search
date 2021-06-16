import RxSwift
import Moya

protocol SearchRepositoy: AnyObject {

    func searchUsers(params: SearchUserParams) -> Single<Users>
}

final class DefaultSearchRepositoy: SearchRepositoy {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func searchUsers(params: SearchUserParams) -> Single<Users> {
        return self.apiClient.request(GithubService.searchUser(params))
                .map(Users.self)
    }
}
