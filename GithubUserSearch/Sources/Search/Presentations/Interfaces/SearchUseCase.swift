import Foundation
import RxSwift

protocol SearchUseCase: AnyObject {

    func searchUsers(query: String, page: Int, per: Int) -> Single<Users>
}
