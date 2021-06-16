import ReactorKit

enum UserAction { }

struct UserState {

    var name: String {
        return user.name
    }

    var url: String {
        return user.url
    }

    var imageUrl: String {
        return user.imageUrl
    }

    fileprivate let user: User
}

class UserCellReactor: Reactor {

    typealias Action = UserAction
    typealias State = UserState

    let initialState: UserState

    var user: User {
        return self.currentState.user
    }

    init(_ user: User) {
        self.initialState = State(user: user)
    }
}

extension UserCellReactor: Hashable {

    static func == (lhs: UserCellReactor, rhs: UserCellReactor) -> Bool {
        return lhs.user == rhs.user
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
    }
}
