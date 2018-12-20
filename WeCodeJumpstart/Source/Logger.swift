//
//  Logger.swift
//  WeCodeJumpstart
//
//  Created by Jereme Claussen on 1/4/19.
//  Copyright © 2019 WeCode. All rights reserved.
//

import Foundation

let log = Logger()

enum LogLevel: String {
    case debug, info, event, warn, error

    var prefixEmoji: String {
        switch self {
        case .debug: return "🐞"
        case .info:  return "ℹ️"
        case .event: return "📆"
        case .warn:  return "⚠️"
        case .error: return "💣"
        }
    }
}

class Logger {
    func debug(_ message: String) {
        consoleLog(logLevel: .debug, message: message)
    }

    func info(_ message: String) {
        consoleLog(logLevel: .info, message: message)
    }

    func event(_ message: String) {
        consoleLog(logLevel: .event, message: message)
    }

    func warn(_ message: String) {
        consoleLog(logLevel: .warn, message: message)
    }

    func error(_ message: String) {
        consoleLog(logLevel: .error, message: message)
    }

    private func consoleLog(logLevel: LogLevel, message: String) {
        print("\(logLevel.prefixEmoji) \(logLevel.rawValue): \(message)")
    }
}
