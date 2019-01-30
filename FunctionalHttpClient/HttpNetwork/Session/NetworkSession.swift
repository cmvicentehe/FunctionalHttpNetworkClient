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
            Logger.shared.logError("Invalid url from response object")
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
            status = .info(statusCode)
        case 200...299:
            status = .success(statusCode)
        case 300...399:
            status = .redirection(statusCode)
        case 400...499:
            status = .clientError(statusCode)
        case 500...599:
            status = .serverError(statusCode)
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
            Logger.shared.logError("Invalid url from components")
            return nil
        }

        let bodyParameters = resource.bodyParameters ?? [:]
        let headers = resource.headers as? [String: String] ?? [:]
        let httpMethod = resource.method.rawValue
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])

        Logger.shared.logDebug("REQUEST")
        Logger.shared.logDebug("URL: ---> \(url)")
        Logger.shared.logDebug("Headers: ---> \(headers)")
        Logger.shared.logDebug("Method: ---> \(httpMethod)")
        Logger.shared.logDebug("Body: ---> \(bodyParameters)")

        var request = URLRequest(
            url: url,
            cachePolicy: resource.cachePolicy,
            timeoutInterval: resource.timeout)

        request.allHTTPHeaderFields = headers
        request.httpMethod = httpMethod
        request.httpBody = jsonData

        return request
    }
    
    public func performRequest(for resource: ApiResource) -> ApiResponseProtocol? {
        guard let urlRequest = self.buildURLRequest(from: resource) else {
            Logger.shared.logError("Invalid request")
            return nil
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var apiResponse: ApiResponseProtocol?
        self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let responseNotNil = response as? HTTPURLResponse else {
                dispatchGroup.leave()
                Logger.shared.logError("Invalid response")
                return
            }
            apiResponse = self.buildResponse(from: responseNotNil, data: data, error: error)
            dispatchGroup.leave()

        }).resume()
        
        dispatchGroup.wait()
        return apiResponse
    }
}
