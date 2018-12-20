//
//  AppResource.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 19/12/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

struct AppResource {
    var urlComponents: URLComponents
    var headers: [AnyHashable: Any]?
    var bodyParameters: [AnyHashable: Any]?
    var logLevel: LogLevel
    var method: FunctionalHttpClient.Method
    var cachePolicy: URLRequest.CachePolicy
    var timeout: TimeInterval
}

extension AppResource: ApiResource {}
