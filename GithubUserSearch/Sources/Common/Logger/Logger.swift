//
//  Logger.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import CocoaLumberjack

// 출처: - https://github.com/devxoul/Drrrible/blob/master/Drrrible/Sources/Logging/Logger.swift
let log = Logger()

final class Logger {

    private let logger = DDOSLogger.sharedInstance

    init() {
        setenv("XcodeColors", "YES", 0)

        logger.logFormatter = LogFormatter()
        DDLog.add(logger)

        let fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
}

// MARK: - Logging
extension Logger {

    func error(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogError(message, file: file, function: function, line: line)
    }

    func warning( _ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogWarn(message, file: file, function: function, line: line)
    }

    func info(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogInfo(message, file: file, function: function, line: line)
    }

    func debug(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogDebug(message, file: file, function: function, line: line)
    }

    func verbose(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogVerbose(message, file: file, function: function, line: line)
    }
}

// MARK: - Private: Utils
private extension Logger {

    func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }
}
