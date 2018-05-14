//
//  ApiResponse.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 11/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

enum Status {
    case success
    case error
    case unknown
}

protocol ApiResponse {
    var status: Status { get set }
    var url: URLComponents { get set }
    var headers: [AnyHashable: Any]?  { get set }
    var data: Data?  { get set }
    var error: Error? { get set }
    var logLevel: LogLevel { get set }
}
