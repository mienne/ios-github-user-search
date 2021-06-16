import RIBs
import RxSwift
import UIKit

// MARK: - DetailPresentableListener
protocol DetailPresentableListener: AnyObject {

    func detach()
}

// MARK: - DetailViewController
final class DetailViewController: UIViewController, DetailPresentable, DetailViewControllable, Storyboardable {

    typealias Dependency = Void

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    weak var listener: DetailPresentableListener?

    private var user: User!
    private var disposeBag = DisposeBag()

    deinit {
        log.debug("DetailViewController deinit")
    }
}

// MARK: - Override
extension DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        bindButton()
        configure()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        disposeBag = DisposeBag()
    }
}

// MARK: - A new instance
extension DetailViewController {

    static func create(_ user: User) -> DetailViewController {
        let viewController = self.createViewController()
        viewController.user = user
        viewController.modalPresentationStyle = .formSheet
        viewController.modalTransitionStyle = .coverVertical
        return viewController
    }
}

// MARK: - Private: Binding
private extension DetailViewController {

    func bindButton() {
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true) {
                    self?.listener?.detach()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private: UI, Layout
private extension DetailViewController {

    func configure() {
        userNameLabel.text = user.name
        if let url = URL(string: user.imageUrl) {
            thumbnailImageView.kf.setImage(with: url)
        }
    }
}
