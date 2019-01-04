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
        get {
            var urlComponents = URLComponents()
            let scheme = Constants.Services.scheme
            urlComponents.scheme = scheme
            urlComponents.path = self.endPoint
            urlComponents.host = Config.hostUrl
            return urlComponents
        }
    }
}
