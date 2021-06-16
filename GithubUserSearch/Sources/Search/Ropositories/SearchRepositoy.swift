import RxSwift
import Moya

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
