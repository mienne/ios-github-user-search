//
//  InputView.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import UIKit
import BonMot
import SnapKit
import RxSwift
import RxCocoa

class SearchInputView: UIView {

    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.placeholder = R.string.localizables.search_input_placeholder()
        return searchBar
    }()

    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "0 \(R.string.localizables.search_input_number())".styled(with: Style.number)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Private: UI, Layout
private extension SearchInputView {

    func configureUI() {
        self.addSubview(searchBar)
        self.addSubview(numberLabel)
    }

    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        numberLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Private: Constants
private extension SearchInputView {

    enum Style {

        static let number = StringStyle([
            .font(UIFont.systemFont(ofSize: 12)),
            .color(UIColor.secondaryLabel)
        ])
    }
}

extension Reactive where Base: SearchInputView {

    var hideKeyboard: Binder<Bool> {
        return Binder(self.base) { base, _ in
            if base.searchBar.isFirstResponder {
                base.searchBar.resignFirstResponder()
            }
        }
    }

    var showKeyboard: Binder<Bool> {
        return Binder(self.base) { base, _ in
            base.searchBar.becomeFirstResponder()
        }
    }
}
