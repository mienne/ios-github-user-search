//
//  APIClientManager.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/06/01.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Moya
import RxSwift

protocol APIClient: class {

    func request(_ target: TargetType) -> Single<Response>
}

final class APIClientManager: MoyaProvider<MultiTarget> {

    init(plugins: [PluginType]) {
        let session = MoyaProvider<MultiTarget>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        super.init(session: session, plugins: plugins)
    }
}

// MARK: - APIClient
extension APIClientManager: APIClient {

    func request(_ target: TargetType) -> Single<Response> {
        return self.request(MultiTarget(target))
    }

    private func request(_ target: MultiTarget) -> Single<Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { value in
                let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                log.debug(message, file: #file, function: #function, line: #line)
            }, onError: { error in
                if let response = (error as? MoyaError)?.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                        log.warning(message, file: #file, function: #function, line: #line)
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                        log.warning(message, file: #file, function: #function, line: #line)
                    } else {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))"
                        log.warning(message, file: #file, function: #function, line: #line)
                    }
                } else {
                    let message = "FAILURE: \(requestString)\n\(error)"
                    log.warning(message, file: #file, function: #function, line: #line)
                }
            }, onSubscribed: {
                let message = "REQUEST: \(requestString)"
                log.debug(message, file: #file, function: #function, line: #line)
            }
        )
    }
}
