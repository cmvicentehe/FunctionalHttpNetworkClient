//
//  LogLevel.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 11/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

public enum LogLevel: Int {
    case none = 0
    case error = 1
    case info = 2
    case debug = 3
}

extension LogLevel: Comparable {
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public static func <= (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }

    public static func > (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }

    public static func >= (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }

}
