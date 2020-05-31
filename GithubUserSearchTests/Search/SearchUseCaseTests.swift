//
//  SearchUseCaseTests.swift
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

final class SearchUseCaseTests: QuickSpec {

    private var useCase: SearchUseCase!

    override func setUp() {
        self.continueAfterFailure = false
    }

    override func spec() {
        super.spec()

        beforeEach {
            let repository = SearchRepositoryMock()
            // 실제 UseCase 테스트
            self.useCase = DefaultSearchUseCase(repository: repository)
        }

        describe("Github 사용자 검색") {
            it("최초 로딩") {
                let result = try? self.useCase
                    .searchUsers(query: "m", page: 1, per: 30)
                    .toBlocking()
                    .first()

                expect(result?.totalCount).to(equal(3))
                expect(result?.items[1].name).to(equal("mienne"))
                expect(result?.items[1].url).to(equal("https://api.github.com/users/mienne"))
            }

            it("페이징") { }
        }
    }
}
