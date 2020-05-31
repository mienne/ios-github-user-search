//
//  SearchInteractorTests.swift
//  GithubUserSearchTests
//
//  Created by hyeonjeong on 2020/06/01.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

@testable import GithubUserSearch

import Foundation
import Nimble
import Quick
import RxBlocking
import RxSwift

final class SearchInteractorTests: QuickSpec {

    private var interactor: SearchInteractor!
    private var useCase: SearchUseCaseMock!

    override func setUp() {
        self.continueAfterFailure = false
    }

    override func spec() {
        super.spec()

        beforeEach {
            self.useCase = SearchUseCaseMock()
            // 실제 Interator 테스트
            self.interactor = SearchInteractor(
                presenter: SearchPresentableMock(),
                useCase: self.useCase
            )
        }

        describe("초기 상태") {
            it("isLoading은 false") {
                expect(self.interactor.currentState.isLoading).to(beFalse())
            }
            it("keyword는 빈 값") {
                expect(self.interactor.currentState.keyword).to(beEmpty())
            }
            it("Users는 0명") {
                expect(self.interactor.currentState.users).to(beEmpty())
            }
            it("Section이 가지고 있는 User 인원 수는 0명") {
                expect(self.interactor.currentState.sections[0].items).to(beEmpty())
            }
        }

        describe("Action에서 Keyword 입력받음") {
            it("Keyword 값이 변함") {
                self.interactor.action.onNext(.typeKeyword("mienne"))
                expect(self.interactor.currentState.keyword).to(equal("mienne"))
            }
        }

        describe("Action에서 Search 실행함") {
            it("Searching") {
                let usersData = [
                    User(name: "m", url: "https://api.github.com/users/m", imageUrl: ""),
                    User(name: "mienne", url: "https://api.github.com/users/mienne", imageUrl: ""),
                    User(name: "me", url: "https://api.github.com/users/me", imageUrl: "")
                ]

                var loadings: [Bool] = []
                var userCount: Int = 0
                var users: [User] = []
                var sections: [SearchViewSection] = []
                let searchUser = Users(items: usersData, totalCount: usersData.count, incompleteResults: false)
                let disposeBag = DisposeBag()

                self.useCase.searchUserHandler = { _ in
                    return Single.create { observer in
                        observer(.success(searchUser))
                        return Disposables.create()
                    }
                }

                self.interactor.state
                    .subscribe(onNext: { state in
                        loadings.append(state.isLoading)
                        userCount = state.count
                        users = state.users
                        sections = state.sections
                    })
                    .disposed(by: disposeBag)

                self.interactor.action.onNext(.search)

                expect(self.interactor.currentState.isLoading).to(equal(false))
                expect(self.useCase.searchUserCallCount).to(equal(1))
                expect(loadings[0]).to(equal(false))
                expect(loadings[1]).to(equal(true))
                expect(loadings[2]).to(equal(true))
                expect(loadings[3]).to(equal(false))
                expect(userCount).to(equal(3))
                expect(users[1].name).to(equal("mienne"))
                expect(sections[0].identity).to(equal(.users))
                expect(sections[0].items.count).to(equal(3))
            }
        }
    }
}
