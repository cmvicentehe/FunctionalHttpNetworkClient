//
//  NetworkSession.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 13/5/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

public protocol NetworkSessionInput {
     func buildURLRequest(from resource: ApiResource) -> URLRequest?
     func performRequest(for resource: ApiResource) -> ApiResponseProtocol?
}

public struct NetworkSession {
    
     // MARK: properties
    let urlSession: URLSession
    let logLevel: LogLevel
    
    public init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default),
                logLevel: LogLevel = .debug) {
        self.urlSession = urlSession
        self.logLevel = logLevel
    }

    // MARK: Response
    
    private func buildResponse(from response: HTTPURLResponse, data: Data?, error: Error?) -> ApiResponseProtocol? {
        let status = self.buildStatus(from: response.statusCode)
        
        guard let urlNotNil = response.url,
        let urlComponents = URLComponents(url: urlNotNil, resolvingAgainstBaseURL: true) else {
            print("Invalid url from response object")
            return nil
        }
        
        let apiResponse = ApiResponse(status: status,
                                      urlComponents: urlComponents,
                                      headers: response.allHeaderFields,
                                      data: data,
                                      error: error,
                                      logLevel: self.logLevel)
        
        return apiResponse
    }
    
    private func buildStatus(from statusCode: Int) -> Status {
        var status: Status = .unknown
        switch statusCode {
        case 100...199:
            status = .info
        case 200...299:
            status = .success
        case 300...399:
            status = .redirection
        case 400...499:
            status = .clientError
        case 500...599:
            status = .serverError
        default:
            status = .unknown
        }
        return status
    }
}

extension NetworkSession: NetworkSessionInput {
    // MARK: Request
    
    public func buildURLRequest(from resource: ApiResource) -> URLRequest? {
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
    
    public func performRequest(for resource: ApiResource) -> ApiResponseProtocol? {
        guard let urlRequest = self.buildURLRequest(from: resource) else {
            print("Invalid request")
            return nil
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var apiResponse: ApiResponseProtocol?
        self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let responseNotNil = response as? HTTPURLResponse else {
                dispatchGroup.leave()
                print("Invalid response")
                return
            }
            apiResponse = self.buildResponse(from: responseNotNil, data: data, error: error)
            dispatchGroup.leave()
        }).resume()
        
        dispatchGroup.wait()
        return apiResponse
    }
}
