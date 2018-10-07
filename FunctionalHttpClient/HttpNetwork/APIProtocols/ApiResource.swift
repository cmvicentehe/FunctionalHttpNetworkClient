//
//  ApiResource.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 10/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

public enum Method {
    case get
    case post
    case put
    case delete
    case patch
}

public protocol ApiResource {
    var urlComponents: URLComponents { get set }
    var headers: [AnyHashable: Any]?  { get set }
    var bodyParameters: [AnyHashable: Any]?  { get set }
    var logLevel: LogLevel { get set }
    var method: Method { get set }
    var cachePolicy: URLRequest.CachePolicy { get set }
    var timeout: TimeInterval { get set }
}
