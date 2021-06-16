import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {

    var scrollToBottom: ControlEvent<Void> {
        let source = base.rx.contentOffset
            .filter { [weak base] offset in
                guard let base = base else { return false }
                let height = base.frame.size.height
                let contentYoffset = offset.y
                let distanceFromBottom = base.contentSize.height - contentYoffset
                return distanceFromBottom < height
            }
            .distinctUntilChanged()
            .map { _ in }

        return ControlEvent(events: source)
    }
}
