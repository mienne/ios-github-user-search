//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import UIKit
import BonMot
import ReactorKit
import RIBs
import RxCocoa
import RxSwift
import SnapKit
import RxOptional
import RxDataSources

// MARK: - SearchPresentableListener
protocol SearchPresentableListener: class {

    var state: Observable<SearchViewState> { get }
    var action: ActionSubject<SearchViewAction> { get }
}

// MARK: - SearchViewController
final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {

    typealias Dependency = Void
    typealias DataSource = RxTableViewSectionedReloadDataSource<SearchViewSection>

    weak var listener: SearchPresentableListener?

    private let searchInputView = SearchInputView()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        return tableView
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.isHidden = true
        indicatorView.style = .large
        return indicatorView
    }()

    private var disposeBag = DisposeBag()

    private lazy var usersRelay: PublishRelay<Users> = PublishRelay()
}

// MARK: - Override
extension SearchViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()

        guard let action = self.listener?.action,
            let state = self.listener?.state else {
                return
        }
        let reactor = (state, action)
        bindSearchBar(reactor)
        bindTableView(reactor)
        bindIndicatorView(reactor)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - SearchViewControllable
extension SearchViewController {

    func present(viewControllable: ViewControllable, completion: (() -> Void)?) {
        navigationController?.present(viewControllable.uiviewController, animated: true, completion: completion)
    }
}

// MARK: - Private: UI, Layout
private extension SearchViewController {

    func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(searchInputView)
        self.view.addSubview(tableView)
        self.view.addSubview(indicatorView)
        self.searchInputView.searchBar.becomeFirstResponder()
    }

    func configureLayout() {
        searchInputView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchInputView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        indicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
        }
    }

    func createDataSource() -> DataSource {
        return DataSource(configureCell: { _, tableView, indexPath, sectionItem in
            switch sectionItem {
            case .user(let reactor):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
                    return UITableViewCell()
                }
                cell.configure(reactor)
                return cell
            }
        })
    }
}

// MARK: - Private: Binding
private extension SearchViewController {

    func bindSearchBar(_ reactor: SearchViewReactor) {
        let searchBar = searchInputView.searchBar.rx.text
            .skip(1)
            .filterNil()
            .distinctUntilChanged()
            .publish()

        searchBar
            .map { SearchViewAction.typeKeyword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        searchBar
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { _ in SearchViewAction.search }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        searchBar.connect().disposed(by: disposeBag)

        reactor.state.map { "\($0.count)\(R.string.localizables.search_input_number())" }
            .bind(to: searchInputView.numberLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func bindTableView(_ reactor: SearchViewReactor) {
        reactor.state.map { $0.sections }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(dataSource: createDataSource()))
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .map { SearchViewAction.routeToDetail($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        tableView.rx.didEndDragging
            .bind(to: searchInputView.rx.hideKeyboard)
            .disposed(by: disposeBag)

        tableView.rx.scrollToBottom
            .skip(1)
            .map { SearchViewAction.searchNext }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindIndicatorView(_ reactor: SearchViewReactor) {
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

// MARK: - Storyboardable
extension SearchViewController: Storyboardable { }

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
