import Foundation
import RxSwift

protocol SearchRepositoy: AnyObject {

    func searchUsers(params: SearchUserParams) -> Single<Users>
}
