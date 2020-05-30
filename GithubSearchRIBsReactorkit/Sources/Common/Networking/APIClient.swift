//
//  APIClient.swift
//  GithubSearchRIBsReactorkit
//
//  Created by hyeonjeong on 2020/05/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import MoyaSugar
import RxSwift

protocol APIClient: class {

    func request(_ target: SugarTargetType, file: StaticString, function: StaticString, line: UInt) -> Single<Response>
}

extension APIClient {

    func request(_ target: SugarTargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Response> {
        return self.request(target, file: file, function: function, line: line)
    }
}

final class APIClientManager: MoyaSugarProvider<MultiSugarTarget>, APIClient {

    init(plugins: [PluginType]) {
        let session = MoyaProvider<MultiSugarTarget>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        super.init(session: session, plugins: plugins)
    }

    func request(_ target: SugarTargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        return self.rx.request(.target(target))
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { value in
                let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                log.debug(message, file: file, function: function, line: line)
            }, onError: { error in
                if let response = (error as? MoyaError)?.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                        log.warning(message, file: file, function: function, line: line)
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                        log.warning(message, file: file, function: function, line: line)
                    } else {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))"
                        log.warning(message, file: file, function: function, line: line)
                    }
                } else {
                    let message = "FAILURE: \(requestString)\n\(error)"
                    log.warning(message, file: file, function: function, line: line)
                }
            }, onSubscribed: {
                let message = "REQUEST: \(requestString)"
                log.debug(message, file: file, function: function, line: line)
            }
        )
    }
}
