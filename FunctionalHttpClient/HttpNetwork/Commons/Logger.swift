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

public class Logger {
    public static let shared = Logger()
    public var logLevel: LogLevel
    public var queue: DispatchQueue
    
    init(logLevel: LogLevel = .debug,
         queue: DispatchQueue = DispatchQueue(label: "com.cmvicentehe.FunctionalHttpClient", qos: .utility)) {
        self.logLevel = logLevel
        self.queue = queue
    }
    
    func logDebug(_ message: String) {
        self.queue.sync {
            self.log(with: .debug, message: message)
        }
    }
    
    func logInfo(_ message: String) {
        self.queue.sync {
            self.log(with: .info, message: message)
        }
    }
    
    func logError(_ message: String) {
     self.queue.sync {
        self.log(with: .error, message: message)
     }
    }

    private func log(with kind: KindOfLog, message: String) {
        switch kind {
        case .debug:
            if self.logLevel > .info {
                print("------> \(kind.rawValue) --- \(message)")
            }
        case .info:
            if self.logLevel > .error {
                print("------> \(kind.rawValue) --- \(message)")
            }
        case .error:
            if self.logLevel > .none {
                let file = #file
                let function = #function
                let line = #line
                print("------> \(kind.rawValue): in \(file)")
                print("\t\t ---> Calling to \(function): at line \(line)")
            }
        }
    }
}
