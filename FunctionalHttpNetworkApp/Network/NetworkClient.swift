//
//  NetworkClient.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 07/10/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

protocol NetworkClientInput {
     func performRequest(at endPoint: String)
}

struct NetworkClient {
    let sessionWrapper: NetworkSession

    private func buildURLComponents(for endPoint: String) -> URLComponents {
        var urlComponents = URLComponents()
        let scheme = Constants.Services.scheme
        urlComponents.scheme = scheme
        return urlComponents
    }
    
    private func buildHeaders() -> [AnyHashable : Any]? {
        #warning("Implement!")
        return nil
    }
    
    private func buildBodyParameters() -> [AnyHashable : Any]? {
        #warning("Implement!")
        return nil
    }
}

extension NetworkClient: NetworkClientInput {
    func performRequest(at endPoint: String) {
        #warning("TODO: Add an ApiResource by Request and each one must be configurated on their own")
         #warning("TODO: Create Own Optional Model to support total functions")
//        let urlComponents = self.buildURLComponents(for: endPoint)
//        let apiResource = AppResource(urlComponents: urlComponents,
//                                      headers: self.buildHeaders(),
//                                      bodyParameters: self.buildBodyParameters(),
//                                      method: <#Method#>,
//                                      cachePolicy: <#URLRequest.CachePolicy#>,
//                                      timeout: <#TimeInterval#>)
//        let request = self.sessionWrapper.buildURLRequest(from: apiResource)
    }
}
