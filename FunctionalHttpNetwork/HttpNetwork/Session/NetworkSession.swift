//
//  NetworkSession.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 13/5/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

struct NetworkSession {
    let urlSession: URLSession
    
    init() {
        self.urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func buildURLRequest(from resource: ApiResource) -> URLRequest? {
        guard let url = resource.urlComponents.url else {
            print("Invalid url from components")
            return nil
        }
        return URLRequest(
            url: url,
            cachePolicy: resource.cachePolicy,
            timeoutInterval: resource.timeout
        )
    }
    
    func buildResponse(from response: URLResponse) -> ApiResponse? {
        // TODO: Implement ApiResponse builder with information provided by url session
       return nil
    }
    
    func performRequest(for resource: ApiResource) -> ApiResponse? {
        guard let urlRequest = self.buildURLRequest(from: resource) else {
            print("Invalid request")
            return nil
        }
        
        var apiResponse: ApiResponse? = nil
        self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let responseNotNil = response else {
                print("Invalid response")
                return
            }
            apiResponse = self.buildResponse(from: responseNotNil)
        })
        
        return apiResponse
    }
}
