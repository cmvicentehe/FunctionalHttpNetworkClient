//
//  ApiResponse.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 11/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

/// HTTP status codes according to https://es.wikipedia.org/wiki/Anexo:Códigos_de_estado_HTTP
public enum Status {
    case info
    case success
    case clientError
    case redirection
    case serverError
    case unknown
}

public protocol ApiResponseProtocol {
    var status: Status { get set }
    var urlComponents: URLComponents { get set }
    var headers: [AnyHashable: Any]? { get set }
    var data: Data? { get set }
    var error: Error? { get set }
    var logLevel: LogLevel { get set }
}

struct ApiResponse: ApiResponseProtocol {
    var status: Status
    var urlComponents: URLComponents
    var headers: [AnyHashable: Any]?
    var data: Data?
    var error: Error?
    var logLevel: LogLevel
}
