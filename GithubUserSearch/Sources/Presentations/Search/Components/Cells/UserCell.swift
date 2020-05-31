//
//  UserCell.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import UIKit
import BonMot
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

class UserCell: UITableViewCell {

    static let identifier = "UserCell"

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "".styled(with: Style.name)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()

    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "".styled(with: Style.url)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()

    private lazy var thumbnameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Override
extension UserCell {

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        urlLabel.text = nil
        thumbnameImageView.image = nil
    }
}

// MARK: - Cell
extension UserCell {

    func configure(_ reactor: UserCellReactor) {
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.url }
            .distinctUntilChanged()
            .bind(to: urlLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { URL(string: $0.imageUrl) }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] url in
                self?.thumbnameImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private: UI, Layout
private extension UserCell {

    func configureUI() {
        self.contentView.addSubview(thumbnameImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(urlLabel)
    }

    func configureLayout() {
        thumbnameImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnameImageView.snp.trailing).offset(5)
            $0.top.equalTo(thumbnameImageView.snp.top)
            $0.trailing.equalToSuperview().offset(-5)
        }

        urlLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.top).offset(10)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
            $0.bottom.equalTo(thumbnameImageView.snp.bottom)
        }
    }
}

// MARK: - Private: Constants
private extension UserCell {

    enum Style {

        static let name = StringStyle([
            .font(UIFont.systemFont(ofSize: 14, weight: .bold)),
            .color(.label)
        ])

        static let url = StringStyle([
            .font(UIFont.systemFont(ofSize: 12)),
            .color(.label)
        ])
    }
}
