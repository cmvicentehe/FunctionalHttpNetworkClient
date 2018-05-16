//
//  ApiResponse.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 11/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

/// HTTP status codes according to https://es.wikipedia.org/wiki/Anexo:Códigos_de_estado_HTTP
enum Status {
    case info
    case success
    case clientError
    case redirection
    case serverError
    case unknown
}
 struct ApiResponse {
    var status: Status
    var urlComponents: URLComponents
    var headers: [AnyHashable: Any]?
    var data: Data?
    var error: Error?
    var logLevel: LogLevel
}
