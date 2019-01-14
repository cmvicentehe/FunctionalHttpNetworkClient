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
     var endPoint: String { get set }
     var urlComponents: URLComponents { get }
     var headers: [AnyHashable: Any]? { get }
     var bodyParameters: [AnyHashable: Any]? { get }
     var logLevel: LogLevel { get }
     var method: Method { get }
     var cachePolicy: URLRequest.CachePolicy { get }
     var timeout: TimeInterval { get }
}

// MARK: Default implementation
public extension ApiResource {
     var headers: [AnyHashable: Any]? {
        return nil
    }
    
     var bodyParameters: [AnyHashable: Any]? {
        return nil
    }
    
     var logLevel: LogLevel {
        return .debug
    }
    
     var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.useProtocolCachePolicy
    }
    
     var timeout: TimeInterval {
        return 30
    }
}
