//
//  ApiResourceExtensions.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 04/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

extension ApiResource {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        let scheme = Config.scheme
        let portString = Config.port ?? ""
        let port: Int? = Int(portString)
        urlComponents.scheme = scheme
        urlComponents.path = self.endPoint
        urlComponents.host = Config.hostUrl
        urlComponents.port = port
        return urlComponents
    }

     var headers: [AnyHashable: Any]? {
        return [ Constants.Keys.contentType:
            Constants.Keys.applicationJson]
    }
}
