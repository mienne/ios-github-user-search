import RxSwift

final class DefaultSearchUseCase: SearchUseCase {

    private let repository: SearchRepositoy

    init(repository: SearchRepositoy) {
        self.repository = repository
    }

    func searchUsers(query: String, page: Int, per: Int) -> Single<Users> {
        let params = SearchUserParams(query: query, page: page, perPage: per)
        return repository.searchUsers(params: params)
    }
}
