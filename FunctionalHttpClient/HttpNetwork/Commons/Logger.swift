//
//  Logger.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 16/5/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

enum KindOfLog: String {
    case debug = "DEBUG: "
    case info = "INFO: "
    case error = "ERROR: "
}

struct Logger {
    static let shared = Logger()
    let logLevel: LogLevel
    
    init(logLevel: LogLevel) {
        self.logLevel = logLevel
    }
    
    init() {
        self.init(logLevel: .debug)
    }
    #warning("TODO: Search for the best option")
    func logDebug(message: String) {
        self.log(with: .debug, message: message)
    }
    
    func logInfo(message: String) {
        self.log(with: .info, message: message)
    }
    
    func logError(message: String) {
        self.log(with: .error, message: message)
    }
    
    fileprivate func log(with kind: KindOfLog, message: String) {
        switch self.logLevel {
        case .debug:
            print("------> \(kind) --- \(message)")
        case .info:
            print("------> \(kind) --- \(message)")
        case .error:
            let file = #file
            let function = #function
            let line = #line
            print("------> \(kind): in \(file)")
            print("\t\t ---> Calling to \(function): at line \(line)")
        case .none:
            print("")
        }
    }
}
