import Foundation
import RxDataSources

struct SearchViewSection: Equatable {

    enum Identity: String {

        case users
    }

    let identity: Identity
    var items: [Item]
}

extension SearchViewSection: SectionModelType {

    init(original: SearchViewSection, items: [Item]) {
        self = SearchViewSection(identity: original.identity, items: items)
    }
}

extension SearchViewSection {

    enum Item: Hashable {

        case user(UserCellReactor)
    }
}

extension SearchViewSection.Item: IdentifiableType {

    var identity: String {
        return "\(self.hashValue)"
    }
}
