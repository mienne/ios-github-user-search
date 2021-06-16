import UIKit

protocol Storyboardable: AnyObject, NSObjectProtocol {

    associatedtype Instance
    associatedtype Dependency

    static var storyboard: UIStoryboard { get }
    static var storyboardName: String { get }
    static var identifier: String { get }

    static func createViewController(_ dependency: Dependency) -> Instance
}

extension Storyboardable {

    static var storyboardName: String {
        return String(describing: self)
    }

    static var identifier: String {
        return String(describing: self)
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

extension Storyboardable where Dependency == Void {

    static func createViewController() -> Self {
        return createViewController(())
    }

    static func createViewController(_ dependency: Dependency) -> Self {
        guard let viewController = storyboard.instantiateViewController(identifier: identifier) as? Self else {
            fatalError()
        }

        return viewController
    }
}
